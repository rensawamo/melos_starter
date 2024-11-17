import 'dart:async';
import 'dart:io';

import 'package:core_foundation/foundation.dart';
import 'package:core_network/retry_utility/default_retry_evaluator.dart';
import 'package:core_network/retry_utility/retry_status.dart';
import 'package:core_repository/repository.dart';
import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required this.dio,
    required this.tokenRepository,
    this.logPrint,
    this.retries = 5,
    this.retryDelays = const [
      Duration(milliseconds: 100 * 1 * 1),
      Duration(milliseconds: 100 * 2 * 2),
      Duration(milliseconds: 100 * 3 * 3),
      Duration(milliseconds: 100 * 4 * 4),
      Duration(milliseconds: 100 * 5 * 5),
    ],
    RetryEvaluator? retryEvaluator,
    this.ignoreRetryEvaluatorExceptions = false,
    this.retryableExtraStatuses = const {},
  }) : _retryEvaluator = retryEvaluator ??
            DefaultRetryEvaluator({
              ...defaultRetryableStatuses,
              ...retryableExtraStatuses,
            }).evaluate {
    if (retryEvaluator != null && retryableExtraStatuses.isNotEmpty) {
      throw ArgumentError(
        '[retryableExtraStatuses] can only be used if [retryEvaluator]'
            ' is not provided. '
            'Please set either [retryableExtraStatuses] or [retryEvaluator],'
            ' but not both.',
        'retryableExtraStatuses',
      );
    }

    if (retries < 0) {
      throw ArgumentError(
        '[retries] must be greater than or equal to 0.',
        'retries',
      );
    }
  }

  final Dio dio;
  final TokenRepository tokenRepository;
  final void Function(String message)? logPrint;
  int retries;
  final bool ignoreRetryEvaluatorExceptions;
  final List<Duration> retryDelays;
  final RetryEvaluator _retryEvaluator;
  final Set<int> retryableExtraStatuses;

  static final FutureOr<bool> Function(DioException error, int attempt)
      defaultRetryEvaluator =
      DefaultRetryEvaluator(defaultRetryableStatuses).evaluate;

  Future<bool> _shouldRetry(DioException error, int attempt) async {
    try {
      return await _retryEvaluator(error, attempt);
    } catch (e) {
      logger.e('Exception in _retryEvaluator: $e');
      if (!ignoreRetryEvaluatorExceptions) {
        rethrow;
      }
    }
    return true;
  }

  Future<void> _refreshTokenAndRetry(
    DioException err,
    ErrorInterceptorHandler handler,
    int attempt,
  ) async {
    try {
      String newToken;
      retries = 2;

      if (attempt == 1) {
        newToken = await tokenRepository.loadToken();
        logger.i(
          '[${err.requestOptions.path}] Attempt $attempt: Loading token from storage.',
        );
      } else {
        newToken = await tokenRepository.refreshToken();
        logger.i(
          '[${err.requestOptions.path}] Attempt $attempt: Refreshing token.',
        );
      }

      err.requestOptions.headers[AppEndpoint.headerAuthorization] =
          'Bearer $newToken';

      final response = await dio.fetch<void>(err.requestOptions);
      handler.resolve(response);
    } catch (e) {
      logger.e(
        '[${err.requestOptions.path}] Attempt $attempt: Exception during token operation. Error: $e',
      );
      super.onError(err, handler);
    }
  }

  @override
  Future<dynamic> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      logger.w(
        '[${err.requestOptions.path}] Unauthorized error, attempting'
        ' token refresh.',
      );
      try {
        if (err.response?.statusCode == HttpStatus.unauthorized) {
          logger.w(
            '[${err.requestOptions.path}] Unauthorized error, attempting token refresh.',
          );

          final attempt = err.requestOptions._attempt + 1;
          err.requestOptions._attempt = attempt;

          if (attempt > retries) {
            logger.e(
              '[${err.requestOptions.path}] Max retry attempts reached for Unauthorized error.',
            );
            return super.onError(err, handler);
          }

          return _refreshTokenAndRetry(err, handler, attempt);
        }
      } catch (e) {
        logger.e(
          '[${err.requestOptions.path}] Exception during token operation. Error: $e',
        );
        super.onError(err, handler);
      }
    }

    if (err.requestOptions.disableRetry) {
      logger.w('[${err.requestOptions.path}] Retry disabled for this request.');
      return super.onError(err, handler);
    }

    bool isRequestCancelled() =>
        err.requestOptions.cancelToken?.isCancelled ?? false;
    final attempt = err.requestOptions._attempt + 1;
    err.requestOptions._attempt = attempt;
    logger.i(
      '[${err.requestOptions.path}] Attempt $attempt: Retrying '
      'request after error.',
    );

    final shouldRetry = attempt <= retries && await _shouldRetry(err, attempt);
    logger.i('shouldRetry: $shouldRetry');

    if (!shouldRetry) {
      return super.onError(err, handler);
    }

    final delay = getDelay(attempt);
    logger.w(
      '[${err.requestOptions.path}] Error during request, retrying... '
      '(Attempt: $attempt/$retries, '
      'Wait: ${delay.inMilliseconds} ms, Error: ${err.error ?? err})',
    );

    var requestOptions = err.requestOptions;
    if (requestOptions.data is FormData) {
      requestOptions = recreateOptions(err.requestOptions);
    }

    if (delay != Duration.zero) {
      await Future<void>.delayed(delay);
    }
    if (isRequestCancelled()) {
      logger.i(
        '[${err.requestOptions.path}] Request was cancelled, stopping retries.',
      );
      return super.onError(err, handler);
    }

    try {
      await dio
          .fetch<void>(requestOptions)
          .then((value) => handler.resolve(value));
    } on DioException catch (e) {
      super.onError(e, handler);
    }
  }

  Duration getDelay(int attempt) {
    if (retryDelays.isEmpty) return Duration.zero;
    return attempt - 1 < retryDelays.length
        ? retryDelays[attempt - 1]
        : retryDelays.last;
  }

  RequestOptions recreateOptions(RequestOptions options) {
    if (options.data is! FormData) {
      throw ArgumentError(
        'requestOptions.data is not FormData',
        'requestOptions',
      );
    }
    final formData = options.data as FormData;
    final newFormData = formData.clone();
    return options.copyWith(data: newFormData);
  }
}

const _kDisableRetryKey = 'ro_disable_retry';

extension RequestOptionsX on RequestOptions {
  static const _kAttemptKey = 'ro_attempt';

  int get attempt => _attempt;

  bool get disableRetry => (extra[_kDisableRetryKey] as bool?) ?? false;

  set disableRetry(bool value) => extra[_kDisableRetryKey] = value;

  int get _attempt => (extra[_kAttemptKey] as int?) ?? 0;

  set _attempt(int value) => extra[_kAttemptKey] = value;
}

extension OptionsX on Options {
  bool get disableRetry => (extra?[_kDisableRetryKey] as bool?) ?? false;

  set disableRetry(bool value) {
    extra = Map.of(extra ??= <String, dynamic>{});
    extra![_kDisableRetryKey] = value;
  }
}
