import 'dart:async';

sealed class Result<S, E extends Exception> {
  const Result();

  static Result<S, Exception> success<S>(S value) => Success(value);

  static Result<S, Exception> failure<S>(
    Exception exception, [
    StackTrace? stackTrace,
  ]) =>
      Failure(exception, stackTrace);

  static Future<Result<S, Exception>> capture<S>(
    FutureOr<S> Function() fn,
  ) async {
    try {
      return Success(await fn());
    } on Exception catch (e, stackTrace) {
      return Failure(e, stackTrace);
    }
  }

  static Future<Result<S, E>> captureSpecific<S, E extends Exception>(
    FutureOr<S> Function() fn,
  ) async {
    try {
      return Success(await fn());
    } on E catch (e, stackTrace) {
      return Failure(e, stackTrace);
    }
  }
}

final class Success<S, E extends Exception> extends Result<S, E> {
  const Success(this.value);
  final S value;
}

final class Failure<S, E extends Exception> extends Result<S, E> {
  const Failure(this.exception, [this.stackTrace]);
  final E exception;
  final StackTrace? stackTrace;
}
