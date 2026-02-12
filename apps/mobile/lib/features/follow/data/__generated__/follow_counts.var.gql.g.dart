// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_counts.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GFollowCountsVars> _$gFollowCountsVarsSerializer =
    _$GFollowCountsVarsSerializer();

class _$GFollowCountsVarsSerializer
    implements StructuredSerializer<GFollowCountsVars> {
  @override
  final Iterable<Type> types = const [GFollowCountsVars, _$GFollowCountsVars];
  @override
  final String wireName = 'GFollowCountsVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GFollowCountsVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userId',
      serializers.serialize(object.userId, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GFollowCountsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GFollowCountsVarsBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GFollowCountsVars extends GFollowCountsVars {
  @override
  final int userId;

  factory _$GFollowCountsVars(
          [void Function(GFollowCountsVarsBuilder)? updates]) =>
      (GFollowCountsVarsBuilder()..update(updates))._build();

  _$GFollowCountsVars._({required this.userId}) : super._();
  @override
  GFollowCountsVars rebuild(void Function(GFollowCountsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GFollowCountsVarsBuilder toBuilder() =>
      GFollowCountsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GFollowCountsVars && userId == other.userId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GFollowCountsVars')
          ..add('userId', userId))
        .toString();
  }
}

class GFollowCountsVarsBuilder
    implements Builder<GFollowCountsVars, GFollowCountsVarsBuilder> {
  _$GFollowCountsVars? _$v;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  GFollowCountsVarsBuilder();

  GFollowCountsVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GFollowCountsVars other) {
    _$v = other as _$GFollowCountsVars;
  }

  @override
  void update(void Function(GFollowCountsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GFollowCountsVars build() => _build();

  _$GFollowCountsVars _build() {
    final _$result = _$v ??
        _$GFollowCountsVars._(
          userId: BuiltValueNullFieldError.checkNotNull(
              userId, r'GFollowCountsVars', 'userId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
