import 'package:core_foundation/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'http_response.handler.freezed.dart';

@freezed
sealed class HttpResponseHandler<T> with _$HttpResponseHandler<T> {
  const factory HttpResponseHandler.success({T? result}) = Success<T>;
  const factory HttpResponseHandler.error({required AppError error}) = Error<T>;
}
