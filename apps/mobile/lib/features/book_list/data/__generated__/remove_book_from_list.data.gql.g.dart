// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remove_book_from_list.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GRemoveBookFromListData> _$gRemoveBookFromListDataSerializer =
    new _$GRemoveBookFromListDataSerializer();

class _$GRemoveBookFromListDataSerializer
    implements StructuredSerializer<GRemoveBookFromListData> {
  @override
  final Iterable<Type> types = const [
    GRemoveBookFromListData,
    _$GRemoveBookFromListData
  ];
  @override
  final String wireName = 'GRemoveBookFromListData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GRemoveBookFromListData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'removeBookFromList',
      serializers.serialize(object.removeBookFromList,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GRemoveBookFromListData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GRemoveBookFromListDataBuilder();

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
        case 'removeBookFromList':
          result.removeBookFromList = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GRemoveBookFromListData extends GRemoveBookFromListData {
  @override
  final String G__typename;
  @override
  final bool removeBookFromList;

  factory _$GRemoveBookFromListData(
          [void Function(GRemoveBookFromListDataBuilder)? updates]) =>
      (new GRemoveBookFromListDataBuilder()..update(updates))._build();

  _$GRemoveBookFromListData._(
      {required this.G__typename, required this.removeBookFromList})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GRemoveBookFromListData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        removeBookFromList, r'GRemoveBookFromListData', 'removeBookFromList');
  }

  @override
  GRemoveBookFromListData rebuild(
          void Function(GRemoveBookFromListDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRemoveBookFromListDataBuilder toBuilder() =>
      new GRemoveBookFromListDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRemoveBookFromListData &&
        G__typename == other.G__typename &&
        removeBookFromList == other.removeBookFromList;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, removeBookFromList.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRemoveBookFromListData')
          ..add('G__typename', G__typename)
          ..add('removeBookFromList', removeBookFromList))
        .toString();
  }
}

class GRemoveBookFromListDataBuilder
    implements
        Builder<GRemoveBookFromListData, GRemoveBookFromListDataBuilder> {
  _$GRemoveBookFromListData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _removeBookFromList;
  bool? get removeBookFromList => _$this._removeBookFromList;
  set removeBookFromList(bool? removeBookFromList) =>
      _$this._removeBookFromList = removeBookFromList;

  GRemoveBookFromListDataBuilder() {
    GRemoveBookFromListData._initializeBuilder(this);
  }

  GRemoveBookFromListDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _removeBookFromList = $v.removeBookFromList;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRemoveBookFromListData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GRemoveBookFromListData;
  }

  @override
  void update(void Function(GRemoveBookFromListDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRemoveBookFromListData build() => _build();

  _$GRemoveBookFromListData _build() {
    final _$result = _$v ??
        new _$GRemoveBookFromListData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GRemoveBookFromListData', 'G__typename'),
            removeBookFromList: BuiltValueNullFieldError.checkNotNull(
                removeBookFromList,
                r'GRemoveBookFromListData',
                'removeBookFromList'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
