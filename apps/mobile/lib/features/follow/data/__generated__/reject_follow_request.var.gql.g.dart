// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reject_follow_request.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GRejectFollowRequestVars> _$gRejectFollowRequestVarsSerializer =
    _$GRejectFollowRequestVarsSerializer();

class _$GRejectFollowRequestVarsSerializer
    implements StructuredSerializer<GRejectFollowRequestVars> {
  @override
  final Iterable<Type> types = const [
    GRejectFollowRequestVars,
    _$GRejectFollowRequestVars
  ];
  @override
  final String wireName = 'GRejectFollowRequestVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GRejectFollowRequestVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'requestId',
      serializers.serialize(object.requestId,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GRejectFollowRequestVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GRejectFollowRequestVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'requestId':
          result.requestId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GRejectFollowRequestVars extends GRejectFollowRequestVars {
  @override
  final int requestId;

  factory _$GRejectFollowRequestVars(
          [void Function(GRejectFollowRequestVarsBuilder)? updates]) =>
      (GRejectFollowRequestVarsBuilder()..update(updates))._build();

  _$GRejectFollowRequestVars._({required this.requestId}) : super._();
  @override
  GRejectFollowRequestVars rebuild(
          void Function(GRejectFollowRequestVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRejectFollowRequestVarsBuilder toBuilder() =>
      GRejectFollowRequestVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRejectFollowRequestVars && requestId == other.requestId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, requestId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRejectFollowRequestVars')
          ..add('requestId', requestId))
        .toString();
  }
}

class GRejectFollowRequestVarsBuilder
    implements
        Builder<GRejectFollowRequestVars, GRejectFollowRequestVarsBuilder> {
  _$GRejectFollowRequestVars? _$v;

  int? _requestId;
  int? get requestId => _$this._requestId;
  set requestId(int? requestId) => _$this._requestId = requestId;

  GRejectFollowRequestVarsBuilder();

  GRejectFollowRequestVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _requestId = $v.requestId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRejectFollowRequestVars other) {
    _$v = other as _$GRejectFollowRequestVars;
  }

  @override
  void update(void Function(GRejectFollowRequestVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRejectFollowRequestVars build() => _build();

  _$GRejectFollowRequestVars _build() {
    final _$result = _$v ??
        _$GRejectFollowRequestVars._(
          requestId: BuiltValueNullFieldError.checkNotNull(
              requestId, r'GRejectFollowRequestVars', 'requestId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
