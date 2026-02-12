// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_follow_request.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GCancelFollowRequestVars> _$gCancelFollowRequestVarsSerializer =
    _$GCancelFollowRequestVarsSerializer();

class _$GCancelFollowRequestVarsSerializer
    implements StructuredSerializer<GCancelFollowRequestVars> {
  @override
  final Iterable<Type> types = const [
    GCancelFollowRequestVars,
    _$GCancelFollowRequestVars
  ];
  @override
  final String wireName = 'GCancelFollowRequestVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCancelFollowRequestVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'targetUserId',
      serializers.serialize(object.targetUserId,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GCancelFollowRequestVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCancelFollowRequestVarsBuilder();

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

class _$GCancelFollowRequestVars extends GCancelFollowRequestVars {
  @override
  final int targetUserId;

  factory _$GCancelFollowRequestVars(
          [void Function(GCancelFollowRequestVarsBuilder)? updates]) =>
      (GCancelFollowRequestVarsBuilder()..update(updates))._build();

  _$GCancelFollowRequestVars._({required this.targetUserId}) : super._();
  @override
  GCancelFollowRequestVars rebuild(
          void Function(GCancelFollowRequestVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCancelFollowRequestVarsBuilder toBuilder() =>
      GCancelFollowRequestVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCancelFollowRequestVars &&
        targetUserId == other.targetUserId;
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
    return (newBuiltValueToStringHelper(r'GCancelFollowRequestVars')
          ..add('targetUserId', targetUserId))
        .toString();
  }
}

class GCancelFollowRequestVarsBuilder
    implements
        Builder<GCancelFollowRequestVars, GCancelFollowRequestVarsBuilder> {
  _$GCancelFollowRequestVars? _$v;

  int? _targetUserId;
  int? get targetUserId => _$this._targetUserId;
  set targetUserId(int? targetUserId) => _$this._targetUserId = targetUserId;

  GCancelFollowRequestVarsBuilder();

  GCancelFollowRequestVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _targetUserId = $v.targetUserId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCancelFollowRequestVars other) {
    _$v = other as _$GCancelFollowRequestVars;
  }

  @override
  void update(void Function(GCancelFollowRequestVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCancelFollowRequestVars build() => _build();

  _$GCancelFollowRequestVars _build() {
    final _$result = _$v ??
        _$GCancelFollowRequestVars._(
          targetUserId: BuiltValueNullFieldError.checkNotNull(
              targetUserId, r'GCancelFollowRequestVars', 'targetUserId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
