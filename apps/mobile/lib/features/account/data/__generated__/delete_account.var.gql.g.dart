// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_account.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GDeleteAccountVars> _$gDeleteAccountVarsSerializer =
    _$GDeleteAccountVarsSerializer();

class _$GDeleteAccountVarsSerializer
    implements StructuredSerializer<GDeleteAccountVars> {
  @override
  final Iterable<Type> types = const [GDeleteAccountVars, _$GDeleteAccountVars];
  @override
  final String wireName = 'GDeleteAccountVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GDeleteAccountVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GDeleteAccountVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return GDeleteAccountVarsBuilder().build();
  }
}

class _$GDeleteAccountVars extends GDeleteAccountVars {
  factory _$GDeleteAccountVars(
          [void Function(GDeleteAccountVarsBuilder)? updates]) =>
      (GDeleteAccountVarsBuilder()..update(updates))._build();

  _$GDeleteAccountVars._() : super._();
  @override
  GDeleteAccountVars rebuild(
          void Function(GDeleteAccountVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeleteAccountVarsBuilder toBuilder() =>
      GDeleteAccountVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteAccountVars;
  }

  @override
  int get hashCode {
    return 990407865;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GDeleteAccountVars').toString();
  }
}

class GDeleteAccountVarsBuilder
    implements Builder<GDeleteAccountVars, GDeleteAccountVarsBuilder> {
  _$GDeleteAccountVars? _$v;

  GDeleteAccountVarsBuilder();

  @override
  void replace(GDeleteAccountVars other) {
    _$v = other as _$GDeleteAccountVars;
  }

  @override
  void update(void Function(GDeleteAccountVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteAccountVars build() => _build();

  _$GDeleteAccountVars _build() {
    final _$result = _$v ?? _$GDeleteAccountVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
