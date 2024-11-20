// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TokenState {
  String get token => throw _privateConstructorUsedError;

  /// Create a copy of TokenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenStateCopyWith<TokenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenStateCopyWith<$Res> {
  factory $TokenStateCopyWith(
          TokenState value, $Res Function(TokenState) then) =
      _$TokenStateCopyWithImpl<$Res, TokenState>;
  @useResult
  $Res call({String token});
}

/// @nodoc
class _$TokenStateCopyWithImpl<$Res, $Val extends TokenState>
    implements $TokenStateCopyWith<$Res> {
  _$TokenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TokenStateImplCopyWith<$Res>
    implements $TokenStateCopyWith<$Res> {
  factory _$$TokenStateImplCopyWith(
          _$TokenStateImpl value, $Res Function(_$TokenStateImpl) then) =
      __$$TokenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String token});
}

/// @nodoc
class __$$TokenStateImplCopyWithImpl<$Res>
    extends _$TokenStateCopyWithImpl<$Res, _$TokenStateImpl>
    implements _$$TokenStateImplCopyWith<$Res> {
  __$$TokenStateImplCopyWithImpl(
      _$TokenStateImpl _value, $Res Function(_$TokenStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TokenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_$TokenStateImpl(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TokenStateImpl implements _TokenState {
  const _$TokenStateImpl({this.token = ''});

  @override
  @JsonKey()
  final String token;

  @override
  String toString() {
    return 'TokenState(token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenStateImpl &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(runtimeType, token);

  /// Create a copy of TokenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenStateImplCopyWith<_$TokenStateImpl> get copyWith =>
      __$$TokenStateImplCopyWithImpl<_$TokenStateImpl>(this, _$identity);
}

abstract class _TokenState implements TokenState {
  const factory _TokenState({final String token}) = _$TokenStateImpl;

  @override
  String get token;

  /// Create a copy of TokenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenStateImplCopyWith<_$TokenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
