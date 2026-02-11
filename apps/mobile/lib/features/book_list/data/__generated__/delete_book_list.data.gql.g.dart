// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_book_list.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GDeleteBookListData> _$gDeleteBookListDataSerializer =
    _$GDeleteBookListDataSerializer();

class _$GDeleteBookListDataSerializer
    implements StructuredSerializer<GDeleteBookListData> {
  @override
  final Iterable<Type> types = const [
    GDeleteBookListData,
    _$GDeleteBookListData
  ];
  @override
  final String wireName = 'GDeleteBookListData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GDeleteBookListData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'deleteBookList',
      serializers.serialize(object.deleteBookList,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GDeleteBookListData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GDeleteBookListDataBuilder();

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
        case 'deleteBookList':
          result.deleteBookList = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GDeleteBookListData extends GDeleteBookListData {
  @override
  final String G__typename;
  @override
  final bool deleteBookList;

  factory _$GDeleteBookListData(
          [void Function(GDeleteBookListDataBuilder)? updates]) =>
      (GDeleteBookListDataBuilder()..update(updates))._build();

  _$GDeleteBookListData._(
      {required this.G__typename, required this.deleteBookList})
      : super._();
  @override
  GDeleteBookListData rebuild(
          void Function(GDeleteBookListDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GDeleteBookListDataBuilder toBuilder() =>
      GDeleteBookListDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteBookListData &&
        G__typename == other.G__typename &&
        deleteBookList == other.deleteBookList;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, deleteBookList.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GDeleteBookListData')
          ..add('G__typename', G__typename)
          ..add('deleteBookList', deleteBookList))
        .toString();
  }
}

class GDeleteBookListDataBuilder
    implements Builder<GDeleteBookListData, GDeleteBookListDataBuilder> {
  _$GDeleteBookListData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _deleteBookList;
  bool? get deleteBookList => _$this._deleteBookList;
  set deleteBookList(bool? deleteBookList) =>
      _$this._deleteBookList = deleteBookList;

  GDeleteBookListDataBuilder() {
    GDeleteBookListData._initializeBuilder(this);
  }

  GDeleteBookListDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _deleteBookList = $v.deleteBookList;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeleteBookListData other) {
    _$v = other as _$GDeleteBookListData;
  }

  @override
  void update(void Function(GDeleteBookListDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteBookListData build() => _build();

  _$GDeleteBookListData _build() {
    final _$result = _$v ??
        _$GDeleteBookListData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GDeleteBookListData', 'G__typename'),
          deleteBookList: BuiltValueNullFieldError.checkNotNull(
              deleteBookList, r'GDeleteBookListData', 'deleteBookList'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
