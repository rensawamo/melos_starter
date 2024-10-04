import 'package:flutter/material.dart';

enum AppErrorType {
  networkError,
  socketException,
  grpcError,
  tokenSaveError,
  conflictError,
  jsonParsingError,
  jsonEncodingError,
  videoProcessingError,
  argumentError,
  authenticationError,
  validationError,
  internalServerError,
  forbidden,
  notFound,
  unknownError,
  userError,
  notificationNotAvailableYet,
}

class AppError implements Exception {
  final AppErrorType type;
  final int? code;
  final String? details;

  AppError(
    this.type, {
    this.code,
    this.details,
  }) {
    debugPrint(toString());
  }

  @override
  String toString() {
    return 'AppErrorType: $type';
  }

  // Factory constructors for different error types
  factory AppError.networkError() => AppError(
        AppErrorType.networkError,
      );

  factory AppError.socketException() => AppError(AppErrorType.socketException);

  factory AppError.grpcError(int code, String details) =>
      AppError(AppErrorType.grpcError, code: code, details: details);

  factory AppError.tokenSaveError() => AppError(AppErrorType.tokenSaveError);

  factory AppError.conflictError() => AppError(AppErrorType.conflictError);

  factory AppError.jsonParsingError() =>
      AppError(AppErrorType.jsonParsingError);

  factory AppError.jsonEncodingError() =>
      AppError(AppErrorType.jsonEncodingError);

  factory AppError.videoProcessingError() =>
      AppError(AppErrorType.videoProcessingError);

  factory AppError.argumentError(String message) =>
      AppError(AppErrorType.argumentError);

  factory AppError.authenticationError() =>
      AppError(AppErrorType.authenticationError);

  factory AppError.validationError(String message) =>
      AppError(AppErrorType.validationError);

  factory AppError.internalServerError() => AppError(
        AppErrorType.internalServerError,
      );

  factory AppError.forbidden() => AppError(AppErrorType.forbidden);

  factory AppError.notFound() => AppError(AppErrorType.notFound);

  factory AppError.unknownError(String? message) =>
      AppError(AppErrorType.unknownError, details: message);

  factory AppError.userError() => AppError(
        AppErrorType.userError,
      );

  factory AppError.notificationNotAvailableYet() => AppError(
        AppErrorType.notificationNotAvailableYet,
      );
}
