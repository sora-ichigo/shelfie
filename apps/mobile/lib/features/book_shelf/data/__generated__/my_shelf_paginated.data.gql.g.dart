// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_shelf_paginated.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMyShelfPaginatedData> _$gMyShelfPaginatedDataSerializer =
    new _$GMyShelfPaginatedDataSerializer();
Serializer<GMyShelfPaginatedData_myShelf>
    _$gMyShelfPaginatedDataMyShelfSerializer =
    new _$GMyShelfPaginatedData_myShelfSerializer();
Serializer<GMyShelfPaginatedData_myShelf_items>
    _$gMyShelfPaginatedDataMyShelfItemsSerializer =
    new _$GMyShelfPaginatedData_myShelf_itemsSerializer();

class _$GMyShelfPaginatedDataSerializer
    implements StructuredSerializer<GMyShelfPaginatedData> {
  @override
  final Iterable<Type> types = const [
    GMyShelfPaginatedData,
    _$GMyShelfPaginatedData
  ];
  @override
  final String wireName = 'GMyShelfPaginatedData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMyShelfPaginatedData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'myShelf',
      serializers.serialize(object.myShelf,
          specifiedType: const FullType(GMyShelfPaginatedData_myShelf)),
    ];

    return result;
  }

  @override
  GMyShelfPaginatedData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GMyShelfPaginatedDataBuilder();

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
        case 'myShelf':
          result.myShelf.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GMyShelfPaginatedData_myShelf))!
              as GMyShelfPaginatedData_myShelf);
          break;
      }
    }

    return result.build();
  }
}

class _$GMyShelfPaginatedData_myShelfSerializer
    implements StructuredSerializer<GMyShelfPaginatedData_myShelf> {
  @override
  final Iterable<Type> types = const [
    GMyShelfPaginatedData_myShelf,
    _$GMyShelfPaginatedData_myShelf
  ];
  @override
  final String wireName = 'GMyShelfPaginatedData_myShelf';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMyShelfPaginatedData_myShelf object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'items',
      serializers.serialize(object.items,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GMyShelfPaginatedData_myShelf_items)])),
      'totalCount',
      serializers.serialize(object.totalCount,
          specifiedType: const FullType(int)),
      'hasMore',
      serializers.serialize(object.hasMore,
          specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  GMyShelfPaginatedData_myShelf deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GMyShelfPaginatedData_myShelfBuilder();

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
        case 'items':
          result.items.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GMyShelfPaginatedData_myShelf_items)
              ]))! as BuiltList<Object?>);
          break;
        case 'totalCount':
          result.totalCount = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'hasMore':
          result.hasMore = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GMyShelfPaginatedData_myShelf_itemsSerializer
    implements StructuredSerializer<GMyShelfPaginatedData_myShelf_items> {
  @override
  final Iterable<Type> types = const [
    GMyShelfPaginatedData_myShelf_items,
    _$GMyShelfPaginatedData_myShelf_items
  ];
  @override
  final String wireName = 'GMyShelfPaginatedData_myShelf_items';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMyShelfPaginatedData_myShelf_items object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'externalId',
      serializers.serialize(object.externalId,
          specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'authors',
      serializers.serialize(object.authors,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'readingStatus',
      serializers.serialize(object.readingStatus,
          specifiedType: const FullType(_i2.GReadingStatus)),
      'source',
      serializers.serialize(object.source,
          specifiedType: const FullType(_i2.GBookSource)),
      'addedAt',
      serializers.serialize(object.addedAt,
          specifiedType: const FullType(DateTime)),
    ];
    Object? value;
    value = object.coverImageUrl;
    if (value != null) {
      result
        ..add('coverImageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.startedAt;
    if (value != null) {
      result
        ..add('startedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.completedAt;
    if (value != null) {
      result
        ..add('completedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.rating;
    if (value != null) {
      result
        ..add('rating')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  GMyShelfPaginatedData_myShelf_items deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GMyShelfPaginatedData_myShelf_itemsBuilder();

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
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'externalId':
          result.externalId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'authors':
          result.authors.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'coverImageUrl':
          result.coverImageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'readingStatus':
          result.readingStatus = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GReadingStatus))!
              as _i2.GReadingStatus;
          break;
        case 'source':
          result.source = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GBookSource))!
              as _i2.GBookSource;
          break;
        case 'addedAt':
          result.addedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'startedAt':
          result.startedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'completedAt':
          result.completedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'rating':
          result.rating = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$GMyShelfPaginatedData extends GMyShelfPaginatedData {
  @override
  final String G__typename;
  @override
  final GMyShelfPaginatedData_myShelf myShelf;

  factory _$GMyShelfPaginatedData(
          [void Function(GMyShelfPaginatedDataBuilder)? updates]) =>
      (new GMyShelfPaginatedDataBuilder()..update(updates))._build();

  _$GMyShelfPaginatedData._({required this.G__typename, required this.myShelf})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GMyShelfPaginatedData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        myShelf, r'GMyShelfPaginatedData', 'myShelf');
  }

  @override
  GMyShelfPaginatedData rebuild(
          void Function(GMyShelfPaginatedDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMyShelfPaginatedDataBuilder toBuilder() =>
      new GMyShelfPaginatedDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyShelfPaginatedData &&
        G__typename == other.G__typename &&
        myShelf == other.myShelf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, myShelf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMyShelfPaginatedData')
          ..add('G__typename', G__typename)
          ..add('myShelf', myShelf))
        .toString();
  }
}

class GMyShelfPaginatedDataBuilder
    implements Builder<GMyShelfPaginatedData, GMyShelfPaginatedDataBuilder> {
  _$GMyShelfPaginatedData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GMyShelfPaginatedData_myShelfBuilder? _myShelf;
  GMyShelfPaginatedData_myShelfBuilder get myShelf =>
      _$this._myShelf ??= new GMyShelfPaginatedData_myShelfBuilder();
  set myShelf(GMyShelfPaginatedData_myShelfBuilder? myShelf) =>
      _$this._myShelf = myShelf;

  GMyShelfPaginatedDataBuilder() {
    GMyShelfPaginatedData._initializeBuilder(this);
  }

  GMyShelfPaginatedDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _myShelf = $v.myShelf.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyShelfPaginatedData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GMyShelfPaginatedData;
  }

  @override
  void update(void Function(GMyShelfPaginatedDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMyShelfPaginatedData build() => _build();

  _$GMyShelfPaginatedData _build() {
    _$GMyShelfPaginatedData _$result;
    try {
      _$result = _$v ??
          new _$GMyShelfPaginatedData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GMyShelfPaginatedData', 'G__typename'),
              myShelf: myShelf.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'myShelf';
        myShelf.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GMyShelfPaginatedData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMyShelfPaginatedData_myShelf extends GMyShelfPaginatedData_myShelf {
  @override
  final String G__typename;
  @override
  final BuiltList<GMyShelfPaginatedData_myShelf_items> items;
  @override
  final int totalCount;
  @override
  final bool hasMore;

  factory _$GMyShelfPaginatedData_myShelf(
          [void Function(GMyShelfPaginatedData_myShelfBuilder)? updates]) =>
      (new GMyShelfPaginatedData_myShelfBuilder()..update(updates))._build();

  _$GMyShelfPaginatedData_myShelf._(
      {required this.G__typename,
      required this.items,
      required this.totalCount,
      required this.hasMore})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GMyShelfPaginatedData_myShelf', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        items, r'GMyShelfPaginatedData_myShelf', 'items');
    BuiltValueNullFieldError.checkNotNull(
        totalCount, r'GMyShelfPaginatedData_myShelf', 'totalCount');
    BuiltValueNullFieldError.checkNotNull(
        hasMore, r'GMyShelfPaginatedData_myShelf', 'hasMore');
  }

  @override
  GMyShelfPaginatedData_myShelf rebuild(
          void Function(GMyShelfPaginatedData_myShelfBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMyShelfPaginatedData_myShelfBuilder toBuilder() =>
      new GMyShelfPaginatedData_myShelfBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyShelfPaginatedData_myShelf &&
        G__typename == other.G__typename &&
        items == other.items &&
        totalCount == other.totalCount &&
        hasMore == other.hasMore;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, totalCount.hashCode);
    _$hash = $jc(_$hash, hasMore.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMyShelfPaginatedData_myShelf')
          ..add('G__typename', G__typename)
          ..add('items', items)
          ..add('totalCount', totalCount)
          ..add('hasMore', hasMore))
        .toString();
  }
}

class GMyShelfPaginatedData_myShelfBuilder
    implements
        Builder<GMyShelfPaginatedData_myShelf,
            GMyShelfPaginatedData_myShelfBuilder> {
  _$GMyShelfPaginatedData_myShelf? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GMyShelfPaginatedData_myShelf_items>? _items;
  ListBuilder<GMyShelfPaginatedData_myShelf_items> get items =>
      _$this._items ??= new ListBuilder<GMyShelfPaginatedData_myShelf_items>();
  set items(ListBuilder<GMyShelfPaginatedData_myShelf_items>? items) =>
      _$this._items = items;

  int? _totalCount;
  int? get totalCount => _$this._totalCount;
  set totalCount(int? totalCount) => _$this._totalCount = totalCount;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(bool? hasMore) => _$this._hasMore = hasMore;

  GMyShelfPaginatedData_myShelfBuilder() {
    GMyShelfPaginatedData_myShelf._initializeBuilder(this);
  }

  GMyShelfPaginatedData_myShelfBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _items = $v.items.toBuilder();
      _totalCount = $v.totalCount;
      _hasMore = $v.hasMore;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyShelfPaginatedData_myShelf other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GMyShelfPaginatedData_myShelf;
  }

  @override
  void update(void Function(GMyShelfPaginatedData_myShelfBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMyShelfPaginatedData_myShelf build() => _build();

  _$GMyShelfPaginatedData_myShelf _build() {
    _$GMyShelfPaginatedData_myShelf _$result;
    try {
      _$result = _$v ??
          new _$GMyShelfPaginatedData_myShelf._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GMyShelfPaginatedData_myShelf', 'G__typename'),
              items: items.build(),
              totalCount: BuiltValueNullFieldError.checkNotNull(
                  totalCount, r'GMyShelfPaginatedData_myShelf', 'totalCount'),
              hasMore: BuiltValueNullFieldError.checkNotNull(
                  hasMore, r'GMyShelfPaginatedData_myShelf', 'hasMore'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GMyShelfPaginatedData_myShelf', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMyShelfPaginatedData_myShelf_items
    extends GMyShelfPaginatedData_myShelf_items {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final String externalId;
  @override
  final String title;
  @override
  final BuiltList<String> authors;
  @override
  final String? coverImageUrl;
  @override
  final _i2.GReadingStatus readingStatus;
  @override
  final _i2.GBookSource source;
  @override
  final DateTime addedAt;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? completedAt;
  @override
  final int? rating;

  factory _$GMyShelfPaginatedData_myShelf_items(
          [void Function(GMyShelfPaginatedData_myShelf_itemsBuilder)?
              updates]) =>
      (new GMyShelfPaginatedData_myShelf_itemsBuilder()..update(updates))
          ._build();

  _$GMyShelfPaginatedData_myShelf_items._(
      {required this.G__typename,
      required this.id,
      required this.externalId,
      required this.title,
      required this.authors,
      this.coverImageUrl,
      required this.readingStatus,
      required this.source,
      required this.addedAt,
      this.startedAt,
      this.completedAt,
      this.rating})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GMyShelfPaginatedData_myShelf_items', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GMyShelfPaginatedData_myShelf_items', 'id');
    BuiltValueNullFieldError.checkNotNull(
        externalId, r'GMyShelfPaginatedData_myShelf_items', 'externalId');
    BuiltValueNullFieldError.checkNotNull(
        title, r'GMyShelfPaginatedData_myShelf_items', 'title');
    BuiltValueNullFieldError.checkNotNull(
        authors, r'GMyShelfPaginatedData_myShelf_items', 'authors');
    BuiltValueNullFieldError.checkNotNull(
        readingStatus, r'GMyShelfPaginatedData_myShelf_items', 'readingStatus');
    BuiltValueNullFieldError.checkNotNull(
        source, r'GMyShelfPaginatedData_myShelf_items', 'source');
    BuiltValueNullFieldError.checkNotNull(
        addedAt, r'GMyShelfPaginatedData_myShelf_items', 'addedAt');
  }

  @override
  GMyShelfPaginatedData_myShelf_items rebuild(
          void Function(GMyShelfPaginatedData_myShelf_itemsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMyShelfPaginatedData_myShelf_itemsBuilder toBuilder() =>
      new GMyShelfPaginatedData_myShelf_itemsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyShelfPaginatedData_myShelf_items &&
        G__typename == other.G__typename &&
        id == other.id &&
        externalId == other.externalId &&
        title == other.title &&
        authors == other.authors &&
        coverImageUrl == other.coverImageUrl &&
        readingStatus == other.readingStatus &&
        source == other.source &&
        addedAt == other.addedAt &&
        startedAt == other.startedAt &&
        completedAt == other.completedAt &&
        rating == other.rating;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, externalId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, authors.hashCode);
    _$hash = $jc(_$hash, coverImageUrl.hashCode);
    _$hash = $jc(_$hash, readingStatus.hashCode);
    _$hash = $jc(_$hash, source.hashCode);
    _$hash = $jc(_$hash, addedAt.hashCode);
    _$hash = $jc(_$hash, startedAt.hashCode);
    _$hash = $jc(_$hash, completedAt.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMyShelfPaginatedData_myShelf_items')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('externalId', externalId)
          ..add('title', title)
          ..add('authors', authors)
          ..add('coverImageUrl', coverImageUrl)
          ..add('readingStatus', readingStatus)
          ..add('source', source)
          ..add('addedAt', addedAt)
          ..add('startedAt', startedAt)
          ..add('completedAt', completedAt)
          ..add('rating', rating))
        .toString();
  }
}

class GMyShelfPaginatedData_myShelf_itemsBuilder
    implements
        Builder<GMyShelfPaginatedData_myShelf_items,
            GMyShelfPaginatedData_myShelf_itemsBuilder> {
  _$GMyShelfPaginatedData_myShelf_items? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _externalId;
  String? get externalId => _$this._externalId;
  set externalId(String? externalId) => _$this._externalId = externalId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  ListBuilder<String>? _authors;
  ListBuilder<String> get authors =>
      _$this._authors ??= new ListBuilder<String>();
  set authors(ListBuilder<String>? authors) => _$this._authors = authors;

  String? _coverImageUrl;
  String? get coverImageUrl => _$this._coverImageUrl;
  set coverImageUrl(String? coverImageUrl) =>
      _$this._coverImageUrl = coverImageUrl;

  _i2.GReadingStatus? _readingStatus;
  _i2.GReadingStatus? get readingStatus => _$this._readingStatus;
  set readingStatus(_i2.GReadingStatus? readingStatus) =>
      _$this._readingStatus = readingStatus;

  _i2.GBookSource? _source;
  _i2.GBookSource? get source => _$this._source;
  set source(_i2.GBookSource? source) => _$this._source = source;

  DateTime? _addedAt;
  DateTime? get addedAt => _$this._addedAt;
  set addedAt(DateTime? addedAt) => _$this._addedAt = addedAt;

  DateTime? _startedAt;
  DateTime? get startedAt => _$this._startedAt;
  set startedAt(DateTime? startedAt) => _$this._startedAt = startedAt;

  DateTime? _completedAt;
  DateTime? get completedAt => _$this._completedAt;
  set completedAt(DateTime? completedAt) => _$this._completedAt = completedAt;

  int? _rating;
  int? get rating => _$this._rating;
  set rating(int? rating) => _$this._rating = rating;

  GMyShelfPaginatedData_myShelf_itemsBuilder() {
    GMyShelfPaginatedData_myShelf_items._initializeBuilder(this);
  }

  GMyShelfPaginatedData_myShelf_itemsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _externalId = $v.externalId;
      _title = $v.title;
      _authors = $v.authors.toBuilder();
      _coverImageUrl = $v.coverImageUrl;
      _readingStatus = $v.readingStatus;
      _source = $v.source;
      _addedAt = $v.addedAt;
      _startedAt = $v.startedAt;
      _completedAt = $v.completedAt;
      _rating = $v.rating;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyShelfPaginatedData_myShelf_items other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GMyShelfPaginatedData_myShelf_items;
  }

  @override
  void update(
      void Function(GMyShelfPaginatedData_myShelf_itemsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMyShelfPaginatedData_myShelf_items build() => _build();

  _$GMyShelfPaginatedData_myShelf_items _build() {
    _$GMyShelfPaginatedData_myShelf_items _$result;
    try {
      _$result = _$v ??
          new _$GMyShelfPaginatedData_myShelf_items._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GMyShelfPaginatedData_myShelf_items', 'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, r'GMyShelfPaginatedData_myShelf_items', 'id'),
              externalId: BuiltValueNullFieldError.checkNotNull(
                  externalId, r'GMyShelfPaginatedData_myShelf_items', 'externalId'),
              title: BuiltValueNullFieldError.checkNotNull(
                  title, r'GMyShelfPaginatedData_myShelf_items', 'title'),
              authors: authors.build(),
              coverImageUrl: coverImageUrl,
              readingStatus: BuiltValueNullFieldError.checkNotNull(
                  readingStatus,
                  r'GMyShelfPaginatedData_myShelf_items',
                  'readingStatus'),
              source: BuiltValueNullFieldError.checkNotNull(
                  source, r'GMyShelfPaginatedData_myShelf_items', 'source'),
              addedAt: BuiltValueNullFieldError.checkNotNull(
                  addedAt, r'GMyShelfPaginatedData_myShelf_items', 'addedAt'),
              startedAt: startedAt,
              completedAt: completedAt,
              rating: rating);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'authors';
        authors.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GMyShelfPaginatedData_myShelf_items',
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
