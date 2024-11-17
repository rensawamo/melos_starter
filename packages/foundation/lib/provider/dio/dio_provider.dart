
import 'package:core_foundation/provider/dio/retry_intercepter.dart';
import 'package:core_repository/repository.dart';
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
  final token = ref.read(tokenRepositoryProvider).cachedToken;

  final dio = Dio(
    BaseOptions(
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      headers: <String, dynamic>{
        'Content-Type': 'application/json',
        if (isRequireAuthenticate) 'Authorization': 'Bearer $token',
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
    tokenRepository: ref.read(tokenRepositoryProvider),
  );

  dio.interceptors.add(retryInterceptor);

  return dio;
}
