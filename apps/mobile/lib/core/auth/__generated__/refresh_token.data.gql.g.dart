// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GRefreshTokenData> _$gRefreshTokenDataSerializer =
    new _$GRefreshTokenDataSerializer();
Serializer<GRefreshTokenData_refreshToken__base>
    _$gRefreshTokenDataRefreshTokenBaseSerializer =
    new _$GRefreshTokenData_refreshToken__baseSerializer();
Serializer<GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess>
    _$gRefreshTokenDataRefreshTokenAsMutationRefreshTokenSuccessSerializer =
    new _$GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccessSerializer();
Serializer<GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data>
    _$gRefreshTokenDataRefreshTokenAsMutationRefreshTokenSuccessDataSerializer =
    new _$GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_dataSerializer();
Serializer<GRefreshTokenData_refreshToken__asAuthError>
    _$gRefreshTokenDataRefreshTokenAsAuthErrorSerializer =
    new _$GRefreshTokenData_refreshToken__asAuthErrorSerializer();

class _$GRefreshTokenDataSerializer
    implements StructuredSerializer<GRefreshTokenData> {
  @override
  final Iterable<Type> types = const [GRefreshTokenData, _$GRefreshTokenData];
  @override
  final String wireName = 'GRefreshTokenData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GRefreshTokenData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.refreshToken;
    if (value != null) {
      result
        ..add('refreshToken')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GRefreshTokenData_refreshToken)));
    }
    return result;
  }

  @override
  GRefreshTokenData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GRefreshTokenDataBuilder();

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
        case 'refreshToken':
          result.refreshToken = serializers.deserialize(value,
                  specifiedType: const FullType(GRefreshTokenData_refreshToken))
              as GRefreshTokenData_refreshToken?;
          break;
      }
    }

    return result.build();
  }
}

class _$GRefreshTokenData_refreshToken__baseSerializer
    implements StructuredSerializer<GRefreshTokenData_refreshToken__base> {
  @override
  final Iterable<Type> types = const [
    GRefreshTokenData_refreshToken__base,
    _$GRefreshTokenData_refreshToken__base
  ];
  @override
  final String wireName = 'GRefreshTokenData_refreshToken__base';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GRefreshTokenData_refreshToken__base object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GRefreshTokenData_refreshToken__base deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GRefreshTokenData_refreshToken__baseBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccessSerializer
    implements
        StructuredSerializer<
            GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess> {
  @override
  final Iterable<Type> types = const [
    GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess,
    _$GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess
  ];
  @override
  final String wireName =
      'GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data)),
    ];

    return result;
  }

  @override
  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccessBuilder();

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
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data))!
              as GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data);
          break;
      }
    }

    return result.build();
  }
}

class _$GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_dataSerializer
    implements
        StructuredSerializer<
            GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data> {
  @override
  final Iterable<Type> types = const [
    GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data,
    _$GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data
  ];
  @override
  final String wireName =
      'GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'idToken',
      serializers.serialize(object.idToken,
          specifiedType: const FullType(String)),
      'refreshToken',
      serializers.serialize(object.refreshToken,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data
      deserialize(Serializers serializers, Iterable<Object?> serialized,
          {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_dataBuilder();

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
        case 'idToken':
          result.idToken = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'refreshToken':
          result.refreshToken = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GRefreshTokenData_refreshToken__asAuthErrorSerializer
    implements
        StructuredSerializer<GRefreshTokenData_refreshToken__asAuthError> {
  @override
  final Iterable<Type> types = const [
    GRefreshTokenData_refreshToken__asAuthError,
    _$GRefreshTokenData_refreshToken__asAuthError
  ];
  @override
  final String wireName = 'GRefreshTokenData_refreshToken__asAuthError';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GRefreshTokenData_refreshToken__asAuthError object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.code;
    if (value != null) {
      result
        ..add('code')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i3.GAuthErrorCode)));
    }
    value = object.message;
    if (value != null) {
      result
        ..add('message')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.field;
    if (value != null) {
      result
        ..add('field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.retryable;
    if (value != null) {
      result
        ..add('retryable')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  GRefreshTokenData_refreshToken__asAuthError deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GRefreshTokenData_refreshToken__asAuthErrorBuilder();

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
        case 'code':
          result.code = serializers.deserialize(value,
                  specifiedType: const FullType(_i3.GAuthErrorCode))
              as _i3.GAuthErrorCode?;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'field':
          result.field = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'retryable':
          result.retryable = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$GRefreshTokenData extends GRefreshTokenData {
  @override
  final String G__typename;
  @override
  final GRefreshTokenData_refreshToken? refreshToken;

  factory _$GRefreshTokenData(
          [void Function(GRefreshTokenDataBuilder)? updates]) =>
      (new GRefreshTokenDataBuilder()..update(updates))._build();

  _$GRefreshTokenData._({required this.G__typename, this.refreshToken})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GRefreshTokenData', 'G__typename');
  }

  @override
  GRefreshTokenData rebuild(void Function(GRefreshTokenDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRefreshTokenDataBuilder toBuilder() =>
      new GRefreshTokenDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRefreshTokenData &&
        G__typename == other.G__typename &&
        refreshToken == other.refreshToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRefreshTokenData')
          ..add('G__typename', G__typename)
          ..add('refreshToken', refreshToken))
        .toString();
  }
}

class GRefreshTokenDataBuilder
    implements Builder<GRefreshTokenData, GRefreshTokenDataBuilder> {
  _$GRefreshTokenData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GRefreshTokenData_refreshToken? _refreshToken;
  GRefreshTokenData_refreshToken? get refreshToken => _$this._refreshToken;
  set refreshToken(GRefreshTokenData_refreshToken? refreshToken) =>
      _$this._refreshToken = refreshToken;

  GRefreshTokenDataBuilder() {
    GRefreshTokenData._initializeBuilder(this);
  }

  GRefreshTokenDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _refreshToken = $v.refreshToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRefreshTokenData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GRefreshTokenData;
  }

  @override
  void update(void Function(GRefreshTokenDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRefreshTokenData build() => _build();

  _$GRefreshTokenData _build() {
    final _$result = _$v ??
        new _$GRefreshTokenData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GRefreshTokenData', 'G__typename'),
            refreshToken: refreshToken);
    replace(_$result);
    return _$result;
  }
}

class _$GRefreshTokenData_refreshToken__base
    extends GRefreshTokenData_refreshToken__base {
  @override
  final String G__typename;

  factory _$GRefreshTokenData_refreshToken__base(
          [void Function(GRefreshTokenData_refreshToken__baseBuilder)?
              updates]) =>
      (new GRefreshTokenData_refreshToken__baseBuilder()..update(updates))
          ._build();

  _$GRefreshTokenData_refreshToken__base._({required this.G__typename})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GRefreshTokenData_refreshToken__base', 'G__typename');
  }

  @override
  GRefreshTokenData_refreshToken__base rebuild(
          void Function(GRefreshTokenData_refreshToken__baseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRefreshTokenData_refreshToken__baseBuilder toBuilder() =>
      new GRefreshTokenData_refreshToken__baseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRefreshTokenData_refreshToken__base &&
        G__typename == other.G__typename;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRefreshTokenData_refreshToken__base')
          ..add('G__typename', G__typename))
        .toString();
  }
}

class GRefreshTokenData_refreshToken__baseBuilder
    implements
        Builder<GRefreshTokenData_refreshToken__base,
            GRefreshTokenData_refreshToken__baseBuilder> {
  _$GRefreshTokenData_refreshToken__base? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GRefreshTokenData_refreshToken__baseBuilder() {
    GRefreshTokenData_refreshToken__base._initializeBuilder(this);
  }

  GRefreshTokenData_refreshToken__baseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRefreshTokenData_refreshToken__base other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GRefreshTokenData_refreshToken__base;
  }

  @override
  void update(
      void Function(GRefreshTokenData_refreshToken__baseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRefreshTokenData_refreshToken__base build() => _build();

  _$GRefreshTokenData_refreshToken__base _build() {
    final _$result = _$v ??
        new _$GRefreshTokenData_refreshToken__base._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GRefreshTokenData_refreshToken__base', 'G__typename'));
    replace(_$result);
    return _$result;
  }
}

class _$GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess
    extends GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess {
  @override
  final String G__typename;
  @override
  final GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data data;

  factory _$GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess(
          [void Function(
                  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccessBuilder)?
              updates]) =>
      (new GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccessBuilder()
            ..update(updates))
          ._build();

  _$GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess._(
      {required this.G__typename, required this.data})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess',
        'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        data,
        r'GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess',
        'data');
  }

  @override
  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess rebuild(
          void Function(
                  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccessBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccessBuilder
      toBuilder() =>
          new GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccessBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess &&
        G__typename == other.G__typename &&
        data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess')
          ..add('G__typename', G__typename)
          ..add('data', data))
        .toString();
  }
}

class GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccessBuilder
    implements
        Builder<GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess,
            GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccessBuilder> {
  _$GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_dataBuilder?
      _data;
  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_dataBuilder
      get data => _$this._data ??=
          new GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_dataBuilder();
  set data(
          GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_dataBuilder?
              data) =>
      _$this._data = data;

  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccessBuilder() {
    GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess
        ._initializeBuilder(this);
  }

  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccessBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other
        as _$GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess;
  }

  @override
  void update(
      void Function(
              GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccessBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess build() =>
      _build();

  _$GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess _build() {
    _$GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess _$result;
    try {
      _$result = _$v ??
          new _$GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename,
                  r'GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess',
                  'G__typename'),
              data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data
    extends GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data {
  @override
  final String G__typename;
  @override
  final String idToken;
  @override
  final String refreshToken;

  factory _$GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data(
          [void Function(
                  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_dataBuilder)?
              updates]) =>
      (new GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_dataBuilder()
            ..update(updates))
          ._build();

  _$GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data._(
      {required this.G__typename,
      required this.idToken,
      required this.refreshToken})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data',
        'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        idToken,
        r'GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data',
        'idToken');
    BuiltValueNullFieldError.checkNotNull(
        refreshToken,
        r'GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data',
        'refreshToken');
  }

  @override
  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data rebuild(
          void Function(
                  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_dataBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_dataBuilder
      toBuilder() =>
          new GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_dataBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data &&
        G__typename == other.G__typename &&
        idToken == other.idToken &&
        refreshToken == other.refreshToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, idToken.hashCode);
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data')
          ..add('G__typename', G__typename)
          ..add('idToken', idToken)
          ..add('refreshToken', refreshToken))
        .toString();
  }
}

class GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_dataBuilder
    implements
        Builder<
            GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data,
            GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_dataBuilder> {
  _$GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _idToken;
  String? get idToken => _$this._idToken;
  set idToken(String? idToken) => _$this._idToken = idToken;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_dataBuilder() {
    GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data
        ._initializeBuilder(this);
  }

  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_dataBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _idToken = $v.idToken;
      _refreshToken = $v.refreshToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data
          other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other
        as _$GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data;
  }

  @override
  void update(
      void Function(
              GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_dataBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data build() =>
      _build();

  _$GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data
      _build() {
    final _$result = _$v ??
        new _$GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data
            ._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data',
                'G__typename'),
            idToken: BuiltValueNullFieldError.checkNotNull(
                idToken,
                r'GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data',
                'idToken'),
            refreshToken: BuiltValueNullFieldError.checkNotNull(
                refreshToken,
                r'GRefreshTokenData_refreshToken__asMutationRefreshTokenSuccess_data',
                'refreshToken'));
    replace(_$result);
    return _$result;
  }
}

class _$GRefreshTokenData_refreshToken__asAuthError
    extends GRefreshTokenData_refreshToken__asAuthError {
  @override
  final String G__typename;
  @override
  final _i3.GAuthErrorCode? code;
  @override
  final String? message;
  @override
  final String? field;
  @override
  final bool? retryable;

  factory _$GRefreshTokenData_refreshToken__asAuthError(
          [void Function(GRefreshTokenData_refreshToken__asAuthErrorBuilder)?
              updates]) =>
      (new GRefreshTokenData_refreshToken__asAuthErrorBuilder()
            ..update(updates))
          ._build();

  _$GRefreshTokenData_refreshToken__asAuthError._(
      {required this.G__typename,
      this.code,
      this.message,
      this.field,
      this.retryable})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        r'GRefreshTokenData_refreshToken__asAuthError', 'G__typename');
  }

  @override
  GRefreshTokenData_refreshToken__asAuthError rebuild(
          void Function(GRefreshTokenData_refreshToken__asAuthErrorBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRefreshTokenData_refreshToken__asAuthErrorBuilder toBuilder() =>
      new GRefreshTokenData_refreshToken__asAuthErrorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRefreshTokenData_refreshToken__asAuthError &&
        G__typename == other.G__typename &&
        code == other.code &&
        message == other.message &&
        field == other.field &&
        retryable == other.retryable;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, field.hashCode);
    _$hash = $jc(_$hash, retryable.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GRefreshTokenData_refreshToken__asAuthError')
          ..add('G__typename', G__typename)
          ..add('code', code)
          ..add('message', message)
          ..add('field', field)
          ..add('retryable', retryable))
        .toString();
  }
}

class GRefreshTokenData_refreshToken__asAuthErrorBuilder
    implements
        Builder<GRefreshTokenData_refreshToken__asAuthError,
            GRefreshTokenData_refreshToken__asAuthErrorBuilder> {
  _$GRefreshTokenData_refreshToken__asAuthError? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  _i3.GAuthErrorCode? _code;
  _i3.GAuthErrorCode? get code => _$this._code;
  set code(_i3.GAuthErrorCode? code) => _$this._code = code;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _field;
  String? get field => _$this._field;
  set field(String? field) => _$this._field = field;

  bool? _retryable;
  bool? get retryable => _$this._retryable;
  set retryable(bool? retryable) => _$this._retryable = retryable;

  GRefreshTokenData_refreshToken__asAuthErrorBuilder() {
    GRefreshTokenData_refreshToken__asAuthError._initializeBuilder(this);
  }

  GRefreshTokenData_refreshToken__asAuthErrorBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _code = $v.code;
      _message = $v.message;
      _field = $v.field;
      _retryable = $v.retryable;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRefreshTokenData_refreshToken__asAuthError other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GRefreshTokenData_refreshToken__asAuthError;
  }

  @override
  void update(
      void Function(GRefreshTokenData_refreshToken__asAuthErrorBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GRefreshTokenData_refreshToken__asAuthError build() => _build();

  _$GRefreshTokenData_refreshToken__asAuthError _build() {
    final _$result = _$v ??
        new _$GRefreshTokenData_refreshToken__asAuthError._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GRefreshTokenData_refreshToken__asAuthError', 'G__typename'),
            code: code,
            message: message,
            field: field,
            retryable: retryable);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
