// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reorder_book_in_list.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GReorderBookInListData> _$gReorderBookInListDataSerializer =
    _$GReorderBookInListDataSerializer();

class _$GReorderBookInListDataSerializer
    implements StructuredSerializer<GReorderBookInListData> {
  @override
  final Iterable<Type> types = const [
    GReorderBookInListData,
    _$GReorderBookInListData
  ];
  @override
  final String wireName = 'GReorderBookInListData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GReorderBookInListData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'reorderBookInList',
      serializers.serialize(object.reorderBookInList,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GReorderBookInListData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GReorderBookInListDataBuilder();

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
        case 'reorderBookInList':
          result.reorderBookInList = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GReorderBookInListData extends GReorderBookInListData {
  @override
  final String G__typename;
  @override
  final bool reorderBookInList;

  factory _$GReorderBookInListData(
          [void Function(GReorderBookInListDataBuilder)? updates]) =>
      (GReorderBookInListDataBuilder()..update(updates))._build();

  _$GReorderBookInListData._(
      {required this.G__typename, required this.reorderBookInList})
      : super._();
  @override
  GReorderBookInListData rebuild(
          void Function(GReorderBookInListDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GReorderBookInListDataBuilder toBuilder() =>
      GReorderBookInListDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GReorderBookInListData &&
        G__typename == other.G__typename &&
        reorderBookInList == other.reorderBookInList;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, reorderBookInList.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GReorderBookInListData')
          ..add('G__typename', G__typename)
          ..add('reorderBookInList', reorderBookInList))
        .toString();
  }
}

class GReorderBookInListDataBuilder
    implements Builder<GReorderBookInListData, GReorderBookInListDataBuilder> {
  _$GReorderBookInListData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _reorderBookInList;
  bool? get reorderBookInList => _$this._reorderBookInList;
  set reorderBookInList(bool? reorderBookInList) =>
      _$this._reorderBookInList = reorderBookInList;

  GReorderBookInListDataBuilder() {
    GReorderBookInListData._initializeBuilder(this);
  }

  GReorderBookInListDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _reorderBookInList = $v.reorderBookInList;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GReorderBookInListData other) {
    _$v = other as _$GReorderBookInListData;
  }

  @override
  void update(void Function(GReorderBookInListDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GReorderBookInListData build() => _build();

  _$GReorderBookInListData _build() {
    final _$result = _$v ??
        _$GReorderBookInListData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GReorderBookInListData', 'G__typename'),
          reorderBookInList: BuiltValueNullFieldError.checkNotNull(
              reorderBookInList,
              r'GReorderBookInListData',
              'reorderBookInList'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
