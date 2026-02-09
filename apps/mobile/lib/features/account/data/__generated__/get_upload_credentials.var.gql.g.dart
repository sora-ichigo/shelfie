// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_upload_credentials.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetUploadCredentialsVars> _$gGetUploadCredentialsVarsSerializer =
    _$GGetUploadCredentialsVarsSerializer();

class _$GGetUploadCredentialsVarsSerializer
    implements StructuredSerializer<GGetUploadCredentialsVars> {
  @override
  final Iterable<Type> types = const [
    GGetUploadCredentialsVars,
    _$GGetUploadCredentialsVars,
  ];
  @override
  final String wireName = 'GGetUploadCredentialsVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetUploadCredentialsVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return <Object?>[];
  }

  @override
  GGetUploadCredentialsVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return GGetUploadCredentialsVarsBuilder().build();
  }
}

class _$GGetUploadCredentialsVars extends GGetUploadCredentialsVars {
  factory _$GGetUploadCredentialsVars([
    void Function(GGetUploadCredentialsVarsBuilder)? updates,
  ]) => (GGetUploadCredentialsVarsBuilder()..update(updates))._build();

  _$GGetUploadCredentialsVars._() : super._();
  @override
  GGetUploadCredentialsVars rebuild(
    void Function(GGetUploadCredentialsVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetUploadCredentialsVarsBuilder toBuilder() =>
      GGetUploadCredentialsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetUploadCredentialsVars;
  }

  @override
  int get hashCode {
    return 210351668;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GGetUploadCredentialsVars').toString();
  }
}

class GGetUploadCredentialsVarsBuilder
    implements
        Builder<GGetUploadCredentialsVars, GGetUploadCredentialsVarsBuilder> {
  _$GGetUploadCredentialsVars? _$v;

  GGetUploadCredentialsVarsBuilder();

  @override
  void replace(GGetUploadCredentialsVars other) {
    _$v = other as _$GGetUploadCredentialsVars;
  }

  @override
  void update(void Function(GGetUploadCredentialsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetUploadCredentialsVars build() => _build();

  _$GGetUploadCredentialsVars _build() {
    final _$result = _$v ?? _$GGetUploadCredentialsVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
