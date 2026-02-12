// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unread_notification_count.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUnreadNotificationCountData>
    _$gUnreadNotificationCountDataSerializer =
    _$GUnreadNotificationCountDataSerializer();

class _$GUnreadNotificationCountDataSerializer
    implements StructuredSerializer<GUnreadNotificationCountData> {
  @override
  final Iterable<Type> types = const [
    GUnreadNotificationCountData,
    _$GUnreadNotificationCountData
  ];
  @override
  final String wireName = 'GUnreadNotificationCountData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUnreadNotificationCountData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'unreadNotificationCount',
      serializers.serialize(object.unreadNotificationCount,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GUnreadNotificationCountData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUnreadNotificationCountDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'unreadNotificationCount':
          result.unreadNotificationCount = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GUnreadNotificationCountData extends GUnreadNotificationCountData {
  @override
  final String G__typename;
  @override
  final int unreadNotificationCount;

  factory _$GUnreadNotificationCountData(
          [void Function(GUnreadNotificationCountDataBuilder)? updates]) =>
      (GUnreadNotificationCountDataBuilder()..update(updates))._build();

  _$GUnreadNotificationCountData._(
      {required this.G__typename, required this.unreadNotificationCount})
      : super._();
  @override
  GUnreadNotificationCountData rebuild(
          void Function(GUnreadNotificationCountDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUnreadNotificationCountDataBuilder toBuilder() =>
      GUnreadNotificationCountDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUnreadNotificationCountData &&
        G__typename == other.G__typename &&
        unreadNotificationCount == other.unreadNotificationCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, unreadNotificationCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUnreadNotificationCountData')
          ..add('G__typename', G__typename)
          ..add('unreadNotificationCount', unreadNotificationCount))
        .toString();
  }
}

class GUnreadNotificationCountDataBuilder
    implements
        Builder<GUnreadNotificationCountData,
            GUnreadNotificationCountDataBuilder> {
  _$GUnreadNotificationCountData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _unreadNotificationCount;
  int? get unreadNotificationCount => _$this._unreadNotificationCount;
  set unreadNotificationCount(int? unreadNotificationCount) =>
      _$this._unreadNotificationCount = unreadNotificationCount;

  GUnreadNotificationCountDataBuilder() {
    GUnreadNotificationCountData._initializeBuilder(this);
  }

  GUnreadNotificationCountDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _unreadNotificationCount = $v.unreadNotificationCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUnreadNotificationCountData other) {
    _$v = other as _$GUnreadNotificationCountData;
  }

  @override
  void update(void Function(GUnreadNotificationCountDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUnreadNotificationCountData build() => _build();

  _$GUnreadNotificationCountData _build() {
    final _$result = _$v ??
        _$GUnreadNotificationCountData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GUnreadNotificationCountData', 'G__typename'),
          unreadNotificationCount: BuiltValueNullFieldError.checkNotNull(
              unreadNotificationCount,
              r'GUnreadNotificationCountData',
              'unreadNotificationCount'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
