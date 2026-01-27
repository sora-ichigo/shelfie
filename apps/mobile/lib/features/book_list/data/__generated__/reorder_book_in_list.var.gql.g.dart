// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reorder_book_in_list.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GReorderBookInListVars> _$gReorderBookInListVarsSerializer =
    _$GReorderBookInListVarsSerializer();

class _$GReorderBookInListVarsSerializer
    implements StructuredSerializer<GReorderBookInListVars> {
  @override
  final Iterable<Type> types = const [
    GReorderBookInListVars,
    _$GReorderBookInListVars
  ];
  @override
  final String wireName = 'GReorderBookInListVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GReorderBookInListVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'listId',
      serializers.serialize(object.listId, specifiedType: const FullType(int)),
      'itemId',
      serializers.serialize(object.itemId, specifiedType: const FullType(int)),
      'newPosition',
      serializers.serialize(object.newPosition,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GReorderBookInListVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GReorderBookInListVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'listId':
          result.listId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'itemId':
          result.itemId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'newPosition':
          result.newPosition = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GReorderBookInListVars extends GReorderBookInListVars {
  @override
  final int listId;
  @override
  final int itemId;
  @override
  final int newPosition;

  factory _$GReorderBookInListVars(
          [void Function(GReorderBookInListVarsBuilder)? updates]) =>
      (GReorderBookInListVarsBuilder()..update(updates))._build();

  _$GReorderBookInListVars._(
      {required this.listId, required this.itemId, required this.newPosition})
      : super._();
  @override
  GReorderBookInListVars rebuild(
          void Function(GReorderBookInListVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GReorderBookInListVarsBuilder toBuilder() =>
      GReorderBookInListVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GReorderBookInListVars &&
        listId == other.listId &&
        itemId == other.itemId &&
        newPosition == other.newPosition;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, listId.hashCode);
    _$hash = $jc(_$hash, itemId.hashCode);
    _$hash = $jc(_$hash, newPosition.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GReorderBookInListVars')
          ..add('listId', listId)
          ..add('itemId', itemId)
          ..add('newPosition', newPosition))
        .toString();
  }
}

class GReorderBookInListVarsBuilder
    implements Builder<GReorderBookInListVars, GReorderBookInListVarsBuilder> {
  _$GReorderBookInListVars? _$v;

  int? _listId;
  int? get listId => _$this._listId;
  set listId(int? listId) => _$this._listId = listId;

  int? _itemId;
  int? get itemId => _$this._itemId;
  set itemId(int? itemId) => _$this._itemId = itemId;

  int? _newPosition;
  int? get newPosition => _$this._newPosition;
  set newPosition(int? newPosition) => _$this._newPosition = newPosition;

  GReorderBookInListVarsBuilder();

  GReorderBookInListVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _listId = $v.listId;
      _itemId = $v.itemId;
      _newPosition = $v.newPosition;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GReorderBookInListVars other) {
    _$v = other as _$GReorderBookInListVars;
  }

  @override
  void update(void Function(GReorderBookInListVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GReorderBookInListVars build() => _build();

  _$GReorderBookInListVars _build() {
    final _$result = _$v ??
        _$GReorderBookInListVars._(
          listId: BuiltValueNullFieldError.checkNotNull(
              listId, r'GReorderBookInListVars', 'listId'),
          itemId: BuiltValueNullFieldError.checkNotNull(
              itemId, r'GReorderBookInListVars', 'itemId'),
          newPosition: BuiltValueNullFieldError.checkNotNull(
              newPosition, r'GReorderBookInListVars', 'newPosition'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
