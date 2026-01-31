// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_book_lists.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMyBookListsData> _$gMyBookListsDataSerializer =
    new _$GMyBookListsDataSerializer();
Serializer<GMyBookListsData_myBookLists>
    _$gMyBookListsDataMyBookListsSerializer =
    new _$GMyBookListsData_myBookListsSerializer();
Serializer<GMyBookListsData_myBookLists_items>
    _$gMyBookListsDataMyBookListsItemsSerializer =
    new _$GMyBookListsData_myBookLists_itemsSerializer();

class _$GMyBookListsDataSerializer
    implements StructuredSerializer<GMyBookListsData> {
  @override
  final Iterable<Type> types = const [GMyBookListsData, _$GMyBookListsData];
  @override
  final String wireName = 'GMyBookListsData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GMyBookListsData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'myBookLists',
      serializers.serialize(object.myBookLists,
          specifiedType: const FullType(GMyBookListsData_myBookLists)),
    ];

    return result;
  }

  @override
  GMyBookListsData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GMyBookListsDataBuilder();

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
        case 'myBookLists':
          result.myBookLists.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GMyBookListsData_myBookLists))!
              as GMyBookListsData_myBookLists);
          break;
      }
    }

    return result.build();
  }
}

class _$GMyBookListsData_myBookListsSerializer
    implements StructuredSerializer<GMyBookListsData_myBookLists> {
  @override
  final Iterable<Type> types = const [
    GMyBookListsData_myBookLists,
    _$GMyBookListsData_myBookLists
  ];
  @override
  final String wireName = 'GMyBookListsData_myBookLists';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMyBookListsData_myBookLists object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'items',
      serializers.serialize(object.items,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GMyBookListsData_myBookLists_items)])),
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
  GMyBookListsData_myBookLists deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GMyBookListsData_myBookListsBuilder();

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
                const FullType(GMyBookListsData_myBookLists_items)
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

class _$GMyBookListsData_myBookLists_itemsSerializer
    implements StructuredSerializer<GMyBookListsData_myBookLists_items> {
  @override
  final Iterable<Type> types = const [
    GMyBookListsData_myBookLists_items,
    _$GMyBookListsData_myBookLists_items
  ];
  @override
  final String wireName = 'GMyBookListsData_myBookLists_items';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMyBookListsData_myBookLists_items object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'bookCount',
      serializers.serialize(object.bookCount,
          specifiedType: const FullType(int)),
      'coverImages',
      serializers.serialize(object.coverImages,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(DateTime)),
      'updatedAt',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(DateTime)),
    ];
    Object? value;
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GMyBookListsData_myBookLists_items deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GMyBookListsData_myBookLists_itemsBuilder();

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
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'bookCount':
          result.bookCount = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'coverImages':
          result.coverImages.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
      }
    }

    return result.build();
  }
}

class _$GMyBookListsData extends GMyBookListsData {
  @override
  final String G__typename;
  @override
  final GMyBookListsData_myBookLists myBookLists;

  factory _$GMyBookListsData(
          [void Function(GMyBookListsDataBuilder)? updates]) =>
      (new GMyBookListsDataBuilder()..update(updates))._build();

  _$GMyBookListsData._({required this.G__typename, required this.myBookLists})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GMyBookListsData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        myBookLists, r'GMyBookListsData', 'myBookLists');
  }

  @override
  GMyBookListsData rebuild(void Function(GMyBookListsDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMyBookListsDataBuilder toBuilder() =>
      new GMyBookListsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyBookListsData &&
        G__typename == other.G__typename &&
        myBookLists == other.myBookLists;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, myBookLists.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMyBookListsData')
          ..add('G__typename', G__typename)
          ..add('myBookLists', myBookLists))
        .toString();
  }
}

class GMyBookListsDataBuilder
    implements Builder<GMyBookListsData, GMyBookListsDataBuilder> {
  _$GMyBookListsData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GMyBookListsData_myBookListsBuilder? _myBookLists;
  GMyBookListsData_myBookListsBuilder get myBookLists =>
      _$this._myBookLists ??= new GMyBookListsData_myBookListsBuilder();
  set myBookLists(GMyBookListsData_myBookListsBuilder? myBookLists) =>
      _$this._myBookLists = myBookLists;

  GMyBookListsDataBuilder() {
    GMyBookListsData._initializeBuilder(this);
  }

  GMyBookListsDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _myBookLists = $v.myBookLists.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyBookListsData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GMyBookListsData;
  }

  @override
  void update(void Function(GMyBookListsDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMyBookListsData build() => _build();

  _$GMyBookListsData _build() {
    _$GMyBookListsData _$result;
    try {
      _$result = _$v ??
          new _$GMyBookListsData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GMyBookListsData', 'G__typename'),
              myBookLists: myBookLists.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'myBookLists';
        myBookLists.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GMyBookListsData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMyBookListsData_myBookLists extends GMyBookListsData_myBookLists {
  @override
  final String G__typename;
  @override
  final BuiltList<GMyBookListsData_myBookLists_items> items;
  @override
  final int totalCount;
  @override
  final bool hasMore;

  factory _$GMyBookListsData_myBookLists(
          [void Function(GMyBookListsData_myBookListsBuilder)? updates]) =>
      (new GMyBookListsData_myBookListsBuilder()..update(updates))._build();

  _$GMyBookListsData_myBookLists._(
      {required this.G__typename,
      required this.items,
      required this.totalCount,
      required this.hasMore})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GMyBookListsData_myBookLists', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        items, r'GMyBookListsData_myBookLists', 'items');
    BuiltValueNullFieldError.checkNotNull(
        totalCount, r'GMyBookListsData_myBookLists', 'totalCount');
    BuiltValueNullFieldError.checkNotNull(
        hasMore, r'GMyBookListsData_myBookLists', 'hasMore');
  }

  @override
  GMyBookListsData_myBookLists rebuild(
          void Function(GMyBookListsData_myBookListsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMyBookListsData_myBookListsBuilder toBuilder() =>
      new GMyBookListsData_myBookListsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyBookListsData_myBookLists &&
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
    return (newBuiltValueToStringHelper(r'GMyBookListsData_myBookLists')
          ..add('G__typename', G__typename)
          ..add('items', items)
          ..add('totalCount', totalCount)
          ..add('hasMore', hasMore))
        .toString();
  }
}

class GMyBookListsData_myBookListsBuilder
    implements
        Builder<GMyBookListsData_myBookLists,
            GMyBookListsData_myBookListsBuilder> {
  _$GMyBookListsData_myBookLists? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GMyBookListsData_myBookLists_items>? _items;
  ListBuilder<GMyBookListsData_myBookLists_items> get items =>
      _$this._items ??= new ListBuilder<GMyBookListsData_myBookLists_items>();
  set items(ListBuilder<GMyBookListsData_myBookLists_items>? items) =>
      _$this._items = items;

  int? _totalCount;
  int? get totalCount => _$this._totalCount;
  set totalCount(int? totalCount) => _$this._totalCount = totalCount;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(bool? hasMore) => _$this._hasMore = hasMore;

  GMyBookListsData_myBookListsBuilder() {
    GMyBookListsData_myBookLists._initializeBuilder(this);
  }

  GMyBookListsData_myBookListsBuilder get _$this {
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
  void replace(GMyBookListsData_myBookLists other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GMyBookListsData_myBookLists;
  }

  @override
  void update(void Function(GMyBookListsData_myBookListsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMyBookListsData_myBookLists build() => _build();

  _$GMyBookListsData_myBookLists _build() {
    _$GMyBookListsData_myBookLists _$result;
    try {
      _$result = _$v ??
          new _$GMyBookListsData_myBookLists._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GMyBookListsData_myBookLists', 'G__typename'),
              items: items.build(),
              totalCount: BuiltValueNullFieldError.checkNotNull(
                  totalCount, r'GMyBookListsData_myBookLists', 'totalCount'),
              hasMore: BuiltValueNullFieldError.checkNotNull(
                  hasMore, r'GMyBookListsData_myBookLists', 'hasMore'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GMyBookListsData_myBookLists', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMyBookListsData_myBookLists_items
    extends GMyBookListsData_myBookLists_items {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final int bookCount;
  @override
  final BuiltList<String> coverImages;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  factory _$GMyBookListsData_myBookLists_items(
          [void Function(GMyBookListsData_myBookLists_itemsBuilder)?
              updates]) =>
      (new GMyBookListsData_myBookLists_itemsBuilder()..update(updates))
          ._build();

  _$GMyBookListsData_myBookLists_items._(
      {required this.G__typename,
      required this.id,
      required this.title,
      this.description,
      required this.bookCount,
      required this.coverImages,
      required this.createdAt,
      required this.updatedAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GMyBookListsData_myBookLists_items', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GMyBookListsData_myBookLists_items', 'id');
    BuiltValueNullFieldError.checkNotNull(
        title, r'GMyBookListsData_myBookLists_items', 'title');
    BuiltValueNullFieldError.checkNotNull(
        bookCount, r'GMyBookListsData_myBookLists_items', 'bookCount');
    BuiltValueNullFieldError.checkNotNull(
        coverImages, r'GMyBookListsData_myBookLists_items', 'coverImages');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'GMyBookListsData_myBookLists_items', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'GMyBookListsData_myBookLists_items', 'updatedAt');
  }

  @override
  GMyBookListsData_myBookLists_items rebuild(
          void Function(GMyBookListsData_myBookLists_itemsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMyBookListsData_myBookLists_itemsBuilder toBuilder() =>
      new GMyBookListsData_myBookLists_itemsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyBookListsData_myBookLists_items &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        bookCount == other.bookCount &&
        coverImages == other.coverImages &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, bookCount.hashCode);
    _$hash = $jc(_$hash, coverImages.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMyBookListsData_myBookLists_items')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('bookCount', bookCount)
          ..add('coverImages', coverImages)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class GMyBookListsData_myBookLists_itemsBuilder
    implements
        Builder<GMyBookListsData_myBookLists_items,
            GMyBookListsData_myBookLists_itemsBuilder> {
  _$GMyBookListsData_myBookLists_items? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  int? _bookCount;
  int? get bookCount => _$this._bookCount;
  set bookCount(int? bookCount) => _$this._bookCount = bookCount;

  ListBuilder<String>? _coverImages;
  ListBuilder<String> get coverImages =>
      _$this._coverImages ??= new ListBuilder<String>();
  set coverImages(ListBuilder<String>? coverImages) =>
      _$this._coverImages = coverImages;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  GMyBookListsData_myBookLists_itemsBuilder() {
    GMyBookListsData_myBookLists_items._initializeBuilder(this);
  }

  GMyBookListsData_myBookLists_itemsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _bookCount = $v.bookCount;
      _coverImages = $v.coverImages.toBuilder();
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyBookListsData_myBookLists_items other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GMyBookListsData_myBookLists_items;
  }

  @override
  void update(
      void Function(GMyBookListsData_myBookLists_itemsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMyBookListsData_myBookLists_items build() => _build();

  _$GMyBookListsData_myBookLists_items _build() {
    _$GMyBookListsData_myBookLists_items _$result;
    try {
      _$result = _$v ??
          new _$GMyBookListsData_myBookLists_items._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  r'GMyBookListsData_myBookLists_items', 'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, r'GMyBookListsData_myBookLists_items', 'id'),
              title: BuiltValueNullFieldError.checkNotNull(
                  title, r'GMyBookListsData_myBookLists_items', 'title'),
              description: description,
              bookCount: BuiltValueNullFieldError.checkNotNull(
                  bookCount, r'GMyBookListsData_myBookLists_items', 'bookCount'),
              coverImages: coverImages.build(),
              createdAt: BuiltValueNullFieldError.checkNotNull(createdAt,
                  r'GMyBookListsData_myBookLists_items', 'createdAt'),
              updatedAt: BuiltValueNullFieldError.checkNotNull(updatedAt,
                  r'GMyBookListsData_myBookLists_items', 'updatedAt'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'coverImages';
        coverImages.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GMyBookListsData_myBookLists_items', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
