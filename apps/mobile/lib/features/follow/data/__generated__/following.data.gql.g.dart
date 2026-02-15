// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'following.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GFollowingData> _$gFollowingDataSerializer =
    _$GFollowingDataSerializer();
Serializer<GFollowingData_following> _$gFollowingDataFollowingSerializer =
    _$GFollowingData_followingSerializer();

class _$GFollowingDataSerializer
    implements StructuredSerializer<GFollowingData> {
  @override
  final Iterable<Type> types = const [GFollowingData, _$GFollowingData];
  @override
  final String wireName = 'GFollowingData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GFollowingData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.following;
    if (value != null) {
      result
        ..add('following')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(GFollowingData_following)])));
    }
    return result;
  }

  @override
  GFollowingData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GFollowingDataBuilder();

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
        case 'following':
          result.following.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GFollowingData_following)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GFollowingData_followingSerializer
    implements StructuredSerializer<GFollowingData_following> {
  @override
  final Iterable<Type> types = const [
    GFollowingData_following,
    _$GFollowingData_following
  ];
  @override
  final String wireName = 'GFollowingData_following';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GFollowingData_following object,
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
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.avatarUrl;
    if (value != null) {
      result
        ..add('avatarUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.handle;
    if (value != null) {
      result
        ..add('handle')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GFollowingData_following deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GFollowingData_followingBuilder();

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
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'avatarUrl':
          result.avatarUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'handle':
          result.handle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GFollowingData extends GFollowingData {
  @override
  final String G__typename;
  @override
  final BuiltList<GFollowingData_following>? following;

  factory _$GFollowingData([void Function(GFollowingDataBuilder)? updates]) =>
      (GFollowingDataBuilder()..update(updates))._build();

  _$GFollowingData._({required this.G__typename, this.following}) : super._();
  @override
  GFollowingData rebuild(void Function(GFollowingDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GFollowingDataBuilder toBuilder() => GFollowingDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GFollowingData &&
        G__typename == other.G__typename &&
        following == other.following;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, following.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GFollowingData')
          ..add('G__typename', G__typename)
          ..add('following', following))
        .toString();
  }
}

class GFollowingDataBuilder
    implements Builder<GFollowingData, GFollowingDataBuilder> {
  _$GFollowingData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GFollowingData_following>? _following;
  ListBuilder<GFollowingData_following> get following =>
      _$this._following ??= ListBuilder<GFollowingData_following>();
  set following(ListBuilder<GFollowingData_following>? following) =>
      _$this._following = following;

  GFollowingDataBuilder() {
    GFollowingData._initializeBuilder(this);
  }

  GFollowingDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _following = $v.following?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GFollowingData other) {
    _$v = other as _$GFollowingData;
  }

  @override
  void update(void Function(GFollowingDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GFollowingData build() => _build();

  _$GFollowingData _build() {
    _$GFollowingData _$result;
    try {
      _$result = _$v ??
          _$GFollowingData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GFollowingData', 'G__typename'),
            following: _following?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'following';
        _following?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GFollowingData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GFollowingData_following extends GFollowingData_following {
  @override
  final String G__typename;
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? avatarUrl;
  @override
  final String? handle;

  factory _$GFollowingData_following(
          [void Function(GFollowingData_followingBuilder)? updates]) =>
      (GFollowingData_followingBuilder()..update(updates))._build();

  _$GFollowingData_following._(
      {required this.G__typename,
      this.id,
      this.name,
      this.avatarUrl,
      this.handle})
      : super._();
  @override
  GFollowingData_following rebuild(
          void Function(GFollowingData_followingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GFollowingData_followingBuilder toBuilder() =>
      GFollowingData_followingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GFollowingData_following &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name &&
        avatarUrl == other.avatarUrl &&
        handle == other.handle;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, avatarUrl.hashCode);
    _$hash = $jc(_$hash, handle.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GFollowingData_following')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name)
          ..add('avatarUrl', avatarUrl)
          ..add('handle', handle))
        .toString();
  }
}

class GFollowingData_followingBuilder
    implements
        Builder<GFollowingData_following, GFollowingData_followingBuilder> {
  _$GFollowingData_following? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _avatarUrl;
  String? get avatarUrl => _$this._avatarUrl;
  set avatarUrl(String? avatarUrl) => _$this._avatarUrl = avatarUrl;

  String? _handle;
  String? get handle => _$this._handle;
  set handle(String? handle) => _$this._handle = handle;

  GFollowingData_followingBuilder() {
    GFollowingData_following._initializeBuilder(this);
  }

  GFollowingData_followingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _avatarUrl = $v.avatarUrl;
      _handle = $v.handle;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GFollowingData_following other) {
    _$v = other as _$GFollowingData_following;
  }

  @override
  void update(void Function(GFollowingData_followingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GFollowingData_following build() => _build();

  _$GFollowingData_following _build() {
    final _$result = _$v ??
        _$GFollowingData_following._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GFollowingData_following', 'G__typename'),
          id: id,
          name: name,
          avatarUrl: avatarUrl,
          handle: handle,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
