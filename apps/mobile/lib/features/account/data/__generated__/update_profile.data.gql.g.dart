// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUpdateProfileData> _$gUpdateProfileDataSerializer =
    _$GUpdateProfileDataSerializer();
Serializer<GUpdateProfileData_updateProfile__base>
_$gUpdateProfileDataUpdateProfileBaseSerializer =
    _$GUpdateProfileData_updateProfile__baseSerializer();
Serializer<GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess>
_$gUpdateProfileDataUpdateProfileAsMutationUpdateProfileSuccessSerializer =
    _$GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccessSerializer();
Serializer<
  GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data
>
_$gUpdateProfileDataUpdateProfileAsMutationUpdateProfileSuccessDataSerializer =
    _$GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_dataSerializer();
Serializer<GUpdateProfileData_updateProfile__asValidationError>
_$gUpdateProfileDataUpdateProfileAsValidationErrorSerializer =
    _$GUpdateProfileData_updateProfile__asValidationErrorSerializer();

class _$GUpdateProfileDataSerializer
    implements StructuredSerializer<GUpdateProfileData> {
  @override
  final Iterable<Type> types = const [GUpdateProfileData, _$GUpdateProfileData];
  @override
  final String wireName = 'GUpdateProfileData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GUpdateProfileData object, {
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
    value = object.updateProfile;
    if (value != null) {
      result
        ..add('updateProfile')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(GUpdateProfileData_updateProfile),
          ),
        );
    }
    return result;
  }

  @override
  GUpdateProfileData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GUpdateProfileDataBuilder();

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
        case 'updateProfile':
          result.updateProfile =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(
                      GUpdateProfileData_updateProfile,
                    ),
                  )
                  as GUpdateProfileData_updateProfile?;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateProfileData_updateProfile__baseSerializer
    implements StructuredSerializer<GUpdateProfileData_updateProfile__base> {
  @override
  final Iterable<Type> types = const [
    GUpdateProfileData_updateProfile__base,
    _$GUpdateProfileData_updateProfile__base,
  ];
  @override
  final String wireName = 'GUpdateProfileData_updateProfile__base';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GUpdateProfileData_updateProfile__base object, {
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
  GUpdateProfileData_updateProfile__base deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GUpdateProfileData_updateProfile__baseBuilder();

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

class _$GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccessSerializer
    implements
        StructuredSerializer<
          GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess
        > {
  @override
  final Iterable<Type> types = const [
    GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess,
    _$GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess,
  ];
  @override
  final String wireName =
      'GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess object, {
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
          GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data,
        ),
      ),
    ];

    return result;
  }

  @override
  GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result =
        GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccessBuilder();

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
                    GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data,
                  ),
                )!
                as GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_dataSerializer
    implements
        StructuredSerializer<
          GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data
        > {
  @override
  final Iterable<Type> types = const [
    GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data,
    _$GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data,
  ];
  @override
  final String wireName =
      'GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data
    object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'bookCount',
      serializers.serialize(
        object.bookCount,
        specifiedType: const FullType(int),
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
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.avatarUrl;
    if (value != null) {
      result
        ..add('avatarUrl')
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
  GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data
  deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result =
        GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_dataBuilder();

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
        case 'name':
          result.name =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'avatarUrl':
          result.avatarUrl =
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
        case 'bookCount':
          result.bookCount =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateProfileData_updateProfile__asValidationErrorSerializer
    implements
        StructuredSerializer<
          GUpdateProfileData_updateProfile__asValidationError
        > {
  @override
  final Iterable<Type> types = const [
    GUpdateProfileData_updateProfile__asValidationError,
    _$GUpdateProfileData_updateProfile__asValidationError,
  ];
  @override
  final String wireName = 'GUpdateProfileData_updateProfile__asValidationError';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GUpdateProfileData_updateProfile__asValidationError object, {
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
          serializers.serialize(value, specifiedType: const FullType(String)),
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
    return result;
  }

  @override
  GUpdateProfileData_updateProfile__asValidationError deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GUpdateProfileData_updateProfile__asValidationErrorBuilder();

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
                    specifiedType: const FullType(String),
                  )
                  as String?;
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
      }
    }

    return result.build();
  }
}

class _$GUpdateProfileData extends GUpdateProfileData {
  @override
  final String G__typename;
  @override
  final GUpdateProfileData_updateProfile? updateProfile;

  factory _$GUpdateProfileData([
    void Function(GUpdateProfileDataBuilder)? updates,
  ]) => (GUpdateProfileDataBuilder()..update(updates))._build();

  _$GUpdateProfileData._({required this.G__typename, this.updateProfile})
    : super._();
  @override
  GUpdateProfileData rebuild(
    void Function(GUpdateProfileDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GUpdateProfileDataBuilder toBuilder() =>
      GUpdateProfileDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateProfileData &&
        G__typename == other.G__typename &&
        updateProfile == other.updateProfile;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, updateProfile.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateProfileData')
          ..add('G__typename', G__typename)
          ..add('updateProfile', updateProfile))
        .toString();
  }
}

class GUpdateProfileDataBuilder
    implements Builder<GUpdateProfileData, GUpdateProfileDataBuilder> {
  _$GUpdateProfileData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GUpdateProfileData_updateProfile? _updateProfile;
  GUpdateProfileData_updateProfile? get updateProfile => _$this._updateProfile;
  set updateProfile(GUpdateProfileData_updateProfile? updateProfile) =>
      _$this._updateProfile = updateProfile;

  GUpdateProfileDataBuilder() {
    GUpdateProfileData._initializeBuilder(this);
  }

  GUpdateProfileDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _updateProfile = $v.updateProfile;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateProfileData other) {
    _$v = other as _$GUpdateProfileData;
  }

  @override
  void update(void Function(GUpdateProfileDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateProfileData build() => _build();

  _$GUpdateProfileData _build() {
    final _$result =
        _$v ??
        _$GUpdateProfileData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GUpdateProfileData',
            'G__typename',
          ),
          updateProfile: updateProfile,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateProfileData_updateProfile__base
    extends GUpdateProfileData_updateProfile__base {
  @override
  final String G__typename;

  factory _$GUpdateProfileData_updateProfile__base([
    void Function(GUpdateProfileData_updateProfile__baseBuilder)? updates,
  ]) => (GUpdateProfileData_updateProfile__baseBuilder()..update(updates))
      ._build();

  _$GUpdateProfileData_updateProfile__base._({required this.G__typename})
    : super._();
  @override
  GUpdateProfileData_updateProfile__base rebuild(
    void Function(GUpdateProfileData_updateProfile__baseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GUpdateProfileData_updateProfile__baseBuilder toBuilder() =>
      GUpdateProfileData_updateProfile__baseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateProfileData_updateProfile__base &&
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
      r'GUpdateProfileData_updateProfile__base',
    )..add('G__typename', G__typename)).toString();
  }
}

class GUpdateProfileData_updateProfile__baseBuilder
    implements
        Builder<
          GUpdateProfileData_updateProfile__base,
          GUpdateProfileData_updateProfile__baseBuilder
        > {
  _$GUpdateProfileData_updateProfile__base? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GUpdateProfileData_updateProfile__baseBuilder() {
    GUpdateProfileData_updateProfile__base._initializeBuilder(this);
  }

  GUpdateProfileData_updateProfile__baseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateProfileData_updateProfile__base other) {
    _$v = other as _$GUpdateProfileData_updateProfile__base;
  }

  @override
  void update(
    void Function(GUpdateProfileData_updateProfile__baseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateProfileData_updateProfile__base build() => _build();

  _$GUpdateProfileData_updateProfile__base _build() {
    final _$result =
        _$v ??
        _$GUpdateProfileData_updateProfile__base._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GUpdateProfileData_updateProfile__base',
            'G__typename',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess
    extends GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess {
  @override
  final String G__typename;
  @override
  final GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data
  data;

  factory _$GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess([
    void Function(
      GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccessBuilder,
    )?
    updates,
  ]) =>
      (GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccessBuilder()
            ..update(updates))
          ._build();

  _$GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess._({
    required this.G__typename,
    required this.data,
  }) : super._();
  @override
  GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess rebuild(
    void Function(
      GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccessBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccessBuilder
  toBuilder() =>
      GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccessBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess &&
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
            r'GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess',
          )
          ..add('G__typename', G__typename)
          ..add('data', data))
        .toString();
  }
}

class GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccessBuilder
    implements
        Builder<
          GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess,
          GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccessBuilder
        > {
  _$GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_dataBuilder?
  _data;
  GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_dataBuilder
  get data => _$this._data ??=
      GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_dataBuilder();
  set data(
    GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_dataBuilder?
    data,
  ) => _$this._data = data;

  GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccessBuilder() {
    GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess._initializeBuilder(
      this,
    );
  }

  GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccessBuilder
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
    GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess other,
  ) {
    _$v =
        other
            as _$GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess;
  }

  @override
  void update(
    void Function(
      GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccessBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess build() =>
      _build();

  _$GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess _build() {
    _$GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess _$result;
    try {
      _$result =
          _$v ??
          _$GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess',
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
          r'GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess',
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

class _$GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data
    extends
        GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data {
  @override
  final String G__typename;
  @override
  final int? id;
  @override
  final String? email;
  @override
  final String? name;
  @override
  final String? avatarUrl;
  @override
  final DateTime? createdAt;
  @override
  final int bookCount;

  factory _$GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data([
    void Function(
      GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_dataBuilder,
    )?
    updates,
  ]) =>
      (GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_dataBuilder()
            ..update(updates))
          ._build();

  _$GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data._({
    required this.G__typename,
    this.id,
    this.email,
    this.name,
    this.avatarUrl,
    this.createdAt,
    required this.bookCount,
  }) : super._();
  @override
  GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data rebuild(
    void Function(
      GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_dataBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_dataBuilder
  toBuilder() =>
      GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_dataBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data &&
        G__typename == other.G__typename &&
        id == other.id &&
        email == other.email &&
        name == other.name &&
        avatarUrl == other.avatarUrl &&
        createdAt == other.createdAt &&
        bookCount == other.bookCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, avatarUrl.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, bookCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('email', email)
          ..add('name', name)
          ..add('avatarUrl', avatarUrl)
          ..add('createdAt', createdAt)
          ..add('bookCount', bookCount))
        .toString();
  }
}

class GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_dataBuilder
    implements
        Builder<
          GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data,
          GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_dataBuilder
        > {
  _$GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _avatarUrl;
  String? get avatarUrl => _$this._avatarUrl;
  set avatarUrl(String? avatarUrl) => _$this._avatarUrl = avatarUrl;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  int? _bookCount;
  int? get bookCount => _$this._bookCount;
  set bookCount(int? bookCount) => _$this._bookCount = bookCount;

  GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_dataBuilder() {
    GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data._initializeBuilder(
      this,
    );
  }

  GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_dataBuilder
  get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _email = $v.email;
      _name = $v.name;
      _avatarUrl = $v.avatarUrl;
      _createdAt = $v.createdAt;
      _bookCount = $v.bookCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
    GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data other,
  ) {
    _$v =
        other
            as _$GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data;
  }

  @override
  void update(
    void Function(
      GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_dataBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data
  build() => _build();

  _$GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data
  _build() {
    final _$result =
        _$v ??
        _$GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data',
            'G__typename',
          ),
          id: id,
          email: email,
          name: name,
          avatarUrl: avatarUrl,
          createdAt: createdAt,
          bookCount: BuiltValueNullFieldError.checkNotNull(
            bookCount,
            r'GUpdateProfileData_updateProfile__asMutationUpdateProfileSuccess_data',
            'bookCount',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateProfileData_updateProfile__asValidationError
    extends GUpdateProfileData_updateProfile__asValidationError {
  @override
  final String G__typename;
  @override
  final String? code;
  @override
  final String? message;
  @override
  final String? field;

  factory _$GUpdateProfileData_updateProfile__asValidationError([
    void Function(GUpdateProfileData_updateProfile__asValidationErrorBuilder)?
    updates,
  ]) =>
      (GUpdateProfileData_updateProfile__asValidationErrorBuilder()
            ..update(updates))
          ._build();

  _$GUpdateProfileData_updateProfile__asValidationError._({
    required this.G__typename,
    this.code,
    this.message,
    this.field,
  }) : super._();
  @override
  GUpdateProfileData_updateProfile__asValidationError rebuild(
    void Function(GUpdateProfileData_updateProfile__asValidationErrorBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GUpdateProfileData_updateProfile__asValidationErrorBuilder toBuilder() =>
      GUpdateProfileData_updateProfile__asValidationErrorBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateProfileData_updateProfile__asValidationError &&
        G__typename == other.G__typename &&
        code == other.code &&
        message == other.message &&
        field == other.field;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, field.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GUpdateProfileData_updateProfile__asValidationError',
          )
          ..add('G__typename', G__typename)
          ..add('code', code)
          ..add('message', message)
          ..add('field', field))
        .toString();
  }
}

class GUpdateProfileData_updateProfile__asValidationErrorBuilder
    implements
        Builder<
          GUpdateProfileData_updateProfile__asValidationError,
          GUpdateProfileData_updateProfile__asValidationErrorBuilder
        > {
  _$GUpdateProfileData_updateProfile__asValidationError? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _field;
  String? get field => _$this._field;
  set field(String? field) => _$this._field = field;

  GUpdateProfileData_updateProfile__asValidationErrorBuilder() {
    GUpdateProfileData_updateProfile__asValidationError._initializeBuilder(
      this,
    );
  }

  GUpdateProfileData_updateProfile__asValidationErrorBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _code = $v.code;
      _message = $v.message;
      _field = $v.field;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateProfileData_updateProfile__asValidationError other) {
    _$v = other as _$GUpdateProfileData_updateProfile__asValidationError;
  }

  @override
  void update(
    void Function(GUpdateProfileData_updateProfile__asValidationErrorBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateProfileData_updateProfile__asValidationError build() => _build();

  _$GUpdateProfileData_updateProfile__asValidationError _build() {
    final _$result =
        _$v ??
        _$GUpdateProfileData_updateProfile__asValidationError._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GUpdateProfileData_updateProfile__asValidationError',
            'G__typename',
          ),
          code: code,
          message: message,
          field: field,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
