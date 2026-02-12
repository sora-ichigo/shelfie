// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GNotificationsVars> _$gNotificationsVarsSerializer =
    _$GNotificationsVarsSerializer();

class _$GNotificationsVarsSerializer
    implements StructuredSerializer<GNotificationsVars> {
  @override
  final Iterable<Type> types = const [GNotificationsVars, _$GNotificationsVars];
  @override
  final String wireName = 'GNotificationsVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GNotificationsVars object,
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
  GNotificationsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GNotificationsVarsBuilder();

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

class _$GNotificationsVars extends GNotificationsVars {
  @override
  final int? cursor;
  @override
  final int? limit;

  factory _$GNotificationsVars(
          [void Function(GNotificationsVarsBuilder)? updates]) =>
      (GNotificationsVarsBuilder()..update(updates))._build();

  _$GNotificationsVars._({this.cursor, this.limit}) : super._();
  @override
  GNotificationsVars rebuild(
          void Function(GNotificationsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationsVarsBuilder toBuilder() =>
      GNotificationsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GNotificationsVars &&
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
    return (newBuiltValueToStringHelper(r'GNotificationsVars')
          ..add('cursor', cursor)
          ..add('limit', limit))
        .toString();
  }
}

class GNotificationsVarsBuilder
    implements Builder<GNotificationsVars, GNotificationsVarsBuilder> {
  _$GNotificationsVars? _$v;

  int? _cursor;
  int? get cursor => _$this._cursor;
  set cursor(int? cursor) => _$this._cursor = cursor;

  int? _limit;
  int? get limit => _$this._limit;
  set limit(int? limit) => _$this._limit = limit;

  GNotificationsVarsBuilder();

  GNotificationsVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _cursor = $v.cursor;
      _limit = $v.limit;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GNotificationsVars other) {
    _$v = other as _$GNotificationsVars;
  }

  @override
  void update(void Function(GNotificationsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationsVars build() => _build();

  _$GNotificationsVars _build() {
    final _$result = _$v ??
        _$GNotificationsVars._(
          cursor: cursor,
          limit: limit,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
