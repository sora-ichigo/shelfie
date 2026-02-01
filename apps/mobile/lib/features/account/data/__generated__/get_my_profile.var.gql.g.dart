// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_my_profile.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetMyProfileVars> _$gGetMyProfileVarsSerializer =
    new _$GGetMyProfileVarsSerializer();

class _$GGetMyProfileVarsSerializer
    implements StructuredSerializer<GGetMyProfileVars> {
  @override
  final Iterable<Type> types = const [GGetMyProfileVars, _$GGetMyProfileVars];
  @override
  final String wireName = 'GGetMyProfileVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GGetMyProfileVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GGetMyProfileVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GGetMyProfileVarsBuilder().build();
  }
}

class _$GGetMyProfileVars extends GGetMyProfileVars {
  factory _$GGetMyProfileVars(
          [void Function(GGetMyProfileVarsBuilder)? updates]) =>
      (new GGetMyProfileVarsBuilder()..update(updates))._build();

  _$GGetMyProfileVars._() : super._();

  @override
  GGetMyProfileVars rebuild(void Function(GGetMyProfileVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetMyProfileVarsBuilder toBuilder() =>
      new GGetMyProfileVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetMyProfileVars;
  }

  @override
  int get hashCode {
    return 200601782;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GGetMyProfileVars').toString();
  }
}

class GGetMyProfileVarsBuilder
    implements Builder<GGetMyProfileVars, GGetMyProfileVarsBuilder> {
  _$GGetMyProfileVars? _$v;

  GGetMyProfileVarsBuilder();

  @override
  void replace(GGetMyProfileVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GGetMyProfileVars;
  }

  @override
  void update(void Function(GGetMyProfileVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetMyProfileVars build() => _build();

  _$GGetMyProfileVars _build() {
    final _$result = _$v ?? new _$GGetMyProfileVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
