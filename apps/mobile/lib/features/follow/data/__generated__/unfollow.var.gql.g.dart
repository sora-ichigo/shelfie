// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unfollow.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUnfollowVars> _$gUnfollowVarsSerializer =
    _$GUnfollowVarsSerializer();

class _$GUnfollowVarsSerializer implements StructuredSerializer<GUnfollowVars> {
  @override
  final Iterable<Type> types = const [GUnfollowVars, _$GUnfollowVars];
  @override
  final String wireName = 'GUnfollowVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GUnfollowVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'targetUserId',
      serializers.serialize(object.targetUserId,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GUnfollowVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUnfollowVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'targetUserId':
          result.targetUserId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GUnfollowVars extends GUnfollowVars {
  @override
  final int targetUserId;

  factory _$GUnfollowVars([void Function(GUnfollowVarsBuilder)? updates]) =>
      (GUnfollowVarsBuilder()..update(updates))._build();

  _$GUnfollowVars._({required this.targetUserId}) : super._();
  @override
  GUnfollowVars rebuild(void Function(GUnfollowVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUnfollowVarsBuilder toBuilder() => GUnfollowVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUnfollowVars && targetUserId == other.targetUserId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, targetUserId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUnfollowVars')
          ..add('targetUserId', targetUserId))
        .toString();
  }
}

class GUnfollowVarsBuilder
    implements Builder<GUnfollowVars, GUnfollowVarsBuilder> {
  _$GUnfollowVars? _$v;

  int? _targetUserId;
  int? get targetUserId => _$this._targetUserId;
  set targetUserId(int? targetUserId) => _$this._targetUserId = targetUserId;

  GUnfollowVarsBuilder();

  GUnfollowVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _targetUserId = $v.targetUserId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUnfollowVars other) {
    _$v = other as _$GUnfollowVars;
  }

  @override
  void update(void Function(GUnfollowVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUnfollowVars build() => _build();

  _$GUnfollowVars _build() {
    final _$result = _$v ??
        _$GUnfollowVars._(
          targetUserId: BuiltValueNullFieldError.checkNotNull(
              targetUserId, r'GUnfollowVars', 'targetUserId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
