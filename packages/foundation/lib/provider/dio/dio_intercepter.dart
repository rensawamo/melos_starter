import 'dart:io';

import 'package:core_repository/repository.dart';
import 'package:dio/dio.dart';
import 'package:talker_flutter/talker_flutter.dart';

const String _headerAuthorization = 'Authorization';

class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required this.dio,
    required this.talker,
    required this.tokenRepository,
    required this.isRequireAuthenticate,
    this.maxRetries = 5,
    this.retryDelayMs = 1000,
  });

  final Dio dio;
  final int maxRetries;
  final int retryDelayMs;
  final Talker talker;
  final bool isRequireAuthenticate;
  final TokenRepository tokenRepository;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (isRequireAuthenticate) {
      final token = tokenRepository.cachedToken;
      options.headers[_headerAuthorization] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    var attempt = 0;
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      await _refreshToken(err, handler);
    } else {
      while (attempt < maxRetries && _shouldRetry(err)) {
        attempt++;
        talker.log('Retry attempt $attempt for ${err.requestOptions.path}');

        try {
          await Future<void>.delayed(Duration(milliseconds: retryDelayMs));
          final response = await dio.request<void>(
            err.requestOptions.path,
            options: Options(
              method: err.requestOptions.method,
              headers: err.requestOptions.headers,
            ),
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
          );
          return handler.resolve(response);
        } catch (e) {
          if (attempt >= maxRetries) {
            talker.error('Max retries reached for ${err.requestOptions.path}');
            return super.onError(err, handler);
          }
        }
      }
      return super.onError(err, handler);
    }
  }

  Future<void> _refreshToken(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      final newToken = await tokenRepository.refreshToken();
      if (newToken != null) {
        err.requestOptions.headers[_headerAuthorization] = 'Bearer $newToken';

        final options = Options(
          method: err.requestOptions.method,
          headers: err.requestOptions.headers,
        );
        final response = await dio.request<void>(
          err.requestOptions.path,
          options: options,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );
        return handler.resolve(response);
      } else {
        handler.next(err);
      }
    } catch (exception) {
      handler.next(err);
    }
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.connectionTimeout ||
        err.response?.statusCode == HttpStatus.serviceUnavailable;
  }
}
