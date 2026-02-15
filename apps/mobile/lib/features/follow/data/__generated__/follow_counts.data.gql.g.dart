// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_counts.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GFollowCountsData> _$gFollowCountsDataSerializer =
    _$GFollowCountsDataSerializer();
Serializer<GFollowCountsData_followCounts>
    _$gFollowCountsDataFollowCountsSerializer =
    _$GFollowCountsData_followCountsSerializer();

class _$GFollowCountsDataSerializer
    implements StructuredSerializer<GFollowCountsData> {
  @override
  final Iterable<Type> types = const [GFollowCountsData, _$GFollowCountsData];
  @override
  final String wireName = 'GFollowCountsData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GFollowCountsData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.followCounts;
    if (value != null) {
      result
        ..add('followCounts')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(GFollowCountsData_followCounts)));
    }
    return result;
  }

  @override
  GFollowCountsData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GFollowCountsDataBuilder();

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
        case 'followCounts':
          result.followCounts.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GFollowCountsData_followCounts))!
              as GFollowCountsData_followCounts);
          break;
      }
    }

    return result.build();
  }
}

class _$GFollowCountsData_followCountsSerializer
    implements StructuredSerializer<GFollowCountsData_followCounts> {
  @override
  final Iterable<Type> types = const [
    GFollowCountsData_followCounts,
    _$GFollowCountsData_followCounts
  ];
  @override
  final String wireName = 'GFollowCountsData_followCounts';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GFollowCountsData_followCounts object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.followingCount;
    if (value != null) {
      result
        ..add('followingCount')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.followerCount;
    if (value != null) {
      result
        ..add('followerCount')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  GFollowCountsData_followCounts deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GFollowCountsData_followCountsBuilder();

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
        case 'followingCount':
          result.followingCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'followerCount':
          result.followerCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$GFollowCountsData extends GFollowCountsData {
  @override
  final String G__typename;
  @override
  final GFollowCountsData_followCounts? followCounts;

  factory _$GFollowCountsData(
          [void Function(GFollowCountsDataBuilder)? updates]) =>
      (GFollowCountsDataBuilder()..update(updates))._build();

  _$GFollowCountsData._({required this.G__typename, this.followCounts})
      : super._();
  @override
  GFollowCountsData rebuild(void Function(GFollowCountsDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GFollowCountsDataBuilder toBuilder() =>
      GFollowCountsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GFollowCountsData &&
        G__typename == other.G__typename &&
        followCounts == other.followCounts;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, followCounts.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GFollowCountsData')
          ..add('G__typename', G__typename)
          ..add('followCounts', followCounts))
        .toString();
  }
}

class GFollowCountsDataBuilder
    implements Builder<GFollowCountsData, GFollowCountsDataBuilder> {
  _$GFollowCountsData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GFollowCountsData_followCountsBuilder? _followCounts;
  GFollowCountsData_followCountsBuilder get followCounts =>
      _$this._followCounts ??= GFollowCountsData_followCountsBuilder();
  set followCounts(GFollowCountsData_followCountsBuilder? followCounts) =>
      _$this._followCounts = followCounts;

  GFollowCountsDataBuilder() {
    GFollowCountsData._initializeBuilder(this);
  }

  GFollowCountsDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _followCounts = $v.followCounts?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GFollowCountsData other) {
    _$v = other as _$GFollowCountsData;
  }

  @override
  void update(void Function(GFollowCountsDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GFollowCountsData build() => _build();

  _$GFollowCountsData _build() {
    _$GFollowCountsData _$result;
    try {
      _$result = _$v ??
          _$GFollowCountsData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GFollowCountsData', 'G__typename'),
            followCounts: _followCounts?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'followCounts';
        _followCounts?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GFollowCountsData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GFollowCountsData_followCounts extends GFollowCountsData_followCounts {
  @override
  final String G__typename;
  @override
  final int? followingCount;
  @override
  final int? followerCount;

  factory _$GFollowCountsData_followCounts(
          [void Function(GFollowCountsData_followCountsBuilder)? updates]) =>
      (GFollowCountsData_followCountsBuilder()..update(updates))._build();

  _$GFollowCountsData_followCounts._(
      {required this.G__typename, this.followingCount, this.followerCount})
      : super._();
  @override
  GFollowCountsData_followCounts rebuild(
          void Function(GFollowCountsData_followCountsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GFollowCountsData_followCountsBuilder toBuilder() =>
      GFollowCountsData_followCountsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GFollowCountsData_followCounts &&
        G__typename == other.G__typename &&
        followingCount == other.followingCount &&
        followerCount == other.followerCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, followingCount.hashCode);
    _$hash = $jc(_$hash, followerCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GFollowCountsData_followCounts')
          ..add('G__typename', G__typename)
          ..add('followingCount', followingCount)
          ..add('followerCount', followerCount))
        .toString();
  }
}

class GFollowCountsData_followCountsBuilder
    implements
        Builder<GFollowCountsData_followCounts,
            GFollowCountsData_followCountsBuilder> {
  _$GFollowCountsData_followCounts? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _followingCount;
  int? get followingCount => _$this._followingCount;
  set followingCount(int? followingCount) =>
      _$this._followingCount = followingCount;

  int? _followerCount;
  int? get followerCount => _$this._followerCount;
  set followerCount(int? followerCount) =>
      _$this._followerCount = followerCount;

  GFollowCountsData_followCountsBuilder() {
    GFollowCountsData_followCounts._initializeBuilder(this);
  }

  GFollowCountsData_followCountsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _followingCount = $v.followingCount;
      _followerCount = $v.followerCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GFollowCountsData_followCounts other) {
    _$v = other as _$GFollowCountsData_followCounts;
  }

  @override
  void update(void Function(GFollowCountsData_followCountsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GFollowCountsData_followCounts build() => _build();

  _$GFollowCountsData_followCounts _build() {
    final _$result = _$v ??
        _$GFollowCountsData_followCounts._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GFollowCountsData_followCounts', 'G__typename'),
          followingCount: followingCount,
          followerCount: followerCount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
