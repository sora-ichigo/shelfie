// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.schema.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GAuthErrorCode _$gAuthErrorCodeEMAIL_ALREADY_EXISTS =
    const GAuthErrorCode._('EMAIL_ALREADY_EXISTS');
const GAuthErrorCode _$gAuthErrorCodeINTERNAL_ERROR =
    const GAuthErrorCode._('INTERNAL_ERROR');
const GAuthErrorCode _$gAuthErrorCodeINVALID_CREDENTIALS =
    const GAuthErrorCode._('INVALID_CREDENTIALS');
const GAuthErrorCode _$gAuthErrorCodeINVALID_PASSWORD =
    const GAuthErrorCode._('INVALID_PASSWORD');
const GAuthErrorCode _$gAuthErrorCodeINVALID_TOKEN =
    const GAuthErrorCode._('INVALID_TOKEN');
const GAuthErrorCode _$gAuthErrorCodeNETWORK_ERROR =
    const GAuthErrorCode._('NETWORK_ERROR');
const GAuthErrorCode _$gAuthErrorCodeTOKEN_EXPIRED =
    const GAuthErrorCode._('TOKEN_EXPIRED');
const GAuthErrorCode _$gAuthErrorCodeUNAUTHENTICATED =
    const GAuthErrorCode._('UNAUTHENTICATED');
const GAuthErrorCode _$gAuthErrorCodeUSER_NOT_FOUND =
    const GAuthErrorCode._('USER_NOT_FOUND');

GAuthErrorCode _$gAuthErrorCodeValueOf(String name) {
  switch (name) {
    case 'EMAIL_ALREADY_EXISTS':
      return _$gAuthErrorCodeEMAIL_ALREADY_EXISTS;
    case 'INTERNAL_ERROR':
      return _$gAuthErrorCodeINTERNAL_ERROR;
    case 'INVALID_CREDENTIALS':
      return _$gAuthErrorCodeINVALID_CREDENTIALS;
    case 'INVALID_PASSWORD':
      return _$gAuthErrorCodeINVALID_PASSWORD;
    case 'INVALID_TOKEN':
      return _$gAuthErrorCodeINVALID_TOKEN;
    case 'NETWORK_ERROR':
      return _$gAuthErrorCodeNETWORK_ERROR;
    case 'TOKEN_EXPIRED':
      return _$gAuthErrorCodeTOKEN_EXPIRED;
    case 'UNAUTHENTICATED':
      return _$gAuthErrorCodeUNAUTHENTICATED;
    case 'USER_NOT_FOUND':
      return _$gAuthErrorCodeUSER_NOT_FOUND;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<GAuthErrorCode> _$gAuthErrorCodeValues =
    new BuiltSet<GAuthErrorCode>(const <GAuthErrorCode>[
  _$gAuthErrorCodeEMAIL_ALREADY_EXISTS,
  _$gAuthErrorCodeINTERNAL_ERROR,
  _$gAuthErrorCodeINVALID_CREDENTIALS,
  _$gAuthErrorCodeINVALID_PASSWORD,
  _$gAuthErrorCodeINVALID_TOKEN,
  _$gAuthErrorCodeNETWORK_ERROR,
  _$gAuthErrorCodeTOKEN_EXPIRED,
  _$gAuthErrorCodeUNAUTHENTICATED,
  _$gAuthErrorCodeUSER_NOT_FOUND,
]);

Serializer<GAuthErrorCode> _$gAuthErrorCodeSerializer =
    new _$GAuthErrorCodeSerializer();
Serializer<GLoginUserInput> _$gLoginUserInputSerializer =
    new _$GLoginUserInputSerializer();
Serializer<GRefreshTokenInput> _$gRefreshTokenInputSerializer =
    new _$GRefreshTokenInputSerializer();
Serializer<GRegisterUserInput> _$gRegisterUserInputSerializer =
    new _$GRegisterUserInputSerializer();

class _$GAuthErrorCodeSerializer
    implements PrimitiveSerializer<GAuthErrorCode> {
  @override
  final Iterable<Type> types = const <Type>[GAuthErrorCode];
  @override
  final String wireName = 'GAuthErrorCode';

  @override
  Object serialize(Serializers serializers, GAuthErrorCode object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  GAuthErrorCode deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GAuthErrorCode.valueOf(serialized as String);
}

class _$GLoginUserInputSerializer
    implements StructuredSerializer<GLoginUserInput> {
  @override
  final Iterable<Type> types = const [GLoginUserInput, _$GLoginUserInput];
  @override
  final String wireName = 'GLoginUserInput';

  @override
  Iterable<Object?> serialize(Serializers serializers, GLoginUserInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'password',
      serializers.serialize(object.password,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GLoginUserInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GLoginUserInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GRefreshTokenInputSerializer
    implements StructuredSerializer<GRefreshTokenInput> {
  @override
  final Iterable<Type> types = const [GRefreshTokenInput, _$GRefreshTokenInput];
  @override
  final String wireName = 'GRefreshTokenInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GRefreshTokenInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'refreshToken',
      serializers.serialize(object.refreshToken,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GRefreshTokenInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GRefreshTokenInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'refreshToken':
          result.refreshToken = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GRegisterUserInputSerializer
    implements StructuredSerializer<GRegisterUserInput> {
  @override
  final Iterable<Type> types = const [GRegisterUserInput, _$GRegisterUserInput];
  @override
  final String wireName = 'GRegisterUserInput';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GRegisterUserInput object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'password',
      serializers.serialize(object.password,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GRegisterUserInput deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GRegisterUserInputBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GLoginUserInput extends GLoginUserInput {
  @override
  final String email;
  @override
  final String password;

  factory _$GLoginUserInput([void Function(GLoginUserInputBuilder)? updates]) =>
      (new GLoginUserInputBuilder()..update(updates))._build();

  _$GLoginUserInput._({required this.email, required this.password})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(email, r'GLoginUserInput', 'email');
    BuiltValueNullFieldError.checkNotNull(
        password, r'GLoginUserInput', 'password');
  }

  @override
  GLoginUserInput rebuild(void Function(GLoginUserInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GLoginUserInputBuilder toBuilder() =>
      new GLoginUserInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GLoginUserInput &&
        email == other.email &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GLoginUserInput')
          ..add('email', email)
          ..add('password', password))
        .toString();
  }
}

class GLoginUserInputBuilder
    implements Builder<GLoginUserInput, GLoginUserInputBuilder> {
  _$GLoginUserInput? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  GLoginUserInputBuilder();

  GLoginUserInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GLoginUserInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GLoginUserInput;
  }

  @override
  void update(void Function(GLoginUserInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GLoginUserInput build() => _build();

  _$GLoginUserInput _build() {
    final _$result = _$v ??
        new _$GLoginUserInput._(
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'GLoginUserInput', 'email'),
            password: BuiltValueNullFieldError.checkNotNull(
                password, r'GLoginUserInput', 'password'));
    replace(_$result);
    return _$result;
  }
}

class _$GRefreshTokenInput extends GRefreshTokenInput {
  @override
  final String refreshToken;

  factory _$GRefreshTokenInput(
          [void Function(GRefreshTokenInputBuilder)? updates]) =>
      (new GRefreshTokenInputBuilder()..update(updates))._build();

  _$GRefreshTokenInput._({required this.refreshToken}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        refreshToken, r'GRefreshTokenInput', 'refreshToken');
  }

  @override
  GRefreshTokenInput rebuild(
          void Function(GRefreshTokenInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRefreshTokenInputBuilder toBuilder() =>
      new GRefreshTokenInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRefreshTokenInput && refreshToken == other.refreshToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRefreshTokenInput')
          ..add('refreshToken', refreshToken))
        .toString();
  }
}

class GRefreshTokenInputBuilder
    implements Builder<GRefreshTokenInput, GRefreshTokenInputBuilder> {
  _$GRefreshTokenInput? _$v;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  GRefreshTokenInputBuilder();

  GRefreshTokenInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _refreshToken = $v.refreshToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRefreshTokenInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GRefreshTokenInput;
  }

  @override
  void update(void Function(GRefreshTokenInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRefreshTokenInput build() => _build();

  _$GRefreshTokenInput _build() {
    final _$result = _$v ??
        new _$GRefreshTokenInput._(
            refreshToken: BuiltValueNullFieldError.checkNotNull(
                refreshToken, r'GRefreshTokenInput', 'refreshToken'));
    replace(_$result);
    return _$result;
  }
}

class _$GRegisterUserInput extends GRegisterUserInput {
  @override
  final String email;
  @override
  final String password;

  factory _$GRegisterUserInput(
          [void Function(GRegisterUserInputBuilder)? updates]) =>
      (new GRegisterUserInputBuilder()..update(updates))._build();

  _$GRegisterUserInput._({required this.email, required this.password})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        email, r'GRegisterUserInput', 'email');
    BuiltValueNullFieldError.checkNotNull(
        password, r'GRegisterUserInput', 'password');
  }

  @override
  GRegisterUserInput rebuild(
          void Function(GRegisterUserInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRegisterUserInputBuilder toBuilder() =>
      new GRegisterUserInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRegisterUserInput &&
        email == other.email &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRegisterUserInput')
          ..add('email', email)
          ..add('password', password))
        .toString();
  }
}

class GRegisterUserInputBuilder
    implements Builder<GRegisterUserInput, GRegisterUserInputBuilder> {
  _$GRegisterUserInput? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  GRegisterUserInputBuilder();

  GRegisterUserInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRegisterUserInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GRegisterUserInput;
  }

  @override
  void update(void Function(GRegisterUserInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRegisterUserInput build() => _build();

  _$GRegisterUserInput _build() {
    final _$result = _$v ??
        new _$GRegisterUserInput._(
            email: BuiltValueNullFieldError.checkNotNull(
                email, r'GRegisterUserInput', 'email'),
            password: BuiltValueNullFieldError.checkNotNull(
                password, r'GRegisterUserInput', 'password'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
