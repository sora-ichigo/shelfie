// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.schema.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GAuthErrorCode _$gAuthErrorCodeEMAIL_ALREADY_EXISTS =
    const GAuthErrorCode._('EMAIL_ALREADY_EXISTS');
const GAuthErrorCode _$gAuthErrorCodeINTERNAL_ERROR =
    const GAuthErrorCode._('INTERNAL_ERROR');
const GAuthErrorCode _$gAuthErrorCodeINVALID_PASSWORD =
    const GAuthErrorCode._('INVALID_PASSWORD');
const GAuthErrorCode _$gAuthErrorCodeNETWORK_ERROR =
    const GAuthErrorCode._('NETWORK_ERROR');

GAuthErrorCode _$gAuthErrorCodeValueOf(String name) {
  switch (name) {
    case 'EMAIL_ALREADY_EXISTS':
      return _$gAuthErrorCodeEMAIL_ALREADY_EXISTS;
    case 'INTERNAL_ERROR':
      return _$gAuthErrorCodeINTERNAL_ERROR;
    case 'INVALID_PASSWORD':
      return _$gAuthErrorCodeINVALID_PASSWORD;
    case 'NETWORK_ERROR':
      return _$gAuthErrorCodeNETWORK_ERROR;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<GAuthErrorCode> _$gAuthErrorCodeValues =
    new BuiltSet<GAuthErrorCode>(const <GAuthErrorCode>[
  _$gAuthErrorCodeEMAIL_ALREADY_EXISTS,
  _$gAuthErrorCodeINTERNAL_ERROR,
  _$gAuthErrorCodeINVALID_PASSWORD,
  _$gAuthErrorCodeNETWORK_ERROR,
]);

Serializer<GAuthErrorCode> _$gAuthErrorCodeSerializer =
    new _$GAuthErrorCodeSerializer();
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
