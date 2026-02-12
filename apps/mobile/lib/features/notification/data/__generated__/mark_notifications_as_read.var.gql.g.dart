// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_notifications_as_read.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMarkNotificationsAsReadVars>
    _$gMarkNotificationsAsReadVarsSerializer =
    _$GMarkNotificationsAsReadVarsSerializer();

class _$GMarkNotificationsAsReadVarsSerializer
    implements StructuredSerializer<GMarkNotificationsAsReadVars> {
  @override
  final Iterable<Type> types = const [
    GMarkNotificationsAsReadVars,
    _$GMarkNotificationsAsReadVars
  ];
  @override
  final String wireName = 'GMarkNotificationsAsReadVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMarkNotificationsAsReadVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GMarkNotificationsAsReadVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return GMarkNotificationsAsReadVarsBuilder().build();
  }
}

class _$GMarkNotificationsAsReadVars extends GMarkNotificationsAsReadVars {
  factory _$GMarkNotificationsAsReadVars(
          [void Function(GMarkNotificationsAsReadVarsBuilder)? updates]) =>
      (GMarkNotificationsAsReadVarsBuilder()..update(updates))._build();

  _$GMarkNotificationsAsReadVars._() : super._();
  @override
  GMarkNotificationsAsReadVars rebuild(
          void Function(GMarkNotificationsAsReadVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMarkNotificationsAsReadVarsBuilder toBuilder() =>
      GMarkNotificationsAsReadVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMarkNotificationsAsReadVars;
  }

  @override
  int get hashCode {
    return 950091407;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GMarkNotificationsAsReadVars')
        .toString();
  }
}

class GMarkNotificationsAsReadVarsBuilder
    implements
        Builder<GMarkNotificationsAsReadVars,
            GMarkNotificationsAsReadVarsBuilder> {
  _$GMarkNotificationsAsReadVars? _$v;

  GMarkNotificationsAsReadVarsBuilder();

  @override
  void replace(GMarkNotificationsAsReadVars other) {
    _$v = other as _$GMarkNotificationsAsReadVars;
  }

  @override
  void update(void Function(GMarkNotificationsAsReadVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMarkNotificationsAsReadVars build() => _build();

  _$GMarkNotificationsAsReadVars _build() {
    final _$result = _$v ?? _$GMarkNotificationsAsReadVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
