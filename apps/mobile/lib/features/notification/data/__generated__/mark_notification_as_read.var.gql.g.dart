// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_notification_as_read.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMarkNotificationAsReadVars>
    _$gMarkNotificationAsReadVarsSerializer =
    _$GMarkNotificationAsReadVarsSerializer();

class _$GMarkNotificationAsReadVarsSerializer
    implements StructuredSerializer<GMarkNotificationAsReadVars> {
  @override
  final Iterable<Type> types = const [
    GMarkNotificationAsReadVars,
    _$GMarkNotificationAsReadVars
  ];
  @override
  final String wireName = 'GMarkNotificationAsReadVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMarkNotificationAsReadVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'notificationId',
      serializers.serialize(object.notificationId,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GMarkNotificationAsReadVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMarkNotificationAsReadVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'notificationId':
          result.notificationId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GMarkNotificationAsReadVars extends GMarkNotificationAsReadVars {
  @override
  final int notificationId;

  factory _$GMarkNotificationAsReadVars(
          [void Function(GMarkNotificationAsReadVarsBuilder)? updates]) =>
      (GMarkNotificationAsReadVarsBuilder()..update(updates))._build();

  _$GMarkNotificationAsReadVars._({required this.notificationId}) : super._();
  @override
  GMarkNotificationAsReadVars rebuild(
          void Function(GMarkNotificationAsReadVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMarkNotificationAsReadVarsBuilder toBuilder() =>
      GMarkNotificationAsReadVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMarkNotificationAsReadVars &&
        notificationId == other.notificationId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, notificationId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMarkNotificationAsReadVars')
          ..add('notificationId', notificationId))
        .toString();
  }
}

class GMarkNotificationAsReadVarsBuilder
    implements
        Builder<GMarkNotificationAsReadVars,
            GMarkNotificationAsReadVarsBuilder> {
  _$GMarkNotificationAsReadVars? _$v;

  int? _notificationId;
  int? get notificationId => _$this._notificationId;
  set notificationId(int? notificationId) =>
      _$this._notificationId = notificationId;

  GMarkNotificationAsReadVarsBuilder();

  GMarkNotificationAsReadVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _notificationId = $v.notificationId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMarkNotificationAsReadVars other) {
    _$v = other as _$GMarkNotificationAsReadVars;
  }

  @override
  void update(void Function(GMarkNotificationAsReadVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMarkNotificationAsReadVars build() => _build();

  _$GMarkNotificationAsReadVars _build() {
    final _$result = _$v ??
        _$GMarkNotificationAsReadVars._(
          notificationId: BuiltValueNullFieldError.checkNotNull(
              notificationId, r'GMarkNotificationAsReadVars', 'notificationId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
