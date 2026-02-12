// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_follow_request_count.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GPendingFollowRequestCountVars>
    _$gPendingFollowRequestCountVarsSerializer =
    _$GPendingFollowRequestCountVarsSerializer();

class _$GPendingFollowRequestCountVarsSerializer
    implements StructuredSerializer<GPendingFollowRequestCountVars> {
  @override
  final Iterable<Type> types = const [
    GPendingFollowRequestCountVars,
    _$GPendingFollowRequestCountVars
  ];
  @override
  final String wireName = 'GPendingFollowRequestCountVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GPendingFollowRequestCountVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GPendingFollowRequestCountVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return GPendingFollowRequestCountVarsBuilder().build();
  }
}

class _$GPendingFollowRequestCountVars extends GPendingFollowRequestCountVars {
  factory _$GPendingFollowRequestCountVars(
          [void Function(GPendingFollowRequestCountVarsBuilder)? updates]) =>
      (GPendingFollowRequestCountVarsBuilder()..update(updates))._build();

  _$GPendingFollowRequestCountVars._() : super._();
  @override
  GPendingFollowRequestCountVars rebuild(
          void Function(GPendingFollowRequestCountVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPendingFollowRequestCountVarsBuilder toBuilder() =>
      GPendingFollowRequestCountVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPendingFollowRequestCountVars;
  }

  @override
  int get hashCode {
    return 245218111;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GPendingFollowRequestCountVars')
        .toString();
  }
}

class GPendingFollowRequestCountVarsBuilder
    implements
        Builder<GPendingFollowRequestCountVars,
            GPendingFollowRequestCountVarsBuilder> {
  _$GPendingFollowRequestCountVars? _$v;

  GPendingFollowRequestCountVarsBuilder();

  @override
  void replace(GPendingFollowRequestCountVars other) {
    _$v = other as _$GPendingFollowRequestCountVars;
  }

  @override
  void update(void Function(GPendingFollowRequestCountVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPendingFollowRequestCountVars build() => _build();

  _$GPendingFollowRequestCountVars _build() {
    final _$result = _$v ?? _$GPendingFollowRequestCountVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
