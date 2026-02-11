// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remove_from_shelf.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GRemoveFromShelfData> _$gRemoveFromShelfDataSerializer =
    _$GRemoveFromShelfDataSerializer();

class _$GRemoveFromShelfDataSerializer
    implements StructuredSerializer<GRemoveFromShelfData> {
  @override
  final Iterable<Type> types = const [
    GRemoveFromShelfData,
    _$GRemoveFromShelfData
  ];
  @override
  final String wireName = 'GRemoveFromShelfData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GRemoveFromShelfData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'removeFromShelf',
      serializers.serialize(object.removeFromShelf,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GRemoveFromShelfData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GRemoveFromShelfDataBuilder();

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
        case 'removeFromShelf':
          result.removeFromShelf = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GRemoveFromShelfData extends GRemoveFromShelfData {
  @override
  final String G__typename;
  @override
  final bool removeFromShelf;

  factory _$GRemoveFromShelfData(
          [void Function(GRemoveFromShelfDataBuilder)? updates]) =>
      (GRemoveFromShelfDataBuilder()..update(updates))._build();

  _$GRemoveFromShelfData._(
      {required this.G__typename, required this.removeFromShelf})
      : super._();
  @override
  GRemoveFromShelfData rebuild(
          void Function(GRemoveFromShelfDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRemoveFromShelfDataBuilder toBuilder() =>
      GRemoveFromShelfDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRemoveFromShelfData &&
        G__typename == other.G__typename &&
        removeFromShelf == other.removeFromShelf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, removeFromShelf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRemoveFromShelfData')
          ..add('G__typename', G__typename)
          ..add('removeFromShelf', removeFromShelf))
        .toString();
  }
}

class GRemoveFromShelfDataBuilder
    implements Builder<GRemoveFromShelfData, GRemoveFromShelfDataBuilder> {
  _$GRemoveFromShelfData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _removeFromShelf;
  bool? get removeFromShelf => _$this._removeFromShelf;
  set removeFromShelf(bool? removeFromShelf) =>
      _$this._removeFromShelf = removeFromShelf;

  GRemoveFromShelfDataBuilder() {
    GRemoveFromShelfData._initializeBuilder(this);
  }

  GRemoveFromShelfDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _removeFromShelf = $v.removeFromShelf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRemoveFromShelfData other) {
    _$v = other as _$GRemoveFromShelfData;
  }

  @override
  void update(void Function(GRemoveFromShelfDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRemoveFromShelfData build() => _build();

  _$GRemoveFromShelfData _build() {
    final _$result = _$v ??
        _$GRemoveFromShelfData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GRemoveFromShelfData', 'G__typename'),
          removeFromShelf: BuiltValueNullFieldError.checkNotNull(
              removeFromShelf, r'GRemoveFromShelfData', 'removeFromShelf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
