import 'dart:io';

import 'package:core_repository/repository.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'dio_provider.g.dart';

class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required this.dio,
    required this.talker,
    this.maxRetries = 3,
    this.retryDelayMs = 1000,
  });

  final Dio dio;
  final int maxRetries;
  final int retryDelayMs;
  final Talker talker;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    var attempt = 0;
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

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.connectionTimeout ||
        err.response?.statusCode == HttpStatus.serviceUnavailable;
  }
}

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final token = ref.read(tokenRepositoryProvider).cachedToken;
  final talker = Talker();

  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 5),
      headers: <String, dynamic>{
        'Content-Type': 'application/json',
        'Authorization': token.isEmpty ? 'Bearer $token' : null,
      },
    ),
  );

  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
      ),
    ),
  );

  dio.interceptors.add(
    RetryInterceptor(dio: dio, talker: talker),
  );

  return dio;
}
