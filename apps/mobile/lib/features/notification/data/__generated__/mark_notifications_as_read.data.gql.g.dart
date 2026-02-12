// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_notifications_as_read.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMarkNotificationsAsReadData>
    _$gMarkNotificationsAsReadDataSerializer =
    _$GMarkNotificationsAsReadDataSerializer();

class _$GMarkNotificationsAsReadDataSerializer
    implements StructuredSerializer<GMarkNotificationsAsReadData> {
  @override
  final Iterable<Type> types = const [
    GMarkNotificationsAsReadData,
    _$GMarkNotificationsAsReadData
  ];
  @override
  final String wireName = 'GMarkNotificationsAsReadData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMarkNotificationsAsReadData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.markNotificationsAsRead;
    if (value != null) {
      result
        ..add('markNotificationsAsRead')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  GMarkNotificationsAsReadData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMarkNotificationsAsReadDataBuilder();

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
        case 'markNotificationsAsRead':
          result.markNotificationsAsRead = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$GMarkNotificationsAsReadData extends GMarkNotificationsAsReadData {
  @override
  final String G__typename;
  @override
  final bool? markNotificationsAsRead;

  factory _$GMarkNotificationsAsReadData(
          [void Function(GMarkNotificationsAsReadDataBuilder)? updates]) =>
      (GMarkNotificationsAsReadDataBuilder()..update(updates))._build();

  _$GMarkNotificationsAsReadData._(
      {required this.G__typename, this.markNotificationsAsRead})
      : super._();
  @override
  GMarkNotificationsAsReadData rebuild(
          void Function(GMarkNotificationsAsReadDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMarkNotificationsAsReadDataBuilder toBuilder() =>
      GMarkNotificationsAsReadDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMarkNotificationsAsReadData &&
        G__typename == other.G__typename &&
        markNotificationsAsRead == other.markNotificationsAsRead;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, markNotificationsAsRead.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMarkNotificationsAsReadData')
          ..add('G__typename', G__typename)
          ..add('markNotificationsAsRead', markNotificationsAsRead))
        .toString();
  }
}

class GMarkNotificationsAsReadDataBuilder
    implements
        Builder<GMarkNotificationsAsReadData,
            GMarkNotificationsAsReadDataBuilder> {
  _$GMarkNotificationsAsReadData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _markNotificationsAsRead;
  bool? get markNotificationsAsRead => _$this._markNotificationsAsRead;
  set markNotificationsAsRead(bool? markNotificationsAsRead) =>
      _$this._markNotificationsAsRead = markNotificationsAsRead;

  GMarkNotificationsAsReadDataBuilder() {
    GMarkNotificationsAsReadData._initializeBuilder(this);
  }

  GMarkNotificationsAsReadDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _markNotificationsAsRead = $v.markNotificationsAsRead;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMarkNotificationsAsReadData other) {
    _$v = other as _$GMarkNotificationsAsReadData;
  }

  @override
  void update(void Function(GMarkNotificationsAsReadDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMarkNotificationsAsReadData build() => _build();

  _$GMarkNotificationsAsReadData _build() {
    final _$result = _$v ??
        _$GMarkNotificationsAsReadData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GMarkNotificationsAsReadData', 'G__typename'),
          markNotificationsAsRead: markNotificationsAsRead,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
