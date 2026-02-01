// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GChangePasswordData> _$gChangePasswordDataSerializer =
    new _$GChangePasswordDataSerializer();
Serializer<GChangePasswordData_changePassword__base>
    _$gChangePasswordDataChangePasswordBaseSerializer =
    new _$GChangePasswordData_changePassword__baseSerializer();
Serializer<GChangePasswordData_changePassword__asMutationChangePasswordSuccess>
    _$gChangePasswordDataChangePasswordAsMutationChangePasswordSuccessSerializer =
    new _$GChangePasswordData_changePassword__asMutationChangePasswordSuccessSerializer();
Serializer<
        GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data>
    _$gChangePasswordDataChangePasswordAsMutationChangePasswordSuccessDataSerializer =
    new _$GChangePasswordData_changePassword__asMutationChangePasswordSuccess_dataSerializer();
Serializer<GChangePasswordData_changePassword__asAuthError>
    _$gChangePasswordDataChangePasswordAsAuthErrorSerializer =
    new _$GChangePasswordData_changePassword__asAuthErrorSerializer();

class _$GChangePasswordDataSerializer
    implements StructuredSerializer<GChangePasswordData> {
  @override
  final Iterable<Type> types = const [
    GChangePasswordData,
    _$GChangePasswordData
  ];
  @override
  final String wireName = 'GChangePasswordData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GChangePasswordData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.changePassword;
    if (value != null) {
      result
        ..add('changePassword')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GChangePasswordData_changePassword)));
    }
    return result;
  }

  @override
  GChangePasswordData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GChangePasswordDataBuilder();

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
        case 'changePassword':
          result.changePassword = serializers.deserialize(value,
                  specifiedType:
                      const FullType(GChangePasswordData_changePassword))
              as GChangePasswordData_changePassword?;
          break;
      }
    }

    return result.build();
  }
}

class _$GChangePasswordData_changePassword__baseSerializer
    implements StructuredSerializer<GChangePasswordData_changePassword__base> {
  @override
  final Iterable<Type> types = const [
    GChangePasswordData_changePassword__base,
    _$GChangePasswordData_changePassword__base
  ];
  @override
  final String wireName = 'GChangePasswordData_changePassword__base';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GChangePasswordData_changePassword__base object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GChangePasswordData_changePassword__base deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GChangePasswordData_changePassword__baseBuilder();

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

class _$GChangePasswordData_changePassword__asMutationChangePasswordSuccessSerializer
    implements
        StructuredSerializer<
            GChangePasswordData_changePassword__asMutationChangePasswordSuccess> {
  @override
  final Iterable<Type> types = const [
    GChangePasswordData_changePassword__asMutationChangePasswordSuccess,
    _$GChangePasswordData_changePassword__asMutationChangePasswordSuccess
  ];
  @override
  final String wireName =
      'GChangePasswordData_changePassword__asMutationChangePasswordSuccess';

  @override
  Iterable<Object?> serialize(
      Serializers serializers,
      GChangePasswordData_changePassword__asMutationChangePasswordSuccess
          object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data)),
    ];

    return result;
  }

  @override
  GChangePasswordData_changePassword__asMutationChangePasswordSuccess
      deserialize(Serializers serializers, Iterable<Object?> serialized,
          {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GChangePasswordData_changePassword__asMutationChangePasswordSuccessBuilder();

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
                      GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data))!
              as GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data);
          break;
      }
    }

    return result.build();
  }
}

class _$GChangePasswordData_changePassword__asMutationChangePasswordSuccess_dataSerializer
    implements
        StructuredSerializer<
            GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data> {
  @override
  final Iterable<Type> types = const [
    GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data,
    _$GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data
  ];
  @override
  final String wireName =
      'GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data';

  @override
  Iterable<Object?> serialize(
      Serializers serializers,
      GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data
          object,
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
  GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data
      deserialize(Serializers serializers, Iterable<Object?> serialized,
          {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GChangePasswordData_changePassword__asMutationChangePasswordSuccess_dataBuilder();

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

class _$GChangePasswordData_changePassword__asAuthErrorSerializer
    implements
        StructuredSerializer<GChangePasswordData_changePassword__asAuthError> {
  @override
  final Iterable<Type> types = const [
    GChangePasswordData_changePassword__asAuthError,
    _$GChangePasswordData_changePassword__asAuthError
  ];
  @override
  final String wireName = 'GChangePasswordData_changePassword__asAuthError';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GChangePasswordData_changePassword__asAuthError object,
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
  GChangePasswordData_changePassword__asAuthError deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GChangePasswordData_changePassword__asAuthErrorBuilder();

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

class _$GChangePasswordData extends GChangePasswordData {
  @override
  final String G__typename;
  @override
  final GChangePasswordData_changePassword? changePassword;

  factory _$GChangePasswordData(
          [void Function(GChangePasswordDataBuilder)? updates]) =>
      (new GChangePasswordDataBuilder()..update(updates))._build();

  _$GChangePasswordData._({required this.G__typename, this.changePassword})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GChangePasswordData', 'G__typename');
  }

  @override
  GChangePasswordData rebuild(
          void Function(GChangePasswordDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GChangePasswordDataBuilder toBuilder() =>
      new GChangePasswordDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GChangePasswordData &&
        G__typename == other.G__typename &&
        changePassword == other.changePassword;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, changePassword.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GChangePasswordData')
          ..add('G__typename', G__typename)
          ..add('changePassword', changePassword))
        .toString();
  }
}

class GChangePasswordDataBuilder
    implements Builder<GChangePasswordData, GChangePasswordDataBuilder> {
  _$GChangePasswordData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GChangePasswordData_changePassword? _changePassword;
  GChangePasswordData_changePassword? get changePassword =>
      _$this._changePassword;
  set changePassword(GChangePasswordData_changePassword? changePassword) =>
      _$this._changePassword = changePassword;

  GChangePasswordDataBuilder() {
    GChangePasswordData._initializeBuilder(this);
  }

  GChangePasswordDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _changePassword = $v.changePassword;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GChangePasswordData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GChangePasswordData;
  }

  @override
  void update(void Function(GChangePasswordDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GChangePasswordData build() => _build();

  _$GChangePasswordData _build() {
    final _$result = _$v ??
        new _$GChangePasswordData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GChangePasswordData', 'G__typename'),
            changePassword: changePassword);
    replace(_$result);
    return _$result;
  }
}

class _$GChangePasswordData_changePassword__base
    extends GChangePasswordData_changePassword__base {
  @override
  final String G__typename;

  factory _$GChangePasswordData_changePassword__base(
          [void Function(GChangePasswordData_changePassword__baseBuilder)?
              updates]) =>
      (new GChangePasswordData_changePassword__baseBuilder()..update(updates))
          ._build();

  _$GChangePasswordData_changePassword__base._({required this.G__typename})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        r'GChangePasswordData_changePassword__base', 'G__typename');
  }

  @override
  GChangePasswordData_changePassword__base rebuild(
          void Function(GChangePasswordData_changePassword__baseBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GChangePasswordData_changePassword__baseBuilder toBuilder() =>
      new GChangePasswordData_changePassword__baseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GChangePasswordData_changePassword__base &&
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
    return (newBuiltValueToStringHelper(
            r'GChangePasswordData_changePassword__base')
          ..add('G__typename', G__typename))
        .toString();
  }
}

class GChangePasswordData_changePassword__baseBuilder
    implements
        Builder<GChangePasswordData_changePassword__base,
            GChangePasswordData_changePassword__baseBuilder> {
  _$GChangePasswordData_changePassword__base? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GChangePasswordData_changePassword__baseBuilder() {
    GChangePasswordData_changePassword__base._initializeBuilder(this);
  }

  GChangePasswordData_changePassword__baseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GChangePasswordData_changePassword__base other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GChangePasswordData_changePassword__base;
  }

  @override
  void update(
      void Function(GChangePasswordData_changePassword__baseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GChangePasswordData_changePassword__base build() => _build();

  _$GChangePasswordData_changePassword__base _build() {
    final _$result = _$v ??
        new _$GChangePasswordData_changePassword__base._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GChangePasswordData_changePassword__base', 'G__typename'));
    replace(_$result);
    return _$result;
  }
}

class _$GChangePasswordData_changePassword__asMutationChangePasswordSuccess
    extends GChangePasswordData_changePassword__asMutationChangePasswordSuccess {
  @override
  final String G__typename;
  @override
  final GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data
      data;

  factory _$GChangePasswordData_changePassword__asMutationChangePasswordSuccess(
          [void Function(
                  GChangePasswordData_changePassword__asMutationChangePasswordSuccessBuilder)?
              updates]) =>
      (new GChangePasswordData_changePassword__asMutationChangePasswordSuccessBuilder()
            ..update(updates))
          ._build();

  _$GChangePasswordData_changePassword__asMutationChangePasswordSuccess._(
      {required this.G__typename, required this.data})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GChangePasswordData_changePassword__asMutationChangePasswordSuccess',
        'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        data,
        r'GChangePasswordData_changePassword__asMutationChangePasswordSuccess',
        'data');
  }

  @override
  GChangePasswordData_changePassword__asMutationChangePasswordSuccess rebuild(
          void Function(
                  GChangePasswordData_changePassword__asMutationChangePasswordSuccessBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GChangePasswordData_changePassword__asMutationChangePasswordSuccessBuilder
      toBuilder() =>
          new GChangePasswordData_changePassword__asMutationChangePasswordSuccessBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GChangePasswordData_changePassword__asMutationChangePasswordSuccess &&
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
            r'GChangePasswordData_changePassword__asMutationChangePasswordSuccess')
          ..add('G__typename', G__typename)
          ..add('data', data))
        .toString();
  }
}

class GChangePasswordData_changePassword__asMutationChangePasswordSuccessBuilder
    implements
        Builder<
            GChangePasswordData_changePassword__asMutationChangePasswordSuccess,
            GChangePasswordData_changePassword__asMutationChangePasswordSuccessBuilder> {
  _$GChangePasswordData_changePassword__asMutationChangePasswordSuccess? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GChangePasswordData_changePassword__asMutationChangePasswordSuccess_dataBuilder?
      _data;
  GChangePasswordData_changePassword__asMutationChangePasswordSuccess_dataBuilder
      get data => _$this._data ??=
          new GChangePasswordData_changePassword__asMutationChangePasswordSuccess_dataBuilder();
  set data(
          GChangePasswordData_changePassword__asMutationChangePasswordSuccess_dataBuilder?
              data) =>
      _$this._data = data;

  GChangePasswordData_changePassword__asMutationChangePasswordSuccessBuilder() {
    GChangePasswordData_changePassword__asMutationChangePasswordSuccess
        ._initializeBuilder(this);
  }

  GChangePasswordData_changePassword__asMutationChangePasswordSuccessBuilder
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
      GChangePasswordData_changePassword__asMutationChangePasswordSuccess
          other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other
        as _$GChangePasswordData_changePassword__asMutationChangePasswordSuccess;
  }

  @override
  void update(
      void Function(
              GChangePasswordData_changePassword__asMutationChangePasswordSuccessBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GChangePasswordData_changePassword__asMutationChangePasswordSuccess build() =>
      _build();

  _$GChangePasswordData_changePassword__asMutationChangePasswordSuccess
      _build() {
    _$GChangePasswordData_changePassword__asMutationChangePasswordSuccess
        _$result;
    try {
      _$result = _$v ??
          new _$GChangePasswordData_changePassword__asMutationChangePasswordSuccess
              ._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename,
                  r'GChangePasswordData_changePassword__asMutationChangePasswordSuccess',
                  'G__typename'),
              data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GChangePasswordData_changePassword__asMutationChangePasswordSuccess',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data
    extends GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data {
  @override
  final String G__typename;
  @override
  final String idToken;
  @override
  final String refreshToken;

  factory _$GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data(
          [void Function(
                  GChangePasswordData_changePassword__asMutationChangePasswordSuccess_dataBuilder)?
              updates]) =>
      (new GChangePasswordData_changePassword__asMutationChangePasswordSuccess_dataBuilder()
            ..update(updates))
          ._build();

  _$GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data._(
      {required this.G__typename,
      required this.idToken,
      required this.refreshToken})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data',
        'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        idToken,
        r'GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data',
        'idToken');
    BuiltValueNullFieldError.checkNotNull(
        refreshToken,
        r'GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data',
        'refreshToken');
  }

  @override
  GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data rebuild(
          void Function(
                  GChangePasswordData_changePassword__asMutationChangePasswordSuccess_dataBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GChangePasswordData_changePassword__asMutationChangePasswordSuccess_dataBuilder
      toBuilder() =>
          new GChangePasswordData_changePassword__asMutationChangePasswordSuccess_dataBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data &&
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
            r'GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data')
          ..add('G__typename', G__typename)
          ..add('idToken', idToken)
          ..add('refreshToken', refreshToken))
        .toString();
  }
}

class GChangePasswordData_changePassword__asMutationChangePasswordSuccess_dataBuilder
    implements
        Builder<
            GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data,
            GChangePasswordData_changePassword__asMutationChangePasswordSuccess_dataBuilder> {
  _$GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data?
      _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _idToken;
  String? get idToken => _$this._idToken;
  set idToken(String? idToken) => _$this._idToken = idToken;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  GChangePasswordData_changePassword__asMutationChangePasswordSuccess_dataBuilder() {
    GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data
        ._initializeBuilder(this);
  }

  GChangePasswordData_changePassword__asMutationChangePasswordSuccess_dataBuilder
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
      GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data
          other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other
        as _$GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data;
  }

  @override
  void update(
      void Function(
              GChangePasswordData_changePassword__asMutationChangePasswordSuccess_dataBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data
      build() => _build();

  _$GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data
      _build() {
    final _$result = _$v ??
        new _$GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data
            ._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data',
                'G__typename'),
            idToken: BuiltValueNullFieldError.checkNotNull(
                idToken,
                r'GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data',
                'idToken'),
            refreshToken: BuiltValueNullFieldError.checkNotNull(
                refreshToken,
                r'GChangePasswordData_changePassword__asMutationChangePasswordSuccess_data',
                'refreshToken'));
    replace(_$result);
    return _$result;
  }
}

class _$GChangePasswordData_changePassword__asAuthError
    extends GChangePasswordData_changePassword__asAuthError {
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

  factory _$GChangePasswordData_changePassword__asAuthError(
          [void Function(
                  GChangePasswordData_changePassword__asAuthErrorBuilder)?
              updates]) =>
      (new GChangePasswordData_changePassword__asAuthErrorBuilder()
            ..update(updates))
          ._build();

  _$GChangePasswordData_changePassword__asAuthError._(
      {required this.G__typename,
      this.code,
      this.message,
      this.field,
      this.retryable})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        r'GChangePasswordData_changePassword__asAuthError', 'G__typename');
  }

  @override
  GChangePasswordData_changePassword__asAuthError rebuild(
          void Function(GChangePasswordData_changePassword__asAuthErrorBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GChangePasswordData_changePassword__asAuthErrorBuilder toBuilder() =>
      new GChangePasswordData_changePassword__asAuthErrorBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GChangePasswordData_changePassword__asAuthError &&
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
            r'GChangePasswordData_changePassword__asAuthError')
          ..add('G__typename', G__typename)
          ..add('code', code)
          ..add('message', message)
          ..add('field', field)
          ..add('retryable', retryable))
        .toString();
  }
}

class GChangePasswordData_changePassword__asAuthErrorBuilder
    implements
        Builder<GChangePasswordData_changePassword__asAuthError,
            GChangePasswordData_changePassword__asAuthErrorBuilder> {
  _$GChangePasswordData_changePassword__asAuthError? _$v;

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

  GChangePasswordData_changePassword__asAuthErrorBuilder() {
    GChangePasswordData_changePassword__asAuthError._initializeBuilder(this);
  }

  GChangePasswordData_changePassword__asAuthErrorBuilder get _$this {
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
  void replace(GChangePasswordData_changePassword__asAuthError other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GChangePasswordData_changePassword__asAuthError;
  }

  @override
  void update(
      void Function(GChangePasswordData_changePassword__asAuthErrorBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GChangePasswordData_changePassword__asAuthError build() => _build();

  _$GChangePasswordData_changePassword__asAuthError _build() {
    final _$result = _$v ??
        new _$GChangePasswordData_changePassword__asAuthError._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GChangePasswordData_changePassword__asAuthError',
                'G__typename'),
            code: code,
            message: message,
            field: field,
            retryable: retryable);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
