// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_follow_requests.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GPendingFollowRequestsVars> _$gPendingFollowRequestsVarsSerializer =
    _$GPendingFollowRequestsVarsSerializer();

class _$GPendingFollowRequestsVarsSerializer
    implements StructuredSerializer<GPendingFollowRequestsVars> {
  @override
  final Iterable<Type> types = const [
    GPendingFollowRequestsVars,
    _$GPendingFollowRequestsVars
  ];
  @override
  final String wireName = 'GPendingFollowRequestsVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GPendingFollowRequestsVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
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
  GPendingFollowRequestsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPendingFollowRequestsVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
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

class _$GPendingFollowRequestsVars extends GPendingFollowRequestsVars {
  @override
  final int? cursor;
  @override
  final int? limit;

  factory _$GPendingFollowRequestsVars(
          [void Function(GPendingFollowRequestsVarsBuilder)? updates]) =>
      (GPendingFollowRequestsVarsBuilder()..update(updates))._build();

  _$GPendingFollowRequestsVars._({this.cursor, this.limit}) : super._();
  @override
  GPendingFollowRequestsVars rebuild(
          void Function(GPendingFollowRequestsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPendingFollowRequestsVarsBuilder toBuilder() =>
      GPendingFollowRequestsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPendingFollowRequestsVars &&
        cursor == other.cursor &&
        limit == other.limit;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, cursor.hashCode);
    _$hash = $jc(_$hash, limit.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPendingFollowRequestsVars')
          ..add('cursor', cursor)
          ..add('limit', limit))
        .toString();
  }
}

class GPendingFollowRequestsVarsBuilder
    implements
        Builder<GPendingFollowRequestsVars, GPendingFollowRequestsVarsBuilder> {
  _$GPendingFollowRequestsVars? _$v;

  int? _cursor;
  int? get cursor => _$this._cursor;
  set cursor(int? cursor) => _$this._cursor = cursor;

  int? _limit;
  int? get limit => _$this._limit;
  set limit(int? limit) => _$this._limit = limit;

  GPendingFollowRequestsVarsBuilder();

  GPendingFollowRequestsVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _cursor = $v.cursor;
      _limit = $v.limit;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPendingFollowRequestsVars other) {
    _$v = other as _$GPendingFollowRequestsVars;
  }

  @override
  void update(void Function(GPendingFollowRequestsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPendingFollowRequestsVars build() => _build();

  _$GPendingFollowRequestsVars _build() {
    final _$result = _$v ??
        _$GPendingFollowRequestsVars._(
          cursor: cursor,
          limit: limit,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
