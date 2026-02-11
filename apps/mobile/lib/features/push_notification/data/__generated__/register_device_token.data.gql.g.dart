// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_device_token.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GRegisterDeviceTokenData> _$gRegisterDeviceTokenDataSerializer =
    _$GRegisterDeviceTokenDataSerializer();
Serializer<GRegisterDeviceTokenData_registerDeviceToken>
    _$gRegisterDeviceTokenDataRegisterDeviceTokenSerializer =
    _$GRegisterDeviceTokenData_registerDeviceTokenSerializer();

class _$GRegisterDeviceTokenDataSerializer
    implements StructuredSerializer<GRegisterDeviceTokenData> {
  @override
  final Iterable<Type> types = const [
    GRegisterDeviceTokenData,
    _$GRegisterDeviceTokenData
  ];
  @override
  final String wireName = 'GRegisterDeviceTokenData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GRegisterDeviceTokenData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.registerDeviceToken;
    if (value != null) {
      result
        ..add('registerDeviceToken')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GRegisterDeviceTokenData_registerDeviceToken)));
    }
    return result;
  }

  @override
  GRegisterDeviceTokenData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GRegisterDeviceTokenDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'registerDeviceToken':
          result.registerDeviceToken.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GRegisterDeviceTokenData_registerDeviceToken))!
              as GRegisterDeviceTokenData_registerDeviceToken);
          break;
      }
    }

    return result.build();
  }
}

class _$GRegisterDeviceTokenData_registerDeviceTokenSerializer
    implements
        StructuredSerializer<GRegisterDeviceTokenData_registerDeviceToken> {
  @override
  final Iterable<Type> types = const [
    GRegisterDeviceTokenData_registerDeviceToken,
    _$GRegisterDeviceTokenData_registerDeviceToken
  ];
  @override
  final String wireName = 'GRegisterDeviceTokenData_registerDeviceToken';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GRegisterDeviceTokenData_registerDeviceToken object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.userId;
    if (value != null) {
      result
        ..add('userId')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.platform;
    if (value != null) {
      result
        ..add('platform')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.createdAt;
    if (value != null) {
      result
        ..add('createdAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    return result;
  }

  @override
  GRegisterDeviceTokenData_registerDeviceToken deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GRegisterDeviceTokenData_registerDeviceTokenBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'platform':
          result.platform = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
      }
    }

    return result.build();
  }
}

class _$GRegisterDeviceTokenData extends GRegisterDeviceTokenData {
  @override
  final String G__typename;
  @override
  final GRegisterDeviceTokenData_registerDeviceToken? registerDeviceToken;

  factory _$GRegisterDeviceTokenData(
          [void Function(GRegisterDeviceTokenDataBuilder)? updates]) =>
      (GRegisterDeviceTokenDataBuilder()..update(updates))._build();

  _$GRegisterDeviceTokenData._(
      {required this.G__typename, this.registerDeviceToken})
      : super._();
  @override
  GRegisterDeviceTokenData rebuild(
          void Function(GRegisterDeviceTokenDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRegisterDeviceTokenDataBuilder toBuilder() =>
      GRegisterDeviceTokenDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRegisterDeviceTokenData &&
        G__typename == other.G__typename &&
        registerDeviceToken == other.registerDeviceToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, registerDeviceToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRegisterDeviceTokenData')
          ..add('G__typename', G__typename)
          ..add('registerDeviceToken', registerDeviceToken))
        .toString();
  }
}

class GRegisterDeviceTokenDataBuilder
    implements
        Builder<GRegisterDeviceTokenData, GRegisterDeviceTokenDataBuilder> {
  _$GRegisterDeviceTokenData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GRegisterDeviceTokenData_registerDeviceTokenBuilder? _registerDeviceToken;
  GRegisterDeviceTokenData_registerDeviceTokenBuilder get registerDeviceToken =>
      _$this._registerDeviceToken ??=
          GRegisterDeviceTokenData_registerDeviceTokenBuilder();
  set registerDeviceToken(
          GRegisterDeviceTokenData_registerDeviceTokenBuilder?
              registerDeviceToken) =>
      _$this._registerDeviceToken = registerDeviceToken;

  GRegisterDeviceTokenDataBuilder() {
    GRegisterDeviceTokenData._initializeBuilder(this);
  }

  GRegisterDeviceTokenDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _registerDeviceToken = $v.registerDeviceToken?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRegisterDeviceTokenData other) {
    _$v = other as _$GRegisterDeviceTokenData;
  }

  @override
  void update(void Function(GRegisterDeviceTokenDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRegisterDeviceTokenData build() => _build();

  _$GRegisterDeviceTokenData _build() {
    _$GRegisterDeviceTokenData _$result;
    try {
      _$result = _$v ??
          _$GRegisterDeviceTokenData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GRegisterDeviceTokenData', 'G__typename'),
            registerDeviceToken: _registerDeviceToken?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'registerDeviceToken';
        _registerDeviceToken?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GRegisterDeviceTokenData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GRegisterDeviceTokenData_registerDeviceToken
    extends GRegisterDeviceTokenData_registerDeviceToken {
  @override
  final String G__typename;
  @override
  final int? id;
  @override
  final int? userId;
  @override
  final String? platform;
  @override
  final DateTime? createdAt;

  factory _$GRegisterDeviceTokenData_registerDeviceToken(
          [void Function(GRegisterDeviceTokenData_registerDeviceTokenBuilder)?
              updates]) =>
      (GRegisterDeviceTokenData_registerDeviceTokenBuilder()..update(updates))
          ._build();

  _$GRegisterDeviceTokenData_registerDeviceToken._(
      {required this.G__typename,
      this.id,
      this.userId,
      this.platform,
      this.createdAt})
      : super._();
  @override
  GRegisterDeviceTokenData_registerDeviceToken rebuild(
          void Function(GRegisterDeviceTokenData_registerDeviceTokenBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRegisterDeviceTokenData_registerDeviceTokenBuilder toBuilder() =>
      GRegisterDeviceTokenData_registerDeviceTokenBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRegisterDeviceTokenData_registerDeviceToken &&
        G__typename == other.G__typename &&
        id == other.id &&
        userId == other.userId &&
        platform == other.platform &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, platform.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GRegisterDeviceTokenData_registerDeviceToken')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('userId', userId)
          ..add('platform', platform)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class GRegisterDeviceTokenData_registerDeviceTokenBuilder
    implements
        Builder<GRegisterDeviceTokenData_registerDeviceToken,
            GRegisterDeviceTokenData_registerDeviceTokenBuilder> {
  _$GRegisterDeviceTokenData_registerDeviceToken? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  String? _platform;
  String? get platform => _$this._platform;
  set platform(String? platform) => _$this._platform = platform;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  GRegisterDeviceTokenData_registerDeviceTokenBuilder() {
    GRegisterDeviceTokenData_registerDeviceToken._initializeBuilder(this);
  }

  GRegisterDeviceTokenData_registerDeviceTokenBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _userId = $v.userId;
      _platform = $v.platform;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRegisterDeviceTokenData_registerDeviceToken other) {
    _$v = other as _$GRegisterDeviceTokenData_registerDeviceToken;
  }

  @override
  void update(
      void Function(GRegisterDeviceTokenData_registerDeviceTokenBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GRegisterDeviceTokenData_registerDeviceToken build() => _build();

  _$GRegisterDeviceTokenData_registerDeviceToken _build() {
    final _$result = _$v ??
        _$GRegisterDeviceTokenData_registerDeviceToken._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GRegisterDeviceTokenData_registerDeviceToken', 'G__typename'),
          id: id,
          userId: userId,
          platform: platform,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
