// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_user.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GRegisterUserData> _$gRegisterUserDataSerializer =
    _$GRegisterUserDataSerializer();
Serializer<GRegisterUserData_registerUser__base>
_$gRegisterUserDataRegisterUserBaseSerializer =
    _$GRegisterUserData_registerUser__baseSerializer();
Serializer<GRegisterUserData_registerUser__asMutationRegisterUserSuccess>
_$gRegisterUserDataRegisterUserAsMutationRegisterUserSuccessSerializer =
    _$GRegisterUserData_registerUser__asMutationRegisterUserSuccessSerializer();
Serializer<GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data>
_$gRegisterUserDataRegisterUserAsMutationRegisterUserSuccessDataSerializer =
    _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess_dataSerializer();
Serializer<
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user
>
_$gRegisterUserDataRegisterUserAsMutationRegisterUserSuccessDataUserSerializer =
    _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_userSerializer();
Serializer<GRegisterUserData_registerUser__asAuthError>
_$gRegisterUserDataRegisterUserAsAuthErrorSerializer =
    _$GRegisterUserData_registerUser__asAuthErrorSerializer();

class _$GRegisterUserDataSerializer
    implements StructuredSerializer<GRegisterUserData> {
  @override
  final Iterable<Type> types = const [GRegisterUserData, _$GRegisterUserData];
  @override
  final String wireName = 'GRegisterUserData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GRegisterUserData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
    ];
    Object? value;
    value = object.registerUser;
    if (value != null) {
      result
        ..add('registerUser')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(GRegisterUserData_registerUser),
          ),
        );
    }
    return result;
  }

  @override
  GRegisterUserData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GRegisterUserDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'registerUser':
          result.registerUser =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(
                      GRegisterUserData_registerUser,
                    ),
                  )
                  as GRegisterUserData_registerUser?;
          break;
      }
    }

    return result.build();
  }
}

class _$GRegisterUserData_registerUser__baseSerializer
    implements StructuredSerializer<GRegisterUserData_registerUser__base> {
  @override
  final Iterable<Type> types = const [
    GRegisterUserData_registerUser__base,
    _$GRegisterUserData_registerUser__base,
  ];
  @override
  final String wireName = 'GRegisterUserData_registerUser__base';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GRegisterUserData_registerUser__base object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
    ];

    return result;
  }

  @override
  GRegisterUserData_registerUser__base deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GRegisterUserData_registerUser__baseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GRegisterUserData_registerUser__asMutationRegisterUserSuccessSerializer
    implements
        StructuredSerializer<
          GRegisterUserData_registerUser__asMutationRegisterUserSuccess
        > {
  @override
  final Iterable<Type> types = const [
    GRegisterUserData_registerUser__asMutationRegisterUserSuccess,
    _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess,
  ];
  @override
  final String wireName =
      'GRegisterUserData_registerUser__asMutationRegisterUserSuccess';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GRegisterUserData_registerUser__asMutationRegisterUserSuccess object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'data',
      serializers.serialize(
        object.data,
        specifiedType: const FullType(
          GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data,
        ),
      ),
    ];

    return result;
  }

  @override
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result =
        GRegisterUserData_registerUser__asMutationRegisterUserSuccessBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'data':
          result.data.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data,
                  ),
                )!
                as GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess_dataSerializer
    implements
        StructuredSerializer<
          GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data
        > {
  @override
  final Iterable<Type> types = const [
    GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data,
    _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data,
  ];
  @override
  final String wireName =
      'GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'user',
      serializers.serialize(
        object.user,
        specifiedType: const FullType(
          GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user,
        ),
      ),
      'idToken',
      serializers.serialize(
        object.idToken,
        specifiedType: const FullType(String),
      ),
      'refreshToken',
      serializers.serialize(
        object.refreshToken,
        specifiedType: const FullType(String),
      ),
    ];

    return result;
  }

  @override
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data
  deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result =
        GRegisterUserData_registerUser__asMutationRegisterUserSuccess_dataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'user':
          result.user.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user,
                  ),
                )!
                as GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user,
          );
          break;
        case 'idToken':
          result.idToken =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'refreshToken':
          result.refreshToken =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_userSerializer
    implements
        StructuredSerializer<
          GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user
        > {
  @override
  final Iterable<Type> types = const [
    GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user,
    _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user,
  ];
  @override
  final String wireName =
      'GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user
    object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
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
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.createdAt;
    if (value != null) {
      result
        ..add('createdAt')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(DateTime)),
        );
    }
    return result;
  }

  @override
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user
  deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result =
        GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_userBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'id':
          result.id =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int?;
          break;
        case 'email':
          result.email =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'createdAt':
          result.createdAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(DateTime),
                  )
                  as DateTime?;
          break;
      }
    }

    return result.build();
  }
}

class _$GRegisterUserData_registerUser__asAuthErrorSerializer
    implements
        StructuredSerializer<GRegisterUserData_registerUser__asAuthError> {
  @override
  final Iterable<Type> types = const [
    GRegisterUserData_registerUser__asAuthError,
    _$GRegisterUserData_registerUser__asAuthError,
  ];
  @override
  final String wireName = 'GRegisterUserData_registerUser__asAuthError';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GRegisterUserData_registerUser__asAuthError object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
    ];
    Object? value;
    value = object.code;
    if (value != null) {
      result
        ..add('code')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(_i3.GAuthErrorCode),
          ),
        );
    }
    value = object.message;
    if (value != null) {
      result
        ..add('message')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.field;
    if (value != null) {
      result
        ..add('field')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.retryable;
    if (value != null) {
      result
        ..add('retryable')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(bool)),
        );
    }
    return result;
  }

  @override
  GRegisterUserData_registerUser__asAuthError deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GRegisterUserData_registerUser__asAuthErrorBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'code':
          result.code =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i3.GAuthErrorCode),
                  )
                  as _i3.GAuthErrorCode?;
          break;
        case 'message':
          result.message =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'field':
          result.field =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'retryable':
          result.retryable =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$GRegisterUserData extends GRegisterUserData {
  @override
  final String G__typename;
  @override
  final GRegisterUserData_registerUser? registerUser;

  factory _$GRegisterUserData([
    void Function(GRegisterUserDataBuilder)? updates,
  ]) => (GRegisterUserDataBuilder()..update(updates))._build();

  _$GRegisterUserData._({required this.G__typename, this.registerUser})
    : super._();
  @override
  GRegisterUserData rebuild(void Function(GRegisterUserDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRegisterUserDataBuilder toBuilder() =>
      GRegisterUserDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRegisterUserData &&
        G__typename == other.G__typename &&
        registerUser == other.registerUser;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, registerUser.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRegisterUserData')
          ..add('G__typename', G__typename)
          ..add('registerUser', registerUser))
        .toString();
  }
}

class GRegisterUserDataBuilder
    implements Builder<GRegisterUserData, GRegisterUserDataBuilder> {
  _$GRegisterUserData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GRegisterUserData_registerUser? _registerUser;
  GRegisterUserData_registerUser? get registerUser => _$this._registerUser;
  set registerUser(GRegisterUserData_registerUser? registerUser) =>
      _$this._registerUser = registerUser;

  GRegisterUserDataBuilder() {
    GRegisterUserData._initializeBuilder(this);
  }

  GRegisterUserDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _registerUser = $v.registerUser;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRegisterUserData other) {
    _$v = other as _$GRegisterUserData;
  }

  @override
  void update(void Function(GRegisterUserDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRegisterUserData build() => _build();

  _$GRegisterUserData _build() {
    final _$result =
        _$v ??
        _$GRegisterUserData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GRegisterUserData',
            'G__typename',
          ),
          registerUser: registerUser,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GRegisterUserData_registerUser__base
    extends GRegisterUserData_registerUser__base {
  @override
  final String G__typename;

  factory _$GRegisterUserData_registerUser__base([
    void Function(GRegisterUserData_registerUser__baseBuilder)? updates,
  ]) =>
      (GRegisterUserData_registerUser__baseBuilder()..update(updates))._build();

  _$GRegisterUserData_registerUser__base._({required this.G__typename})
    : super._();
  @override
  GRegisterUserData_registerUser__base rebuild(
    void Function(GRegisterUserData_registerUser__baseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GRegisterUserData_registerUser__baseBuilder toBuilder() =>
      GRegisterUserData_registerUser__baseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRegisterUserData_registerUser__base &&
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
      r'GRegisterUserData_registerUser__base',
    )..add('G__typename', G__typename)).toString();
  }
}

class GRegisterUserData_registerUser__baseBuilder
    implements
        Builder<
          GRegisterUserData_registerUser__base,
          GRegisterUserData_registerUser__baseBuilder
        > {
  _$GRegisterUserData_registerUser__base? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GRegisterUserData_registerUser__baseBuilder() {
    GRegisterUserData_registerUser__base._initializeBuilder(this);
  }

  GRegisterUserData_registerUser__baseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRegisterUserData_registerUser__base other) {
    _$v = other as _$GRegisterUserData_registerUser__base;
  }

  @override
  void update(
    void Function(GRegisterUserData_registerUser__baseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GRegisterUserData_registerUser__base build() => _build();

  _$GRegisterUserData_registerUser__base _build() {
    final _$result =
        _$v ??
        _$GRegisterUserData_registerUser__base._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GRegisterUserData_registerUser__base',
            'G__typename',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess
    extends GRegisterUserData_registerUser__asMutationRegisterUserSuccess {
  @override
  final String G__typename;
  @override
  final GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data data;

  factory _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess([
    void Function(
      GRegisterUserData_registerUser__asMutationRegisterUserSuccessBuilder,
    )?
    updates,
  ]) =>
      (GRegisterUserData_registerUser__asMutationRegisterUserSuccessBuilder()
            ..update(updates))
          ._build();

  _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess._({
    required this.G__typename,
    required this.data,
  }) : super._();
  @override
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess rebuild(
    void Function(
      GRegisterUserData_registerUser__asMutationRegisterUserSuccessBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GRegisterUserData_registerUser__asMutationRegisterUserSuccessBuilder
  toBuilder() =>
      GRegisterUserData_registerUser__asMutationRegisterUserSuccessBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GRegisterUserData_registerUser__asMutationRegisterUserSuccess &&
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
            r'GRegisterUserData_registerUser__asMutationRegisterUserSuccess',
          )
          ..add('G__typename', G__typename)
          ..add('data', data))
        .toString();
  }
}

class GRegisterUserData_registerUser__asMutationRegisterUserSuccessBuilder
    implements
        Builder<
          GRegisterUserData_registerUser__asMutationRegisterUserSuccess,
          GRegisterUserData_registerUser__asMutationRegisterUserSuccessBuilder
        > {
  _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_dataBuilder?
  _data;
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_dataBuilder
  get data => _$this._data ??=
      GRegisterUserData_registerUser__asMutationRegisterUserSuccess_dataBuilder();
  set data(
    GRegisterUserData_registerUser__asMutationRegisterUserSuccess_dataBuilder?
    data,
  ) => _$this._data = data;

  GRegisterUserData_registerUser__asMutationRegisterUserSuccessBuilder() {
    GRegisterUserData_registerUser__asMutationRegisterUserSuccess._initializeBuilder(
      this,
    );
  }

  GRegisterUserData_registerUser__asMutationRegisterUserSuccessBuilder
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
    GRegisterUserData_registerUser__asMutationRegisterUserSuccess other,
  ) {
    _$v =
        other
            as _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess;
  }

  @override
  void update(
    void Function(
      GRegisterUserData_registerUser__asMutationRegisterUserSuccessBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess build() =>
      _build();

  _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess _build() {
    _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess _$result;
    try {
      _$result =
          _$v ??
          _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GRegisterUserData_registerUser__asMutationRegisterUserSuccess',
              'G__typename',
            ),
            data: data.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GRegisterUserData_registerUser__asMutationRegisterUserSuccess',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data
    extends GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data {
  @override
  final String G__typename;
  @override
  final GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user
  user;
  @override
  final String idToken;
  @override
  final String refreshToken;

  factory _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data([
    void Function(
      GRegisterUserData_registerUser__asMutationRegisterUserSuccess_dataBuilder,
    )?
    updates,
  ]) =>
      (GRegisterUserData_registerUser__asMutationRegisterUserSuccess_dataBuilder()
            ..update(updates))
          ._build();

  _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data._({
    required this.G__typename,
    required this.user,
    required this.idToken,
    required this.refreshToken,
  }) : super._();
  @override
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data rebuild(
    void Function(
      GRegisterUserData_registerUser__asMutationRegisterUserSuccess_dataBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_dataBuilder
  toBuilder() =>
      GRegisterUserData_registerUser__asMutationRegisterUserSuccess_dataBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data &&
        G__typename == other.G__typename &&
        user == other.user &&
        idToken == other.idToken &&
        refreshToken == other.refreshToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jc(_$hash, idToken.hashCode);
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data',
          )
          ..add('G__typename', G__typename)
          ..add('user', user)
          ..add('idToken', idToken)
          ..add('refreshToken', refreshToken))
        .toString();
  }
}

class GRegisterUserData_registerUser__asMutationRegisterUserSuccess_dataBuilder
    implements
        Builder<
          GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data,
          GRegisterUserData_registerUser__asMutationRegisterUserSuccess_dataBuilder
        > {
  _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_userBuilder?
  _user;
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_userBuilder
  get user => _$this._user ??=
      GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_userBuilder();
  set user(
    GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_userBuilder?
    user,
  ) => _$this._user = user;

  String? _idToken;
  String? get idToken => _$this._idToken;
  set idToken(String? idToken) => _$this._idToken = idToken;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_dataBuilder() {
    GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data._initializeBuilder(
      this,
    );
  }

  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_dataBuilder
  get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _user = $v.user.toBuilder();
      _idToken = $v.idToken;
      _refreshToken = $v.refreshToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
    GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data other,
  ) {
    _$v =
        other
            as _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data;
  }

  @override
  void update(
    void Function(
      GRegisterUserData_registerUser__asMutationRegisterUserSuccess_dataBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data build() =>
      _build();

  _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data
  _build() {
    _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data
    _$result;
    try {
      _$result =
          _$v ??
          _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data',
              'G__typename',
            ),
            user: user.build(),
            idToken: BuiltValueNullFieldError.checkNotNull(
              idToken,
              r'GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data',
              'idToken',
            ),
            refreshToken: BuiltValueNullFieldError.checkNotNull(
              refreshToken,
              r'GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data',
              'refreshToken',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user
    extends
        GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user {
  @override
  final String G__typename;
  @override
  final int? id;
  @override
  final String? email;
  @override
  final DateTime? createdAt;

  factory _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user([
    void Function(
      GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_userBuilder,
    )?
    updates,
  ]) =>
      (GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_userBuilder()
            ..update(updates))
          ._build();

  _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user._({
    required this.G__typename,
    this.id,
    this.email,
    this.createdAt,
  }) : super._();
  @override
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user
  rebuild(
    void Function(
      GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_userBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_userBuilder
  toBuilder() =>
      GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_userBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user &&
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
            r'GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('email', email)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_userBuilder
    implements
        Builder<
          GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user,
          GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_userBuilder
        > {
  _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user?
  _$v;

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

  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_userBuilder() {
    GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user._initializeBuilder(
      this,
    );
  }

  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_userBuilder
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
    GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user
    other,
  ) {
    _$v =
        other
            as _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user;
  }

  @override
  void update(
    void Function(
      GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_userBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user
  build() => _build();

  _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user
  _build() {
    final _$result =
        _$v ??
        _$GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GRegisterUserData_registerUser__asMutationRegisterUserSuccess_data_user',
            'G__typename',
          ),
          id: id,
          email: email,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GRegisterUserData_registerUser__asAuthError
    extends GRegisterUserData_registerUser__asAuthError {
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

  factory _$GRegisterUserData_registerUser__asAuthError([
    void Function(GRegisterUserData_registerUser__asAuthErrorBuilder)? updates,
  ]) => (GRegisterUserData_registerUser__asAuthErrorBuilder()..update(updates))
      ._build();

  _$GRegisterUserData_registerUser__asAuthError._({
    required this.G__typename,
    this.code,
    this.message,
    this.field,
    this.retryable,
  }) : super._();
  @override
  GRegisterUserData_registerUser__asAuthError rebuild(
    void Function(GRegisterUserData_registerUser__asAuthErrorBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GRegisterUserData_registerUser__asAuthErrorBuilder toBuilder() =>
      GRegisterUserData_registerUser__asAuthErrorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRegisterUserData_registerUser__asAuthError &&
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
            r'GRegisterUserData_registerUser__asAuthError',
          )
          ..add('G__typename', G__typename)
          ..add('code', code)
          ..add('message', message)
          ..add('field', field)
          ..add('retryable', retryable))
        .toString();
  }
}

class GRegisterUserData_registerUser__asAuthErrorBuilder
    implements
        Builder<
          GRegisterUserData_registerUser__asAuthError,
          GRegisterUserData_registerUser__asAuthErrorBuilder
        > {
  _$GRegisterUserData_registerUser__asAuthError? _$v;

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

  GRegisterUserData_registerUser__asAuthErrorBuilder() {
    GRegisterUserData_registerUser__asAuthError._initializeBuilder(this);
  }

  GRegisterUserData_registerUser__asAuthErrorBuilder get _$this {
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
  void replace(GRegisterUserData_registerUser__asAuthError other) {
    _$v = other as _$GRegisterUserData_registerUser__asAuthError;
  }

  @override
  void update(
    void Function(GRegisterUserData_registerUser__asAuthErrorBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GRegisterUserData_registerUser__asAuthError build() => _build();

  _$GRegisterUserData_registerUser__asAuthError _build() {
    final _$result =
        _$v ??
        _$GRegisterUserData_registerUser__asAuthError._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GRegisterUserData_registerUser__asAuthError',
            'G__typename',
          ),
          code: code,
          message: message,
          field: field,
          retryable: retryable,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
