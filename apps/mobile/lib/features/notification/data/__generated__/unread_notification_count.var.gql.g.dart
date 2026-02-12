// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unread_notification_count.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUnreadNotificationCountVars>
    _$gUnreadNotificationCountVarsSerializer =
    _$GUnreadNotificationCountVarsSerializer();

class _$GUnreadNotificationCountVarsSerializer
    implements StructuredSerializer<GUnreadNotificationCountVars> {
  @override
  final Iterable<Type> types = const [
    GUnreadNotificationCountVars,
    _$GUnreadNotificationCountVars
  ];
  @override
  final String wireName = 'GUnreadNotificationCountVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUnreadNotificationCountVars object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  GUnreadNotificationCountVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return GUnreadNotificationCountVarsBuilder().build();
  }
}

class _$GUnreadNotificationCountVars extends GUnreadNotificationCountVars {
  factory _$GUnreadNotificationCountVars(
          [void Function(GUnreadNotificationCountVarsBuilder)? updates]) =>
      (GUnreadNotificationCountVarsBuilder()..update(updates))._build();

  _$GUnreadNotificationCountVars._() : super._();
  @override
  GUnreadNotificationCountVars rebuild(
          void Function(GUnreadNotificationCountVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUnreadNotificationCountVarsBuilder toBuilder() =>
      GUnreadNotificationCountVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUnreadNotificationCountVars;
  }

  @override
  int get hashCode {
    return 660798714;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GUnreadNotificationCountVars')
        .toString();
  }
}

class GUnreadNotificationCountVarsBuilder
    implements
        Builder<GUnreadNotificationCountVars,
            GUnreadNotificationCountVarsBuilder> {
  _$GUnreadNotificationCountVars? _$v;

  GUnreadNotificationCountVarsBuilder();

  @override
  void replace(GUnreadNotificationCountVars other) {
    _$v = other as _$GUnreadNotificationCountVars;
  }

  @override
  void update(void Function(GUnreadNotificationCountVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUnreadNotificationCountVars build() => _build();

  _$GUnreadNotificationCountVars _build() {
    final _$result = _$v ?? _$GUnreadNotificationCountVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
