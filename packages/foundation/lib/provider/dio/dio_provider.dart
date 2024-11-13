import 'package:core_foundation/provider/dio/dio_intercepter.dart';
import 'package:core_repository/repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(Ref ref, {bool isRequireAuthenticate = true}) {
  final talker = Talker();

  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 7),
      receiveTimeout: const Duration(seconds: 7),
      sendTimeout: const Duration(seconds: 7),
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
    talker: talker,
    tokenRepository: ref.read(tokenRepositoryProvider),
    isRequireAuthenticate: isRequireAuthenticate,
  );

  dio.interceptors.add(retryInterceptor);

  return dio;
}
