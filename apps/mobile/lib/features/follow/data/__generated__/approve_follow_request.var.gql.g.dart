// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approve_follow_request.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GApproveFollowRequestVars> _$gApproveFollowRequestVarsSerializer =
    _$GApproveFollowRequestVarsSerializer();

class _$GApproveFollowRequestVarsSerializer
    implements StructuredSerializer<GApproveFollowRequestVars> {
  @override
  final Iterable<Type> types = const [
    GApproveFollowRequestVars,
    _$GApproveFollowRequestVars
  ];
  @override
  final String wireName = 'GApproveFollowRequestVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GApproveFollowRequestVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'requestId',
      serializers.serialize(object.requestId,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GApproveFollowRequestVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GApproveFollowRequestVarsBuilder();

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

class _$GApproveFollowRequestVars extends GApproveFollowRequestVars {
  @override
  final int requestId;

  factory _$GApproveFollowRequestVars(
          [void Function(GApproveFollowRequestVarsBuilder)? updates]) =>
      (GApproveFollowRequestVarsBuilder()..update(updates))._build();

  _$GApproveFollowRequestVars._({required this.requestId}) : super._();
  @override
  GApproveFollowRequestVars rebuild(
          void Function(GApproveFollowRequestVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GApproveFollowRequestVarsBuilder toBuilder() =>
      GApproveFollowRequestVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GApproveFollowRequestVars && requestId == other.requestId;
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
    return (newBuiltValueToStringHelper(r'GApproveFollowRequestVars')
          ..add('requestId', requestId))
        .toString();
  }
}

class GApproveFollowRequestVarsBuilder
    implements
        Builder<GApproveFollowRequestVars, GApproveFollowRequestVarsBuilder> {
  _$GApproveFollowRequestVars? _$v;

  int? _requestId;
  int? get requestId => _$this._requestId;
  set requestId(int? requestId) => _$this._requestId = requestId;

  GApproveFollowRequestVarsBuilder();

  GApproveFollowRequestVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _requestId = $v.requestId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GApproveFollowRequestVars other) {
    _$v = other as _$GApproveFollowRequestVars;
  }

  @override
  void update(void Function(GApproveFollowRequestVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GApproveFollowRequestVars build() => _build();

  _$GApproveFollowRequestVars _build() {
    final _$result = _$v ??
        _$GApproveFollowRequestVars._(
          requestId: BuiltValueNullFieldError.checkNotNull(
              requestId, r'GApproveFollowRequestVars', 'requestId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
