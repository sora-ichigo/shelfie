// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registration_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RegistrationFormData {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get passwordConfirmation => throw _privateConstructorUsedError;
  bool get isPasswordObscured => throw _privateConstructorUsedError;
  bool get isPasswordConfirmationObscured => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegistrationFormDataCopyWith<RegistrationFormData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegistrationFormDataCopyWith<$Res> {
  factory $RegistrationFormDataCopyWith(RegistrationFormData value,
          $Res Function(RegistrationFormData) then) =
      _$RegistrationFormDataCopyWithImpl<$Res, RegistrationFormData>;
  @useResult
  $Res call(
      {String email,
      String password,
      String passwordConfirmation,
      bool isPasswordObscured,
      bool isPasswordConfirmationObscured});
}

/// @nodoc
class _$RegistrationFormDataCopyWithImpl<$Res,
        $Val extends RegistrationFormData>
    implements $RegistrationFormDataCopyWith<$Res> {
  _$RegistrationFormDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? passwordConfirmation = null,
    Object? isPasswordObscured = null,
    Object? isPasswordConfirmationObscured = null,
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
      passwordConfirmation: null == passwordConfirmation
          ? _value.passwordConfirmation
          : passwordConfirmation // ignore: cast_nullable_to_non_nullable
              as String,
      isPasswordObscured: null == isPasswordObscured
          ? _value.isPasswordObscured
          : isPasswordObscured // ignore: cast_nullable_to_non_nullable
              as bool,
      isPasswordConfirmationObscured: null == isPasswordConfirmationObscured
          ? _value.isPasswordConfirmationObscured
          : isPasswordConfirmationObscured // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegistrationFormDataImplCopyWith<$Res>
    implements $RegistrationFormDataCopyWith<$Res> {
  factory _$$RegistrationFormDataImplCopyWith(_$RegistrationFormDataImpl value,
          $Res Function(_$RegistrationFormDataImpl) then) =
      __$$RegistrationFormDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      String password,
      String passwordConfirmation,
      bool isPasswordObscured,
      bool isPasswordConfirmationObscured});
}

/// @nodoc
class __$$RegistrationFormDataImplCopyWithImpl<$Res>
    extends _$RegistrationFormDataCopyWithImpl<$Res, _$RegistrationFormDataImpl>
    implements _$$RegistrationFormDataImplCopyWith<$Res> {
  __$$RegistrationFormDataImplCopyWithImpl(_$RegistrationFormDataImpl _value,
      $Res Function(_$RegistrationFormDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? passwordConfirmation = null,
    Object? isPasswordObscured = null,
    Object? isPasswordConfirmationObscured = null,
  }) {
    return _then(_$RegistrationFormDataImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      passwordConfirmation: null == passwordConfirmation
          ? _value.passwordConfirmation
          : passwordConfirmation // ignore: cast_nullable_to_non_nullable
              as String,
      isPasswordObscured: null == isPasswordObscured
          ? _value.isPasswordObscured
          : isPasswordObscured // ignore: cast_nullable_to_non_nullable
              as bool,
      isPasswordConfirmationObscured: null == isPasswordConfirmationObscured
          ? _value.isPasswordConfirmationObscured
          : isPasswordConfirmationObscured // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$RegistrationFormDataImpl implements _RegistrationFormData {
  const _$RegistrationFormDataImpl(
      {this.email = '',
      this.password = '',
      this.passwordConfirmation = '',
      this.isPasswordObscured = true,
      this.isPasswordConfirmationObscured = true});

  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String password;
  @override
  @JsonKey()
  final String passwordConfirmation;
  @override
  @JsonKey()
  final bool isPasswordObscured;
  @override
  @JsonKey()
  final bool isPasswordConfirmationObscured;

  @override
  String toString() {
    return 'RegistrationFormData(email: $email, password: $password, passwordConfirmation: $passwordConfirmation, isPasswordObscured: $isPasswordObscured, isPasswordConfirmationObscured: $isPasswordConfirmationObscured)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegistrationFormDataImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.passwordConfirmation, passwordConfirmation) ||
                other.passwordConfirmation == passwordConfirmation) &&
            (identical(other.isPasswordObscured, isPasswordObscured) ||
                other.isPasswordObscured == isPasswordObscured) &&
            (identical(other.isPasswordConfirmationObscured,
                    isPasswordConfirmationObscured) ||
                other.isPasswordConfirmationObscured ==
                    isPasswordConfirmationObscured));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password,
      passwordConfirmation, isPasswordObscured, isPasswordConfirmationObscured);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegistrationFormDataImplCopyWith<_$RegistrationFormDataImpl>
      get copyWith =>
          __$$RegistrationFormDataImplCopyWithImpl<_$RegistrationFormDataImpl>(
              this, _$identity);
}

abstract class _RegistrationFormData implements RegistrationFormData {
  const factory _RegistrationFormData(
      {final String email,
      final String password,
      final String passwordConfirmation,
      final bool isPasswordObscured,
      final bool isPasswordConfirmationObscured}) = _$RegistrationFormDataImpl;

  @override
  String get email;
  @override
  String get password;
  @override
  String get passwordConfirmation;
  @override
  bool get isPasswordObscured;
  @override
  bool get isPasswordConfirmationObscured;
  @override
  @JsonKey(ignore: true)
  _$$RegistrationFormDataImplCopyWith<_$RegistrationFormDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
