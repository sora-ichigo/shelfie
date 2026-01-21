// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginFormData {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  bool get isPasswordObscured => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginFormDataCopyWith<LoginFormData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginFormDataCopyWith<$Res> {
  factory $LoginFormDataCopyWith(
          LoginFormData value, $Res Function(LoginFormData) then) =
      _$LoginFormDataCopyWithImpl<$Res, LoginFormData>;
  @useResult
  $Res call({String email, String password, bool isPasswordObscured});
}

/// @nodoc
class _$LoginFormDataCopyWithImpl<$Res, $Val extends LoginFormData>
    implements $LoginFormDataCopyWith<$Res> {
  _$LoginFormDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? isPasswordObscured = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      isPasswordObscured: null == isPasswordObscured
          ? _value.isPasswordObscured
          : isPasswordObscured // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginFormDataImplCopyWith<$Res>
    implements $LoginFormDataCopyWith<$Res> {
  factory _$$LoginFormDataImplCopyWith(
          _$LoginFormDataImpl value, $Res Function(_$LoginFormDataImpl) then) =
      __$$LoginFormDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String password, bool isPasswordObscured});
}

/// @nodoc
class __$$LoginFormDataImplCopyWithImpl<$Res>
    extends _$LoginFormDataCopyWithImpl<$Res, _$LoginFormDataImpl>
    implements _$$LoginFormDataImplCopyWith<$Res> {
  __$$LoginFormDataImplCopyWithImpl(
      _$LoginFormDataImpl _value, $Res Function(_$LoginFormDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? isPasswordObscured = null,
  }) {
    return _then(_$LoginFormDataImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      isPasswordObscured: null == isPasswordObscured
          ? _value.isPasswordObscured
          : isPasswordObscured // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$LoginFormDataImpl implements _LoginFormData {
  const _$LoginFormDataImpl(
      {this.email = '', this.password = '', this.isPasswordObscured = true});

  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String password;
  @override
  @JsonKey()
  final bool isPasswordObscured;

  @override
  String toString() {
    return 'LoginFormData(email: $email, password: $password, isPasswordObscured: $isPasswordObscured)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginFormDataImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.isPasswordObscured, isPasswordObscured) ||
                other.isPasswordObscured == isPasswordObscured));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, email, password, isPasswordObscured);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginFormDataImplCopyWith<_$LoginFormDataImpl> get copyWith =>
      __$$LoginFormDataImplCopyWithImpl<_$LoginFormDataImpl>(this, _$identity);
}

abstract class _LoginFormData implements LoginFormData {
  const factory _LoginFormData(
      {final String email,
      final String password,
      final bool isPasswordObscured}) = _$LoginFormDataImpl;

  @override
  String get email;
  @override
  String get password;
  @override
  bool get isPasswordObscured;
  @override
  @JsonKey(ignore: true)
  _$$LoginFormDataImplCopyWith<_$LoginFormDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
