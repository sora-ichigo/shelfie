// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_books.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GSearchBooksData> _$gSearchBooksDataSerializer =
    _$GSearchBooksDataSerializer();
Serializer<GSearchBooksData_searchBooks>
_$gSearchBooksDataSearchBooksSerializer =
    _$GSearchBooksData_searchBooksSerializer();
Serializer<GSearchBooksData_searchBooks_items>
_$gSearchBooksDataSearchBooksItemsSerializer =
    _$GSearchBooksData_searchBooks_itemsSerializer();

class _$GSearchBooksDataSerializer
    implements StructuredSerializer<GSearchBooksData> {
  @override
  final Iterable<Type> types = const [GSearchBooksData, _$GSearchBooksData];
  @override
  final String wireName = 'GSearchBooksData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GSearchBooksData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'searchBooks',
      serializers.serialize(
        object.searchBooks,
        specifiedType: const FullType(GSearchBooksData_searchBooks),
      ),
    ];

    return result;
  }

  @override
  GSearchBooksData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GSearchBooksDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'searchBooks':
          result.searchBooks.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(GSearchBooksData_searchBooks),
                )!
                as GSearchBooksData_searchBooks,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchBooksData_searchBooksSerializer
    implements StructuredSerializer<GSearchBooksData_searchBooks> {
  @override
  final Iterable<Type> types = const [
    GSearchBooksData_searchBooks,
    _$GSearchBooksData_searchBooks,
  ];
  @override
  final String wireName = 'GSearchBooksData_searchBooks';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GSearchBooksData_searchBooks object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'items',
      serializers.serialize(
        object.items,
        specifiedType: const FullType(BuiltList, const [
          const FullType(GSearchBooksData_searchBooks_items),
        ]),
      ),
      'totalCount',
      serializers.serialize(
        object.totalCount,
        specifiedType: const FullType(int),
      ),
      'hasMore',
      serializers.serialize(
        object.hasMore,
        specifiedType: const FullType(bool),
      ),
    ];

    return result;
  }

  @override
  GSearchBooksData_searchBooks deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GSearchBooksData_searchBooksBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'items':
          result.items.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(GSearchBooksData_searchBooks_items),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'totalCount':
          result.totalCount =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'hasMore':
          result.hasMore =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )!
                  as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchBooksData_searchBooks_itemsSerializer
    implements StructuredSerializer<GSearchBooksData_searchBooks_items> {
  @override
  final Iterable<Type> types = const [
    GSearchBooksData_searchBooks_items,
    _$GSearchBooksData_searchBooks_items,
  ];
  @override
  final String wireName = 'GSearchBooksData_searchBooks_items';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GSearchBooksData_searchBooks_items object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      ),
      'authors',
      serializers.serialize(
        object.authors,
        specifiedType: const FullType(BuiltList, const [
          const FullType(String),
        ]),
      ),
      'source',
      serializers.serialize(
        object.source,
        specifiedType: const FullType(_i2.GBookSource),
      ),
    ];
    Object? value;
    value = object.publisher;
    if (value != null) {
      result
        ..add('publisher')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.publishedDate;
    if (value != null) {
      result
        ..add('publishedDate')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.isbn;
    if (value != null) {
      result
        ..add('isbn')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.coverImageUrl;
    if (value != null) {
      result
        ..add('coverImageUrl')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  GSearchBooksData_searchBooks_items deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GSearchBooksData_searchBooks_itemsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'id':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'title':
          result.title =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'authors':
          result.authors.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(String),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'publisher':
          result.publisher =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'publishedDate':
          result.publishedDate =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'isbn':
          result.isbn =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'coverImageUrl':
          result.coverImageUrl =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'source':
          result.source =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i2.GBookSource),
                  )!
                  as _i2.GBookSource;
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchBooksData extends GSearchBooksData {
  @override
  final String G__typename;
  @override
  final GSearchBooksData_searchBooks searchBooks;

  factory _$GSearchBooksData([
    void Function(GSearchBooksDataBuilder)? updates,
  ]) => (GSearchBooksDataBuilder()..update(updates))._build();

  _$GSearchBooksData._({required this.G__typename, required this.searchBooks})
    : super._();
  @override
  GSearchBooksData rebuild(void Function(GSearchBooksDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSearchBooksDataBuilder toBuilder() =>
      GSearchBooksDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchBooksData &&
        G__typename == other.G__typename &&
        searchBooks == other.searchBooks;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, searchBooks.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchBooksData')
          ..add('G__typename', G__typename)
          ..add('searchBooks', searchBooks))
        .toString();
  }
}

class GSearchBooksDataBuilder
    implements Builder<GSearchBooksData, GSearchBooksDataBuilder> {
  _$GSearchBooksData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GSearchBooksData_searchBooksBuilder? _searchBooks;
  GSearchBooksData_searchBooksBuilder get searchBooks =>
      _$this._searchBooks ??= GSearchBooksData_searchBooksBuilder();
  set searchBooks(GSearchBooksData_searchBooksBuilder? searchBooks) =>
      _$this._searchBooks = searchBooks;

  GSearchBooksDataBuilder() {
    GSearchBooksData._initializeBuilder(this);
  }

  GSearchBooksDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _searchBooks = $v.searchBooks.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchBooksData other) {
    _$v = other as _$GSearchBooksData;
  }

  @override
  void update(void Function(GSearchBooksDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchBooksData build() => _build();

  _$GSearchBooksData _build() {
    _$GSearchBooksData _$result;
    try {
      _$result =
          _$v ??
          _$GSearchBooksData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GSearchBooksData',
              'G__typename',
            ),
            searchBooks: searchBooks.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'searchBooks';
        searchBooks.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GSearchBooksData',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSearchBooksData_searchBooks extends GSearchBooksData_searchBooks {
  @override
  final String G__typename;
  @override
  final BuiltList<GSearchBooksData_searchBooks_items> items;
  @override
  final int totalCount;
  @override
  final bool hasMore;

  factory _$GSearchBooksData_searchBooks([
    void Function(GSearchBooksData_searchBooksBuilder)? updates,
  ]) => (GSearchBooksData_searchBooksBuilder()..update(updates))._build();

  _$GSearchBooksData_searchBooks._({
    required this.G__typename,
    required this.items,
    required this.totalCount,
    required this.hasMore,
  }) : super._();
  @override
  GSearchBooksData_searchBooks rebuild(
    void Function(GSearchBooksData_searchBooksBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GSearchBooksData_searchBooksBuilder toBuilder() =>
      GSearchBooksData_searchBooksBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchBooksData_searchBooks &&
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
    return (newBuiltValueToStringHelper(r'GSearchBooksData_searchBooks')
          ..add('G__typename', G__typename)
          ..add('items', items)
          ..add('totalCount', totalCount)
          ..add('hasMore', hasMore))
        .toString();
  }
}

class GSearchBooksData_searchBooksBuilder
    implements
        Builder<
          GSearchBooksData_searchBooks,
          GSearchBooksData_searchBooksBuilder
        > {
  _$GSearchBooksData_searchBooks? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GSearchBooksData_searchBooks_items>? _items;
  ListBuilder<GSearchBooksData_searchBooks_items> get items =>
      _$this._items ??= ListBuilder<GSearchBooksData_searchBooks_items>();
  set items(ListBuilder<GSearchBooksData_searchBooks_items>? items) =>
      _$this._items = items;

  int? _totalCount;
  int? get totalCount => _$this._totalCount;
  set totalCount(int? totalCount) => _$this._totalCount = totalCount;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(bool? hasMore) => _$this._hasMore = hasMore;

  GSearchBooksData_searchBooksBuilder() {
    GSearchBooksData_searchBooks._initializeBuilder(this);
  }

  GSearchBooksData_searchBooksBuilder get _$this {
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
  void replace(GSearchBooksData_searchBooks other) {
    _$v = other as _$GSearchBooksData_searchBooks;
  }

  @override
  void update(void Function(GSearchBooksData_searchBooksBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchBooksData_searchBooks build() => _build();

  _$GSearchBooksData_searchBooks _build() {
    _$GSearchBooksData_searchBooks _$result;
    try {
      _$result =
          _$v ??
          _$GSearchBooksData_searchBooks._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GSearchBooksData_searchBooks',
              'G__typename',
            ),
            items: items.build(),
            totalCount: BuiltValueNullFieldError.checkNotNull(
              totalCount,
              r'GSearchBooksData_searchBooks',
              'totalCount',
            ),
            hasMore: BuiltValueNullFieldError.checkNotNull(
              hasMore,
              r'GSearchBooksData_searchBooks',
              'hasMore',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GSearchBooksData_searchBooks',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GSearchBooksData_searchBooks_items
    extends GSearchBooksData_searchBooks_items {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String title;
  @override
  final BuiltList<String> authors;
  @override
  final String? publisher;
  @override
  final String? publishedDate;
  @override
  final String? isbn;
  @override
  final String? coverImageUrl;
  @override
  final _i2.GBookSource source;

  factory _$GSearchBooksData_searchBooks_items([
    void Function(GSearchBooksData_searchBooks_itemsBuilder)? updates,
  ]) => (GSearchBooksData_searchBooks_itemsBuilder()..update(updates))._build();

  _$GSearchBooksData_searchBooks_items._({
    required this.G__typename,
    required this.id,
    required this.title,
    required this.authors,
    this.publisher,
    this.publishedDate,
    this.isbn,
    this.coverImageUrl,
    required this.source,
  }) : super._();
  @override
  GSearchBooksData_searchBooks_items rebuild(
    void Function(GSearchBooksData_searchBooks_itemsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GSearchBooksData_searchBooks_itemsBuilder toBuilder() =>
      GSearchBooksData_searchBooks_itemsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchBooksData_searchBooks_items &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        authors == other.authors &&
        publisher == other.publisher &&
        publishedDate == other.publishedDate &&
        isbn == other.isbn &&
        coverImageUrl == other.coverImageUrl &&
        source == other.source;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, authors.hashCode);
    _$hash = $jc(_$hash, publisher.hashCode);
    _$hash = $jc(_$hash, publishedDate.hashCode);
    _$hash = $jc(_$hash, isbn.hashCode);
    _$hash = $jc(_$hash, coverImageUrl.hashCode);
    _$hash = $jc(_$hash, source.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchBooksData_searchBooks_items')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('authors', authors)
          ..add('publisher', publisher)
          ..add('publishedDate', publishedDate)
          ..add('isbn', isbn)
          ..add('coverImageUrl', coverImageUrl)
          ..add('source', source))
        .toString();
  }
}

class GSearchBooksData_searchBooks_itemsBuilder
    implements
        Builder<
          GSearchBooksData_searchBooks_items,
          GSearchBooksData_searchBooks_itemsBuilder
        > {
  _$GSearchBooksData_searchBooks_items? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  ListBuilder<String>? _authors;
  ListBuilder<String> get authors => _$this._authors ??= ListBuilder<String>();
  set authors(ListBuilder<String>? authors) => _$this._authors = authors;

  String? _publisher;
  String? get publisher => _$this._publisher;
  set publisher(String? publisher) => _$this._publisher = publisher;

  String? _publishedDate;
  String? get publishedDate => _$this._publishedDate;
  set publishedDate(String? publishedDate) =>
      _$this._publishedDate = publishedDate;

  String? _isbn;
  String? get isbn => _$this._isbn;
  set isbn(String? isbn) => _$this._isbn = isbn;

  String? _coverImageUrl;
  String? get coverImageUrl => _$this._coverImageUrl;
  set coverImageUrl(String? coverImageUrl) =>
      _$this._coverImageUrl = coverImageUrl;

  _i2.GBookSource? _source;
  _i2.GBookSource? get source => _$this._source;
  set source(_i2.GBookSource? source) => _$this._source = source;

  GSearchBooksData_searchBooks_itemsBuilder() {
    GSearchBooksData_searchBooks_items._initializeBuilder(this);
  }

  GSearchBooksData_searchBooks_itemsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _authors = $v.authors.toBuilder();
      _publisher = $v.publisher;
      _publishedDate = $v.publishedDate;
      _isbn = $v.isbn;
      _coverImageUrl = $v.coverImageUrl;
      _source = $v.source;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchBooksData_searchBooks_items other) {
    _$v = other as _$GSearchBooksData_searchBooks_items;
  }

  @override
  void update(
    void Function(GSearchBooksData_searchBooks_itemsBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GSearchBooksData_searchBooks_items build() => _build();

  _$GSearchBooksData_searchBooks_items _build() {
    _$GSearchBooksData_searchBooks_items _$result;
    try {
      _$result =
          _$v ??
          _$GSearchBooksData_searchBooks_items._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GSearchBooksData_searchBooks_items',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GSearchBooksData_searchBooks_items',
              'id',
            ),
            title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'GSearchBooksData_searchBooks_items',
              'title',
            ),
            authors: authors.build(),
            publisher: publisher,
            publishedDate: publishedDate,
            isbn: isbn,
            coverImageUrl: coverImageUrl,
            source: BuiltValueNullFieldError.checkNotNull(
              source,
              r'GSearchBooksData_searchBooks_items',
              'source',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'authors';
        authors.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GSearchBooksData_searchBooks_items',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
