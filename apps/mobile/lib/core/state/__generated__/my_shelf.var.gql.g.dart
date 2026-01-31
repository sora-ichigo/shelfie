// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_shelf.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMyShelfVars> _$gMyShelfVarsSerializer =
    new _$GMyShelfVarsSerializer();

class _$GMyShelfVarsSerializer implements StructuredSerializer<GMyShelfVars> {
  @override
  final Iterable<Type> types = const [GMyShelfVars, _$GMyShelfVars];
  @override
  final String wireName = 'GMyShelfVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GMyShelfVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GMyShelfVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new GMyShelfVarsBuilder().build();
  }
}

class _$GMyShelfVars extends GMyShelfVars {
  factory _$GMyShelfVars([void Function(GMyShelfVarsBuilder)? updates]) =>
      (new GMyShelfVarsBuilder()..update(updates))._build();

  _$GMyShelfVars._() : super._();

  @override
  GMyShelfVars rebuild(void Function(GMyShelfVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMyShelfVarsBuilder toBuilder() => new GMyShelfVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyShelfVars;
  }

  @override
  int get hashCode {
    return 810934147;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GMyShelfVars').toString();
  }
}

class GMyShelfVarsBuilder
    implements Builder<GMyShelfVars, GMyShelfVarsBuilder> {
  _$GMyShelfVars? _$v;

  GMyShelfVarsBuilder();

  @override
  void replace(GMyShelfVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GMyShelfVars;
  }

  @override
  void update(void Function(GMyShelfVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMyShelfVars build() => _build();

  _$GMyShelfVars _build() {
    final _$result = _$v ?? new _$GMyShelfVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
