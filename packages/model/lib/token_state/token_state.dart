import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_state.freezed.dart';

@freezed
class TokenState with _$TokenState {
  const factory TokenState({
    @Default('') String token,
    // Add more fields if needed
  }) = _TokenState;
}
