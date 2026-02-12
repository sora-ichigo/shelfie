// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'followers.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GFollowersVars> _$gFollowersVarsSerializer =
    _$GFollowersVarsSerializer();

class _$GFollowersVarsSerializer
    implements StructuredSerializer<GFollowersVars> {
  @override
  final Iterable<Type> types = const [GFollowersVars, _$GFollowersVars];
  @override
  final String wireName = 'GFollowersVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GFollowersVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userId',
      serializers.serialize(object.userId, specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.cursor;
    if (value != null) {
      result
        ..add('cursor')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.limit;
    if (value != null) {
      result
        ..add('limit')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  GFollowersVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GFollowersVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'cursor':
          result.cursor = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'limit':
          result.limit = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$GFollowersVars extends GFollowersVars {
  @override
  final int userId;
  @override
  final int? cursor;
  @override
  final int? limit;

  factory _$GFollowersVars([void Function(GFollowersVarsBuilder)? updates]) =>
      (GFollowersVarsBuilder()..update(updates))._build();

  _$GFollowersVars._({required this.userId, this.cursor, this.limit})
      : super._();
  @override
  GFollowersVars rebuild(void Function(GFollowersVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GFollowersVarsBuilder toBuilder() => GFollowersVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GFollowersVars &&
        userId == other.userId &&
        cursor == other.cursor &&
        limit == other.limit;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, cursor.hashCode);
    _$hash = $jc(_$hash, limit.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GFollowersVars')
          ..add('userId', userId)
          ..add('cursor', cursor)
          ..add('limit', limit))
        .toString();
  }
}

class GFollowersVarsBuilder
    implements Builder<GFollowersVars, GFollowersVarsBuilder> {
  _$GFollowersVars? _$v;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  int? _cursor;
  int? get cursor => _$this._cursor;
  set cursor(int? cursor) => _$this._cursor = cursor;

  int? _limit;
  int? get limit => _$this._limit;
  set limit(int? limit) => _$this._limit = limit;

  GFollowersVarsBuilder();

  GFollowersVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _cursor = $v.cursor;
      _limit = $v.limit;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GFollowersVars other) {
    _$v = other as _$GFollowersVars;
  }

  @override
  void update(void Function(GFollowersVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GFollowersVars build() => _build();

  _$GFollowersVars _build() {
    final _$result = _$v ??
        _$GFollowersVars._(
          userId: BuiltValueNullFieldError.checkNotNull(
              userId, r'GFollowersVars', 'userId'),
          cursor: cursor,
          limit: limit,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
