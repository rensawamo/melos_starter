import 'package:core_foundation/enum/app_dio_exception.dart';
import 'package:core_foundation/foundation.dart';
import 'package:dio/dio.dart';

enum AppErrorType {
  dioException('Dio Exception'),
  networkError('Network Error'),
  socketException('Socket Exception'),
  grpcError('Grpc Error'),
  tokenSaveError('Token Save Error'),
  conflictError('Conflict Error'),
  jsonParsingError('JsonParsing Error'),
  jsonEncodingError('JsonEncoding Error'),
  argumentError('Argument Error'),
  authenticationError('Authentication Error'),
  validationError('Validation Error'),
  internalServerError('Internal Server Error'),
  forbidden('For Bidden'),
  notFound('Not Found'),
  unknownError('Unknown Error'),
  serverError('Server Error'),
  dataParsingError('Data ParsingError'),
  userError('User Error'),
  notificationNotAvailableYet('Notification NotAvailableYet'),
  requestCancelled('Request Cancelled'),
  badRequest('Bad Request'),
  notAcceptable('Not Acceptable'),
  requestTimeout('Request Timeout'),
  sendTimeout('Send Timeout'),
  serviceUnavailable('Service Unavailable'),
  formatException('Format Exception'),
  ;

  const AppErrorType(this.value);
  final String value;
}

class AppError implements Exception {
  AppError(
    this.type, {
    this.code,
    this.details,
  }) {
    logger.e('AppError: $type, Details: $details, Code: $code');
  }
  factory AppError.dioException(DioException error) {
    final appDioException = AppDioException(
      AppErrorType.dioException,
    );
    return appDioException.fromDioException(error);
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

  factory AppError.formatException() => AppError(AppErrorType.formatException);
  final AppErrorType type;
  final int? code;
  final String? details;

  @override
  String toString() {
    return 'AppErrorType: $type, Details: $details, Code: $code';
  }
}
