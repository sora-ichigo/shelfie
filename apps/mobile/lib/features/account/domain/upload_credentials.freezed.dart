// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_credentials.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UploadCredentials {
  String get token => throw _privateConstructorUsedError;
  String get signature => throw _privateConstructorUsedError;
  int get expire => throw _privateConstructorUsedError;
  String get publicKey => throw _privateConstructorUsedError;
  String get uploadEndpoint => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UploadCredentialsCopyWith<UploadCredentials> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UploadCredentialsCopyWith<$Res> {
  factory $UploadCredentialsCopyWith(
          UploadCredentials value, $Res Function(UploadCredentials) then) =
      _$UploadCredentialsCopyWithImpl<$Res, UploadCredentials>;
  @useResult
  $Res call(
      {String token,
      String signature,
      int expire,
      String publicKey,
      String uploadEndpoint});
}

/// @nodoc
class _$UploadCredentialsCopyWithImpl<$Res, $Val extends UploadCredentials>
    implements $UploadCredentialsCopyWith<$Res> {
  _$UploadCredentialsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? signature = null,
    Object? expire = null,
    Object? publicKey = null,
    Object? uploadEndpoint = null,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      signature: null == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String,
      expire: null == expire
          ? _value.expire
          : expire // ignore: cast_nullable_to_non_nullable
              as int,
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
      uploadEndpoint: null == uploadEndpoint
          ? _value.uploadEndpoint
          : uploadEndpoint // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UploadCredentialsImplCopyWith<$Res>
    implements $UploadCredentialsCopyWith<$Res> {
  factory _$$UploadCredentialsImplCopyWith(_$UploadCredentialsImpl value,
          $Res Function(_$UploadCredentialsImpl) then) =
      __$$UploadCredentialsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String token,
      String signature,
      int expire,
      String publicKey,
      String uploadEndpoint});
}

/// @nodoc
class __$$UploadCredentialsImplCopyWithImpl<$Res>
    extends _$UploadCredentialsCopyWithImpl<$Res, _$UploadCredentialsImpl>
    implements _$$UploadCredentialsImplCopyWith<$Res> {
  __$$UploadCredentialsImplCopyWithImpl(_$UploadCredentialsImpl _value,
      $Res Function(_$UploadCredentialsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? signature = null,
    Object? expire = null,
    Object? publicKey = null,
    Object? uploadEndpoint = null,
  }) {
    return _then(_$UploadCredentialsImpl(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      signature: null == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as String,
      expire: null == expire
          ? _value.expire
          : expire // ignore: cast_nullable_to_non_nullable
              as int,
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
      uploadEndpoint: null == uploadEndpoint
          ? _value.uploadEndpoint
          : uploadEndpoint // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UploadCredentialsImpl implements _UploadCredentials {
  const _$UploadCredentialsImpl(
      {required this.token,
      required this.signature,
      required this.expire,
      required this.publicKey,
      required this.uploadEndpoint});

  @override
  final String token;
  @override
  final String signature;
  @override
  final int expire;
  @override
  final String publicKey;
  @override
  final String uploadEndpoint;

  @override
  String toString() {
    return 'UploadCredentials(token: $token, signature: $signature, expire: $expire, publicKey: $publicKey, uploadEndpoint: $uploadEndpoint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UploadCredentialsImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.signature, signature) ||
                other.signature == signature) &&
            (identical(other.expire, expire) || other.expire == expire) &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey) &&
            (identical(other.uploadEndpoint, uploadEndpoint) ||
                other.uploadEndpoint == uploadEndpoint));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, token, signature, expire, publicKey, uploadEndpoint);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UploadCredentialsImplCopyWith<_$UploadCredentialsImpl> get copyWith =>
      __$$UploadCredentialsImplCopyWithImpl<_$UploadCredentialsImpl>(
          this, _$identity);
}

abstract class _UploadCredentials implements UploadCredentials {
  const factory _UploadCredentials(
      {required final String token,
      required final String signature,
      required final int expire,
      required final String publicKey,
      required final String uploadEndpoint}) = _$UploadCredentialsImpl;

  @override
  String get token;
  @override
  String get signature;
  @override
  int get expire;
  @override
  String get publicKey;
  @override
  String get uploadEndpoint;
  @override
  @JsonKey(ignore: true)
  _$$UploadCredentialsImplCopyWith<_$UploadCredentialsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
