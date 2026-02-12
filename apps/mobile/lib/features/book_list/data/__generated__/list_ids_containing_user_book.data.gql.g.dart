// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_ids_containing_user_book.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GListIdsContainingUserBookData>
    _$gListIdsContainingUserBookDataSerializer =
    _$GListIdsContainingUserBookDataSerializer();
Serializer<GListIdsContainingUserBookData_listIdsContainingUserBook>
    _$gListIdsContainingUserBookDataListIdsContainingUserBookSerializer =
    _$GListIdsContainingUserBookData_listIdsContainingUserBookSerializer();

class _$GListIdsContainingUserBookDataSerializer
    implements StructuredSerializer<GListIdsContainingUserBookData> {
  @override
  final Iterable<Type> types = const [
    GListIdsContainingUserBookData,
    _$GListIdsContainingUserBookData
  ];
  @override
  final String wireName = 'GListIdsContainingUserBookData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GListIdsContainingUserBookData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'listIdsContainingUserBook',
      serializers.serialize(object.listIdsContainingUserBook,
          specifiedType: const FullType(
              GListIdsContainingUserBookData_listIdsContainingUserBook)),
    ];

    return result;
  }

  @override
  GListIdsContainingUserBookData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GListIdsContainingUserBookDataBuilder();

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
        case 'listIdsContainingUserBook':
          result.listIdsContainingUserBook.replace(serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                      GListIdsContainingUserBookData_listIdsContainingUserBook))!
              as GListIdsContainingUserBookData_listIdsContainingUserBook);
          break;
      }
    }

    return result.build();
  }
}

class _$GListIdsContainingUserBookData_listIdsContainingUserBookSerializer
    implements
        StructuredSerializer<
            GListIdsContainingUserBookData_listIdsContainingUserBook> {
  @override
  final Iterable<Type> types = const [
    GListIdsContainingUserBookData_listIdsContainingUserBook,
    _$GListIdsContainingUserBookData_listIdsContainingUserBook
  ];
  @override
  final String wireName =
      'GListIdsContainingUserBookData_listIdsContainingUserBook';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GListIdsContainingUserBookData_listIdsContainingUserBook object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'listIds',
      serializers.serialize(object.listIds,
          specifiedType:
              const FullType(BuiltList, const [const FullType(int)])),
    ];

    return result;
  }

  @override
  GListIdsContainingUserBookData_listIdsContainingUserBook deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result =
        GListIdsContainingUserBookData_listIdsContainingUserBookBuilder();

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
        case 'listIds':
          result.listIds.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(int)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GListIdsContainingUserBookData extends GListIdsContainingUserBookData {
  @override
  final String G__typename;
  @override
  final GListIdsContainingUserBookData_listIdsContainingUserBook
      listIdsContainingUserBook;

  factory _$GListIdsContainingUserBookData(
          [void Function(GListIdsContainingUserBookDataBuilder)? updates]) =>
      (GListIdsContainingUserBookDataBuilder()..update(updates))._build();

  _$GListIdsContainingUserBookData._(
      {required this.G__typename, required this.listIdsContainingUserBook})
      : super._();
  @override
  GListIdsContainingUserBookData rebuild(
          void Function(GListIdsContainingUserBookDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GListIdsContainingUserBookDataBuilder toBuilder() =>
      GListIdsContainingUserBookDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GListIdsContainingUserBookData &&
        G__typename == other.G__typename &&
        listIdsContainingUserBook == other.listIdsContainingUserBook;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, listIdsContainingUserBook.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GListIdsContainingUserBookData')
          ..add('G__typename', G__typename)
          ..add('listIdsContainingUserBook', listIdsContainingUserBook))
        .toString();
  }
}

class GListIdsContainingUserBookDataBuilder
    implements
        Builder<GListIdsContainingUserBookData,
            GListIdsContainingUserBookDataBuilder> {
  _$GListIdsContainingUserBookData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GListIdsContainingUserBookData_listIdsContainingUserBookBuilder?
      _listIdsContainingUserBook;
  GListIdsContainingUserBookData_listIdsContainingUserBookBuilder
      get listIdsContainingUserBook => _$this._listIdsContainingUserBook ??=
          GListIdsContainingUserBookData_listIdsContainingUserBookBuilder();
  set listIdsContainingUserBook(
          GListIdsContainingUserBookData_listIdsContainingUserBookBuilder?
              listIdsContainingUserBook) =>
      _$this._listIdsContainingUserBook = listIdsContainingUserBook;

  GListIdsContainingUserBookDataBuilder() {
    GListIdsContainingUserBookData._initializeBuilder(this);
  }

  GListIdsContainingUserBookDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _listIdsContainingUserBook = $v.listIdsContainingUserBook.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GListIdsContainingUserBookData other) {
    _$v = other as _$GListIdsContainingUserBookData;
  }

  @override
  void update(void Function(GListIdsContainingUserBookDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GListIdsContainingUserBookData build() => _build();

  _$GListIdsContainingUserBookData _build() {
    _$GListIdsContainingUserBookData _$result;
    try {
      _$result = _$v ??
          _$GListIdsContainingUserBookData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GListIdsContainingUserBookData', 'G__typename'),
            listIdsContainingUserBook: listIdsContainingUserBook.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'listIdsContainingUserBook';
        listIdsContainingUserBook.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GListIdsContainingUserBookData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GListIdsContainingUserBookData_listIdsContainingUserBook
    extends GListIdsContainingUserBookData_listIdsContainingUserBook {
  @override
  final String G__typename;
  @override
  final BuiltList<int> listIds;

  factory _$GListIdsContainingUserBookData_listIdsContainingUserBook(
          [void Function(
                  GListIdsContainingUserBookData_listIdsContainingUserBookBuilder)?
              updates]) =>
      (GListIdsContainingUserBookData_listIdsContainingUserBookBuilder()
            ..update(updates))
          ._build();

  _$GListIdsContainingUserBookData_listIdsContainingUserBook._(
      {required this.G__typename, required this.listIds})
      : super._();
  @override
  GListIdsContainingUserBookData_listIdsContainingUserBook rebuild(
          void Function(
                  GListIdsContainingUserBookData_listIdsContainingUserBookBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GListIdsContainingUserBookData_listIdsContainingUserBookBuilder toBuilder() =>
      GListIdsContainingUserBookData_listIdsContainingUserBookBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GListIdsContainingUserBookData_listIdsContainingUserBook &&
        G__typename == other.G__typename &&
        listIds == other.listIds;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, listIds.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GListIdsContainingUserBookData_listIdsContainingUserBook')
          ..add('G__typename', G__typename)
          ..add('listIds', listIds))
        .toString();
  }
}

class GListIdsContainingUserBookData_listIdsContainingUserBookBuilder
    implements
        Builder<GListIdsContainingUserBookData_listIdsContainingUserBook,
            GListIdsContainingUserBookData_listIdsContainingUserBookBuilder> {
  _$GListIdsContainingUserBookData_listIdsContainingUserBook? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<int>? _listIds;
  ListBuilder<int> get listIds => _$this._listIds ??= ListBuilder<int>();
  set listIds(ListBuilder<int>? listIds) => _$this._listIds = listIds;

  GListIdsContainingUserBookData_listIdsContainingUserBookBuilder() {
    GListIdsContainingUserBookData_listIdsContainingUserBook._initializeBuilder(
        this);
  }

  GListIdsContainingUserBookData_listIdsContainingUserBookBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _listIds = $v.listIds.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GListIdsContainingUserBookData_listIdsContainingUserBook other) {
    _$v = other as _$GListIdsContainingUserBookData_listIdsContainingUserBook;
  }

  @override
  void update(
      void Function(
              GListIdsContainingUserBookData_listIdsContainingUserBookBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GListIdsContainingUserBookData_listIdsContainingUserBook build() => _build();

  _$GListIdsContainingUserBookData_listIdsContainingUserBook _build() {
    _$GListIdsContainingUserBookData_listIdsContainingUserBook _$result;
    try {
      _$result = _$v ??
          _$GListIdsContainingUserBookData_listIdsContainingUserBook._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GListIdsContainingUserBookData_listIdsContainingUserBook',
                'G__typename'),
            listIds: listIds.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'listIds';
        listIds.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GListIdsContainingUserBookData_listIdsContainingUserBook',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
