import 'package:core_foundation/foundation.dart';
import 'package:core_network/retry_utility/retry_intercepter.dart';
import 'package:core_repository/repository.dart';
import 'package:core_service/auth/auth_service_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(
  Ref ref, {
  bool isRequireAuthenticate = true,
  Duration connectTimeout = const Duration(seconds: 7),
  Duration receiveTimeout = const Duration(seconds: 7),
  Duration sendTimeout = const Duration(seconds: 7),
}) {
  final talker = Talker();
  final token = ref.read(tokenRepositoryProvider).token;

  final dio = Dio(
    BaseOptions(
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      headers: <String, dynamic>{
        'Content-Type': 'application/json',
        AppEndpoint.headerAuthorization: 'Bearer $token',
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

  final retryInterceptor = RetryInterceptor(
    dio: dio,
    retries: 5,
    authService: ref.read(authServiceProvider),
  );
  dio.interceptors.add(retryInterceptor);
  return dio;
}
