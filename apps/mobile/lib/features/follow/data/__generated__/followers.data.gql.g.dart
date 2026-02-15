// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'followers.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GFollowersData> _$gFollowersDataSerializer =
    _$GFollowersDataSerializer();
Serializer<GFollowersData_followers> _$gFollowersDataFollowersSerializer =
    _$GFollowersData_followersSerializer();

class _$GFollowersDataSerializer
    implements StructuredSerializer<GFollowersData> {
  @override
  final Iterable<Type> types = const [GFollowersData, _$GFollowersData];
  @override
  final String wireName = 'GFollowersData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GFollowersData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.followers;
    if (value != null) {
      result
        ..add('followers')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(GFollowersData_followers)])));
    }
    return result;
  }

  @override
  GFollowersData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GFollowersDataBuilder();

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
        case 'followers':
          result.followers.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GFollowersData_followers)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GFollowersData_followersSerializer
    implements StructuredSerializer<GFollowersData_followers> {
  @override
  final Iterable<Type> types = const [
    GFollowersData_followers,
    _$GFollowersData_followers
  ];
  @override
  final String wireName = 'GFollowersData_followers';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GFollowersData_followers object,
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
  GFollowersData_followers deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GFollowersData_followersBuilder();

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

class _$GFollowersData extends GFollowersData {
  @override
  final String G__typename;
  @override
  final BuiltList<GFollowersData_followers>? followers;

  factory _$GFollowersData([void Function(GFollowersDataBuilder)? updates]) =>
      (GFollowersDataBuilder()..update(updates))._build();

  _$GFollowersData._({required this.G__typename, this.followers}) : super._();
  @override
  GFollowersData rebuild(void Function(GFollowersDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GFollowersDataBuilder toBuilder() => GFollowersDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GFollowersData &&
        G__typename == other.G__typename &&
        followers == other.followers;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, followers.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GFollowersData')
          ..add('G__typename', G__typename)
          ..add('followers', followers))
        .toString();
  }
}

class GFollowersDataBuilder
    implements Builder<GFollowersData, GFollowersDataBuilder> {
  _$GFollowersData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GFollowersData_followers>? _followers;
  ListBuilder<GFollowersData_followers> get followers =>
      _$this._followers ??= ListBuilder<GFollowersData_followers>();
  set followers(ListBuilder<GFollowersData_followers>? followers) =>
      _$this._followers = followers;

  GFollowersDataBuilder() {
    GFollowersData._initializeBuilder(this);
  }

  GFollowersDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _followers = $v.followers?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GFollowersData other) {
    _$v = other as _$GFollowersData;
  }

  @override
  void update(void Function(GFollowersDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GFollowersData build() => _build();

  _$GFollowersData _build() {
    _$GFollowersData _$result;
    try {
      _$result = _$v ??
          _$GFollowersData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GFollowersData', 'G__typename'),
            followers: _followers?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'followers';
        _followers?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GFollowersData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GFollowersData_followers extends GFollowersData_followers {
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

  factory _$GFollowersData_followers(
          [void Function(GFollowersData_followersBuilder)? updates]) =>
      (GFollowersData_followersBuilder()..update(updates))._build();

  _$GFollowersData_followers._(
      {required this.G__typename,
      this.id,
      this.name,
      this.avatarUrl,
      this.handle})
      : super._();
  @override
  GFollowersData_followers rebuild(
          void Function(GFollowersData_followersBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GFollowersData_followersBuilder toBuilder() =>
      GFollowersData_followersBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GFollowersData_followers &&
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
    return (newBuiltValueToStringHelper(r'GFollowersData_followers')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name)
          ..add('avatarUrl', avatarUrl)
          ..add('handle', handle))
        .toString();
  }
}

class GFollowersData_followersBuilder
    implements
        Builder<GFollowersData_followers, GFollowersData_followersBuilder> {
  _$GFollowersData_followers? _$v;

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

  GFollowersData_followersBuilder() {
    GFollowersData_followers._initializeBuilder(this);
  }

  GFollowersData_followersBuilder get _$this {
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
  void replace(GFollowersData_followers other) {
    _$v = other as _$GFollowersData_followers;
  }

  @override
  void update(void Function(GFollowersData_followersBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GFollowersData_followers build() => _build();

  _$GFollowersData_followers _build() {
    final _$result = _$v ??
        _$GFollowersData_followers._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GFollowersData_followers', 'G__typename'),
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
