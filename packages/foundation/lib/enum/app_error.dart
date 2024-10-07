
import 'package:core_foundation/foundation.dart';
import 'package:dio/dio.dart';

enum AppErrorType {
  dioException,
  networkError,
  socketException,
  grpcError,
  tokenSaveError,
  conflictError,
  jsonParsingError,
  jsonEncodingError,
  argumentError,
  authenticationError,
  validationError,
  internalServerError,
  forbidden,
  notFound,
  unknownError,
  serverError,
  dataParsingError,
  userError,
  notificationNotAvailableYet,
  requestCancelled,
  badRequest,
  notAcceptable,
  requestTimeout,
  sendTimeout,
  serviceUnavailable,
  formatException,
  noInternetConnection,
}

class AppError implements Exception {
  AppError(
    this.type, {
    this.code,
    this.details,
  }) {
    logger.e('AppError: $type, Details: $details, Code: $code');
  }

  // Factory constructors for different error types
  factory AppError.networkError() => AppError(AppErrorType.networkError);

  factory AppError.socketException() => AppError(AppErrorType.socketException);

  factory AppError.grpcError(int code, String details) =>
      AppError(AppErrorType.grpcError, code: code, details: details);

  factory AppError.tokenSaveError() => AppError(AppErrorType.tokenSaveError);

  factory AppError.conflictError() => AppError(AppErrorType.conflictError);

  factory AppError.jsonParsingError() =>
      AppError(AppErrorType.jsonParsingError);

  factory AppError.jsonEncodingError() =>
      AppError(AppErrorType.jsonEncodingError);

  factory AppError.argumentError(String message) =>
      AppError(AppErrorType.argumentError, details: message);

  factory AppError.authenticationError() =>
      AppError(AppErrorType.authenticationError);

  factory AppError.validationError(String message) =>
      AppError(AppErrorType.validationError, details: message);

  factory AppError.internalServerError() =>
      AppError(AppErrorType.internalServerError);

  factory AppError.forbidden() => AppError(AppErrorType.forbidden);

  factory AppError.notFound() => AppError(AppErrorType.notFound);



  factory AppError.unknownError(String? message) =>
      AppError(AppErrorType.unknownError, details: message);

  factory AppError.serverError() => AppError(AppErrorType.serverError);

  factory AppError.dataParsingError() =>
      AppError(AppErrorType.dataParsingError);

  factory AppError.userError() => AppError(AppErrorType.userError);

  factory AppError.notificationNotAvailableYet() =>
      AppError(AppErrorType.notificationNotAvailableYet);

  factory AppError.requestCancelled() =>
      AppError(AppErrorType.requestCancelled);

  factory AppError.badRequest(String message) =>
      AppError(AppErrorType.badRequest, details: message);

  factory AppError.notAcceptable() => AppError(AppErrorType.notAcceptable);

  factory AppError.requestTimeout() => AppError(AppErrorType.requestTimeout);

  factory AppError.sendTimeout() => AppError(AppErrorType.sendTimeout);

  factory AppError.serviceUnavailable() =>
      AppError(AppErrorType.serviceUnavailable);

  factory AppError.noInternetConnection() =>
      AppError(AppErrorType.noInternetConnection);

  factory AppError.formatException() => AppError(AppErrorType.formatException);
  final AppErrorType type;
  final int? code;
  final String? details;

  @override
  String toString() {
    return 'AppErrorType: $type, Details: $details, Code: $code';
  }

  AppError fromDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return AppError.requestCancelled();
      case DioExceptionType.connectionTimeout:
        return AppError.requestTimeout();
      case DioExceptionType.receiveTimeout:
        return AppError.sendTimeout();
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final data = error.response?.data as Map<String, dynamic>?;
        final message = data?['message'] as String?;
        switch (statusCode) {
          case 400:
            return AppError.badRequest(
              message ?? 'Bad request error occurred',
            );
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
      case DioExceptionType.unknown:
        return AppError.unknownError('An unknown error occurred');
      default:
        return AppError.unknownError('An unknown error occurred');
    }
  }
}
