import 'package:core_foundation/foundation.dart';
import 'package:dio/dio.dart';

class AppDioException extends AppError {
  AppDioException(super.type, {super.code, super.details});

  AppError fromDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return AppError.requestCancelled();
      case DioExceptionType.connectionTimeout:
        return AppError.requestTimeout();
      case DioExceptionType.connectionError:
        return AppError.networkError();
      case DioExceptionType.receiveTimeout:
        return AppError.sendTimeout();
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final data = error.response?.data as Map<String, dynamic>?;
        final message = data?['message'] as String?;
        switch (statusCode) {
          case 400:
            return AppError.badRequest(message ?? 'Bad request error occurred');
          case 401:
            return AppError.authenticationError();
          case 403:
            return AppError.forbidden();
          case 404:
            return AppError.notFound();
          case 409:
            return AppError.conflictError();
          case 500:
            return AppError.internalServerError();
          case 503:
            return AppError.serviceUnavailable();
          default:
            return AppError.unknownError(
              'Unexpected error occurred: $statusCode',
            );
        }
      case DioExceptionType.sendTimeout:
        return AppError.sendTimeout();
      default:
        return AppError.unknownError('An unknown error occurred');
    }
  }
}
