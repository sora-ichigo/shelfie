// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_notification_as_read.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMarkNotificationAsReadData>
    _$gMarkNotificationAsReadDataSerializer =
    _$GMarkNotificationAsReadDataSerializer();

class _$GMarkNotificationAsReadDataSerializer
    implements StructuredSerializer<GMarkNotificationAsReadData> {
  @override
  final Iterable<Type> types = const [
    GMarkNotificationAsReadData,
    _$GMarkNotificationAsReadData
  ];
  @override
  final String wireName = 'GMarkNotificationAsReadData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMarkNotificationAsReadData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.markNotificationAsRead;
    if (value != null) {
      result
        ..add('markNotificationAsRead')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  GMarkNotificationAsReadData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMarkNotificationAsReadDataBuilder();

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
        case 'markNotificationAsRead':
          result.markNotificationAsRead = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
      }
    }

    return result.build();
  }
}

class _$GMarkNotificationAsReadData extends GMarkNotificationAsReadData {
  @override
  final String G__typename;
  @override
  final bool? markNotificationAsRead;

  factory _$GMarkNotificationAsReadData(
          [void Function(GMarkNotificationAsReadDataBuilder)? updates]) =>
      (GMarkNotificationAsReadDataBuilder()..update(updates))._build();

  _$GMarkNotificationAsReadData._(
      {required this.G__typename, this.markNotificationAsRead})
      : super._();
  @override
  GMarkNotificationAsReadData rebuild(
          void Function(GMarkNotificationAsReadDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMarkNotificationAsReadDataBuilder toBuilder() =>
      GMarkNotificationAsReadDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMarkNotificationAsReadData &&
        G__typename == other.G__typename &&
        markNotificationAsRead == other.markNotificationAsRead;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, markNotificationAsRead.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMarkNotificationAsReadData')
          ..add('G__typename', G__typename)
          ..add('markNotificationAsRead', markNotificationAsRead))
        .toString();
  }
}

class GMarkNotificationAsReadDataBuilder
    implements
        Builder<GMarkNotificationAsReadData,
            GMarkNotificationAsReadDataBuilder> {
  _$GMarkNotificationAsReadData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _markNotificationAsRead;
  bool? get markNotificationAsRead => _$this._markNotificationAsRead;
  set markNotificationAsRead(bool? markNotificationAsRead) =>
      _$this._markNotificationAsRead = markNotificationAsRead;

  GMarkNotificationAsReadDataBuilder() {
    GMarkNotificationAsReadData._initializeBuilder(this);
  }

  GMarkNotificationAsReadDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _markNotificationAsRead = $v.markNotificationAsRead;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMarkNotificationAsReadData other) {
    _$v = other as _$GMarkNotificationAsReadData;
  }

  @override
  void update(void Function(GMarkNotificationAsReadDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMarkNotificationAsReadData build() => _build();

  _$GMarkNotificationAsReadData _build() {
    final _$result = _$v ??
        _$GMarkNotificationAsReadData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GMarkNotificationAsReadData', 'G__typename'),
          markNotificationAsRead: markNotificationAsRead,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
