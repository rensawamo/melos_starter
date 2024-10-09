import 'package:core_repository/repository.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final token = ref.read(tokenRepositoryProvider).cachedToken;

  final dio = Dio(
    BaseOptions(
      // baseUrl: baseUrl,
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
      talker: Talker(),
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
      ),
    ),
  );

  return dio;
}
