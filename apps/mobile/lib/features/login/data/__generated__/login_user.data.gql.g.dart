// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GLoginUserData> _$gLoginUserDataSerializer =
    new _$GLoginUserDataSerializer();
Serializer<GLoginUserData_loginUser__base>
    _$gLoginUserDataLoginUserBaseSerializer =
    new _$GLoginUserData_loginUser__baseSerializer();
Serializer<GLoginUserData_loginUser__asMutationLoginUserSuccess>
    _$gLoginUserDataLoginUserAsMutationLoginUserSuccessSerializer =
    new _$GLoginUserData_loginUser__asMutationLoginUserSuccessSerializer();
Serializer<GLoginUserData_loginUser__asMutationLoginUserSuccess_data>
    _$gLoginUserDataLoginUserAsMutationLoginUserSuccessDataSerializer =
    new _$GLoginUserData_loginUser__asMutationLoginUserSuccess_dataSerializer();
Serializer<GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user>
    _$gLoginUserDataLoginUserAsMutationLoginUserSuccessDataUserSerializer =
    new _$GLoginUserData_loginUser__asMutationLoginUserSuccess_data_userSerializer();
Serializer<GLoginUserData_loginUser__asAuthError>
    _$gLoginUserDataLoginUserAsAuthErrorSerializer =
    new _$GLoginUserData_loginUser__asAuthErrorSerializer();

class _$GLoginUserDataSerializer
    implements StructuredSerializer<GLoginUserData> {
  @override
  final Iterable<Type> types = const [GLoginUserData, _$GLoginUserData];
  @override
  final String wireName = 'GLoginUserData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GLoginUserData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.loginUser;
    if (value != null) {
      result
        ..add('loginUser')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GLoginUserData_loginUser)));
    }
    return result;
  }

  @override
  GLoginUserData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GLoginUserDataBuilder();

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
        case 'loginUser':
          result.loginUser = serializers.deserialize(value,
                  specifiedType: const FullType(GLoginUserData_loginUser))
              as GLoginUserData_loginUser?;
          break;
      }
    }

    return result.build();
  }
}

class _$GLoginUserData_loginUser__baseSerializer
    implements StructuredSerializer<GLoginUserData_loginUser__base> {
  @override
  final Iterable<Type> types = const [
    GLoginUserData_loginUser__base,
    _$GLoginUserData_loginUser__base
  ];
  @override
  final String wireName = 'GLoginUserData_loginUser__base';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GLoginUserData_loginUser__base object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GLoginUserData_loginUser__base deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GLoginUserData_loginUser__baseBuilder();

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

class _$GLoginUserData_loginUser__asMutationLoginUserSuccessSerializer
    implements
        StructuredSerializer<
            GLoginUserData_loginUser__asMutationLoginUserSuccess> {
  @override
  final Iterable<Type> types = const [
    GLoginUserData_loginUser__asMutationLoginUserSuccess,
    _$GLoginUserData_loginUser__asMutationLoginUserSuccess
  ];
  @override
  final String wireName =
      'GLoginUserData_loginUser__asMutationLoginUserSuccess';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GLoginUserData_loginUser__asMutationLoginUserSuccess object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(
              GLoginUserData_loginUser__asMutationLoginUserSuccess_data)),
    ];

    return result;
  }

  @override
  GLoginUserData_loginUser__asMutationLoginUserSuccess deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GLoginUserData_loginUser__asMutationLoginUserSuccessBuilder();

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
                      GLoginUserData_loginUser__asMutationLoginUserSuccess_data))!
              as GLoginUserData_loginUser__asMutationLoginUserSuccess_data);
          break;
      }
    }

    return result.build();
  }
}

class _$GLoginUserData_loginUser__asMutationLoginUserSuccess_dataSerializer
    implements
        StructuredSerializer<
            GLoginUserData_loginUser__asMutationLoginUserSuccess_data> {
  @override
  final Iterable<Type> types = const [
    GLoginUserData_loginUser__asMutationLoginUserSuccess_data,
    _$GLoginUserData_loginUser__asMutationLoginUserSuccess_data
  ];
  @override
  final String wireName =
      'GLoginUserData_loginUser__asMutationLoginUserSuccess_data';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GLoginUserData_loginUser__asMutationLoginUserSuccess_data object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'user',
      serializers.serialize(object.user,
          specifiedType: const FullType(
              GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user)),
      'idToken',
      serializers.serialize(object.idToken,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GLoginUserData_loginUser__asMutationLoginUserSuccess_data deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GLoginUserData_loginUser__asMutationLoginUserSuccess_dataBuilder();

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
        case 'user':
          result.user.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user))!
              as GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user);
          break;
        case 'idToken':
          result.idToken = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GLoginUserData_loginUser__asMutationLoginUserSuccess_data_userSerializer
    implements
        StructuredSerializer<
            GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user> {
  @override
  final Iterable<Type> types = const [
    GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user,
    _$GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user
  ];
  @override
  final String wireName =
      'GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user object,
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
    value = object.email;
    if (value != null) {
      result
        ..add('email')
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
  GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        new GLoginUserData_loginUser__asMutationLoginUserSuccess_data_userBuilder();

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
        case 'email':
          result.email = serializers.deserialize(value,
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

class _$GLoginUserData_loginUser__asAuthErrorSerializer
    implements StructuredSerializer<GLoginUserData_loginUser__asAuthError> {
  @override
  final Iterable<Type> types = const [
    GLoginUserData_loginUser__asAuthError,
    _$GLoginUserData_loginUser__asAuthError
  ];
  @override
  final String wireName = 'GLoginUserData_loginUser__asAuthError';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GLoginUserData_loginUser__asAuthError object,
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
  GLoginUserData_loginUser__asAuthError deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GLoginUserData_loginUser__asAuthErrorBuilder();

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

class _$GLoginUserData extends GLoginUserData {
  @override
  final String G__typename;
  @override
  final GLoginUserData_loginUser? loginUser;

  factory _$GLoginUserData([void Function(GLoginUserDataBuilder)? updates]) =>
      (new GLoginUserDataBuilder()..update(updates))._build();

  _$GLoginUserData._({required this.G__typename, this.loginUser}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GLoginUserData', 'G__typename');
  }

  @override
  GLoginUserData rebuild(void Function(GLoginUserDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GLoginUserDataBuilder toBuilder() =>
      new GLoginUserDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GLoginUserData &&
        G__typename == other.G__typename &&
        loginUser == other.loginUser;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, loginUser.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GLoginUserData')
          ..add('G__typename', G__typename)
          ..add('loginUser', loginUser))
        .toString();
  }
}

class GLoginUserDataBuilder
    implements Builder<GLoginUserData, GLoginUserDataBuilder> {
  _$GLoginUserData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GLoginUserData_loginUser? _loginUser;
  GLoginUserData_loginUser? get loginUser => _$this._loginUser;
  set loginUser(GLoginUserData_loginUser? loginUser) =>
      _$this._loginUser = loginUser;

  GLoginUserDataBuilder() {
    GLoginUserData._initializeBuilder(this);
  }

  GLoginUserDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _loginUser = $v.loginUser;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GLoginUserData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GLoginUserData;
  }

  @override
  void update(void Function(GLoginUserDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GLoginUserData build() => _build();

  _$GLoginUserData _build() {
    final _$result = _$v ??
        new _$GLoginUserData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GLoginUserData', 'G__typename'),
            loginUser: loginUser);
    replace(_$result);
    return _$result;
  }
}

class _$GLoginUserData_loginUser__base extends GLoginUserData_loginUser__base {
  @override
  final String G__typename;

  factory _$GLoginUserData_loginUser__base(
          [void Function(GLoginUserData_loginUser__baseBuilder)? updates]) =>
      (new GLoginUserData_loginUser__baseBuilder()..update(updates))._build();

  _$GLoginUserData_loginUser__base._({required this.G__typename}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GLoginUserData_loginUser__base', 'G__typename');
  }

  @override
  GLoginUserData_loginUser__base rebuild(
          void Function(GLoginUserData_loginUser__baseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GLoginUserData_loginUser__baseBuilder toBuilder() =>
      new GLoginUserData_loginUser__baseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GLoginUserData_loginUser__base &&
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
    return (newBuiltValueToStringHelper(r'GLoginUserData_loginUser__base')
          ..add('G__typename', G__typename))
        .toString();
  }
}

class GLoginUserData_loginUser__baseBuilder
    implements
        Builder<GLoginUserData_loginUser__base,
            GLoginUserData_loginUser__baseBuilder> {
  _$GLoginUserData_loginUser__base? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GLoginUserData_loginUser__baseBuilder() {
    GLoginUserData_loginUser__base._initializeBuilder(this);
  }

  GLoginUserData_loginUser__baseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GLoginUserData_loginUser__base other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GLoginUserData_loginUser__base;
  }

  @override
  void update(void Function(GLoginUserData_loginUser__baseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GLoginUserData_loginUser__base build() => _build();

  _$GLoginUserData_loginUser__base _build() {
    final _$result = _$v ??
        new _$GLoginUserData_loginUser__base._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GLoginUserData_loginUser__base', 'G__typename'));
    replace(_$result);
    return _$result;
  }
}

class _$GLoginUserData_loginUser__asMutationLoginUserSuccess
    extends GLoginUserData_loginUser__asMutationLoginUserSuccess {
  @override
  final String G__typename;
  @override
  final GLoginUserData_loginUser__asMutationLoginUserSuccess_data data;

  factory _$GLoginUserData_loginUser__asMutationLoginUserSuccess(
          [void Function(
                  GLoginUserData_loginUser__asMutationLoginUserSuccessBuilder)?
              updates]) =>
      (new GLoginUserData_loginUser__asMutationLoginUserSuccessBuilder()
            ..update(updates))
          ._build();

  _$GLoginUserData_loginUser__asMutationLoginUserSuccess._(
      {required this.G__typename, required this.data})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(G__typename,
        r'GLoginUserData_loginUser__asMutationLoginUserSuccess', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        data, r'GLoginUserData_loginUser__asMutationLoginUserSuccess', 'data');
  }

  @override
  GLoginUserData_loginUser__asMutationLoginUserSuccess rebuild(
          void Function(
                  GLoginUserData_loginUser__asMutationLoginUserSuccessBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GLoginUserData_loginUser__asMutationLoginUserSuccessBuilder toBuilder() =>
      new GLoginUserData_loginUser__asMutationLoginUserSuccessBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GLoginUserData_loginUser__asMutationLoginUserSuccess &&
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
            r'GLoginUserData_loginUser__asMutationLoginUserSuccess')
          ..add('G__typename', G__typename)
          ..add('data', data))
        .toString();
  }
}

class GLoginUserData_loginUser__asMutationLoginUserSuccessBuilder
    implements
        Builder<GLoginUserData_loginUser__asMutationLoginUserSuccess,
            GLoginUserData_loginUser__asMutationLoginUserSuccessBuilder> {
  _$GLoginUserData_loginUser__asMutationLoginUserSuccess? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GLoginUserData_loginUser__asMutationLoginUserSuccess_dataBuilder? _data;
  GLoginUserData_loginUser__asMutationLoginUserSuccess_dataBuilder get data =>
      _$this._data ??=
          new GLoginUserData_loginUser__asMutationLoginUserSuccess_dataBuilder();
  set data(
          GLoginUserData_loginUser__asMutationLoginUserSuccess_dataBuilder?
              data) =>
      _$this._data = data;

  GLoginUserData_loginUser__asMutationLoginUserSuccessBuilder() {
    GLoginUserData_loginUser__asMutationLoginUserSuccess._initializeBuilder(
        this);
  }

  GLoginUserData_loginUser__asMutationLoginUserSuccessBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GLoginUserData_loginUser__asMutationLoginUserSuccess other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GLoginUserData_loginUser__asMutationLoginUserSuccess;
  }

  @override
  void update(
      void Function(
              GLoginUserData_loginUser__asMutationLoginUserSuccessBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GLoginUserData_loginUser__asMutationLoginUserSuccess build() => _build();

  _$GLoginUserData_loginUser__asMutationLoginUserSuccess _build() {
    _$GLoginUserData_loginUser__asMutationLoginUserSuccess _$result;
    try {
      _$result = _$v ??
          new _$GLoginUserData_loginUser__asMutationLoginUserSuccess._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename,
                  r'GLoginUserData_loginUser__asMutationLoginUserSuccess',
                  'G__typename'),
              data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GLoginUserData_loginUser__asMutationLoginUserSuccess',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GLoginUserData_loginUser__asMutationLoginUserSuccess_data
    extends GLoginUserData_loginUser__asMutationLoginUserSuccess_data {
  @override
  final String G__typename;
  @override
  final GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user user;
  @override
  final String idToken;

  factory _$GLoginUserData_loginUser__asMutationLoginUserSuccess_data(
          [void Function(
                  GLoginUserData_loginUser__asMutationLoginUserSuccess_dataBuilder)?
              updates]) =>
      (new GLoginUserData_loginUser__asMutationLoginUserSuccess_dataBuilder()
            ..update(updates))
          ._build();

  _$GLoginUserData_loginUser__asMutationLoginUserSuccess_data._(
      {required this.G__typename, required this.user, required this.idToken})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GLoginUserData_loginUser__asMutationLoginUserSuccess_data',
        'G__typename');
    BuiltValueNullFieldError.checkNotNull(user,
        r'GLoginUserData_loginUser__asMutationLoginUserSuccess_data', 'user');
    BuiltValueNullFieldError.checkNotNull(
        idToken,
        r'GLoginUserData_loginUser__asMutationLoginUserSuccess_data',
        'idToken');
  }

  @override
  GLoginUserData_loginUser__asMutationLoginUserSuccess_data rebuild(
          void Function(
                  GLoginUserData_loginUser__asMutationLoginUserSuccess_dataBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GLoginUserData_loginUser__asMutationLoginUserSuccess_dataBuilder
      toBuilder() =>
          new GLoginUserData_loginUser__asMutationLoginUserSuccess_dataBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GLoginUserData_loginUser__asMutationLoginUserSuccess_data &&
        G__typename == other.G__typename &&
        user == other.user &&
        idToken == other.idToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, idToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GLoginUserData_loginUser__asMutationLoginUserSuccess_data')
          ..add('G__typename', G__typename)
          ..add('user', user)
          ..add('idToken', idToken))
        .toString();
  }
}

class GLoginUserData_loginUser__asMutationLoginUserSuccess_dataBuilder
    implements
        Builder<GLoginUserData_loginUser__asMutationLoginUserSuccess_data,
            GLoginUserData_loginUser__asMutationLoginUserSuccess_dataBuilder> {
  _$GLoginUserData_loginUser__asMutationLoginUserSuccess_data? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GLoginUserData_loginUser__asMutationLoginUserSuccess_data_userBuilder? _user;
  GLoginUserData_loginUser__asMutationLoginUserSuccess_data_userBuilder
      get user => _$this._user ??=
          new GLoginUserData_loginUser__asMutationLoginUserSuccess_data_userBuilder();
  set user(
          GLoginUserData_loginUser__asMutationLoginUserSuccess_data_userBuilder?
              user) =>
      _$this._user = user;

  String? _idToken;
  String? get idToken => _$this._idToken;
  set idToken(String? idToken) => _$this._idToken = idToken;

  GLoginUserData_loginUser__asMutationLoginUserSuccess_dataBuilder() {
    GLoginUserData_loginUser__asMutationLoginUserSuccess_data
        ._initializeBuilder(this);
  }

  GLoginUserData_loginUser__asMutationLoginUserSuccess_dataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _user = $v.user.toBuilder();
      _idToken = $v.idToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GLoginUserData_loginUser__asMutationLoginUserSuccess_data other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GLoginUserData_loginUser__asMutationLoginUserSuccess_data;
  }

  @override
  void update(
      void Function(
              GLoginUserData_loginUser__asMutationLoginUserSuccess_dataBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GLoginUserData_loginUser__asMutationLoginUserSuccess_data build() => _build();

  _$GLoginUserData_loginUser__asMutationLoginUserSuccess_data _build() {
    _$GLoginUserData_loginUser__asMutationLoginUserSuccess_data _$result;
    try {
      _$result = _$v ??
          new _$GLoginUserData_loginUser__asMutationLoginUserSuccess_data._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename,
                  r'GLoginUserData_loginUser__asMutationLoginUserSuccess_data',
                  'G__typename'),
              user: user.build(),
              idToken: BuiltValueNullFieldError.checkNotNull(
                  idToken,
                  r'GLoginUserData_loginUser__asMutationLoginUserSuccess_data',
                  'idToken'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GLoginUserData_loginUser__asMutationLoginUserSuccess_data',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user
    extends GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user {
  @override
  final String G__typename;
  @override
  final int? id;
  @override
  final String? email;
  @override
  final DateTime? createdAt;

  factory _$GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user(
          [void Function(
                  GLoginUserData_loginUser__asMutationLoginUserSuccess_data_userBuilder)?
              updates]) =>
      (new GLoginUserData_loginUser__asMutationLoginUserSuccess_data_userBuilder()
            ..update(updates))
          ._build();

  _$GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user._(
      {required this.G__typename, this.id, this.email, this.createdAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename,
        r'GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user',
        'G__typename');
  }

  @override
  GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user rebuild(
          void Function(
                  GLoginUserData_loginUser__asMutationLoginUserSuccess_data_userBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GLoginUserData_loginUser__asMutationLoginUserSuccess_data_userBuilder
      toBuilder() =>
          new GLoginUserData_loginUser__asMutationLoginUserSuccess_data_userBuilder()
            ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user &&
        G__typename == other.G__typename &&
        id == other.id &&
        email == other.email &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('email', email)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class GLoginUserData_loginUser__asMutationLoginUserSuccess_data_userBuilder
    implements
        Builder<GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user,
            GLoginUserData_loginUser__asMutationLoginUserSuccess_data_userBuilder> {
  _$GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  GLoginUserData_loginUser__asMutationLoginUserSuccess_data_userBuilder() {
    GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user
        ._initializeBuilder(this);
  }

  GLoginUserData_loginUser__asMutationLoginUserSuccess_data_userBuilder
      get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _email = $v.email;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
      GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other
        as _$GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user;
  }

  @override
  void update(
      void Function(
              GLoginUserData_loginUser__asMutationLoginUserSuccess_data_userBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user build() =>
      _build();

  _$GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user _build() {
    final _$result = _$v ??
        new _$GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GLoginUserData_loginUser__asMutationLoginUserSuccess_data_user',
                'G__typename'),
            id: id,
            email: email,
            createdAt: createdAt);
    replace(_$result);
    return _$result;
  }
}

class _$GLoginUserData_loginUser__asAuthError
    extends GLoginUserData_loginUser__asAuthError {
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

  factory _$GLoginUserData_loginUser__asAuthError(
          [void Function(GLoginUserData_loginUser__asAuthErrorBuilder)?
              updates]) =>
      (new GLoginUserData_loginUser__asAuthErrorBuilder()..update(updates))
          ._build();

  _$GLoginUserData_loginUser__asAuthError._(
      {required this.G__typename,
      this.code,
      this.message,
      this.field,
      this.retryable})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GLoginUserData_loginUser__asAuthError', 'G__typename');
  }

  @override
  GLoginUserData_loginUser__asAuthError rebuild(
          void Function(GLoginUserData_loginUser__asAuthErrorBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GLoginUserData_loginUser__asAuthErrorBuilder toBuilder() =>
      new GLoginUserData_loginUser__asAuthErrorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GLoginUserData_loginUser__asAuthError &&
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
            r'GLoginUserData_loginUser__asAuthError')
          ..add('G__typename', G__typename)
          ..add('code', code)
          ..add('message', message)
          ..add('field', field)
          ..add('retryable', retryable))
        .toString();
  }
}

class GLoginUserData_loginUser__asAuthErrorBuilder
    implements
        Builder<GLoginUserData_loginUser__asAuthError,
            GLoginUserData_loginUser__asAuthErrorBuilder> {
  _$GLoginUserData_loginUser__asAuthError? _$v;

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

  GLoginUserData_loginUser__asAuthErrorBuilder() {
    GLoginUserData_loginUser__asAuthError._initializeBuilder(this);
  }

  GLoginUserData_loginUser__asAuthErrorBuilder get _$this {
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
  void replace(GLoginUserData_loginUser__asAuthError other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GLoginUserData_loginUser__asAuthError;
  }

  @override
  void update(
      void Function(GLoginUserData_loginUser__asAuthErrorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GLoginUserData_loginUser__asAuthError build() => _build();

  _$GLoginUserData_loginUser__asAuthError _build() {
    final _$result = _$v ??
        new _$GLoginUserData_loginUser__asAuthError._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GLoginUserData_loginUser__asAuthError', 'G__typename'),
            code: code,
            message: message,
            field: field,
            retryable: retryable);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
