// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_detail.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GBookDetailData> _$gBookDetailDataSerializer =
    new _$GBookDetailDataSerializer();
Serializer<GBookDetailData_bookDetail> _$gBookDetailDataBookDetailSerializer =
    new _$GBookDetailData_bookDetailSerializer();
Serializer<GBookDetailData_bookDetail_userBook>
    _$gBookDetailDataBookDetailUserBookSerializer =
    new _$GBookDetailData_bookDetail_userBookSerializer();

class _$GBookDetailDataSerializer
    implements StructuredSerializer<GBookDetailData> {
  @override
  final Iterable<Type> types = const [GBookDetailData, _$GBookDetailData];
  @override
  final String wireName = 'GBookDetailData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GBookDetailData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'bookDetail',
      serializers.serialize(object.bookDetail,
          specifiedType: const FullType(GBookDetailData_bookDetail)),
    ];

    return result;
  }

  @override
  GBookDetailData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GBookDetailDataBuilder();

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
        case 'bookDetail':
          result.bookDetail.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GBookDetailData_bookDetail))!
              as GBookDetailData_bookDetail);
          break;
      }
    }

    return result.build();
  }
}

class _$GBookDetailData_bookDetailSerializer
    implements StructuredSerializer<GBookDetailData_bookDetail> {
  @override
  final Iterable<Type> types = const [
    GBookDetailData_bookDetail,
    _$GBookDetailData_bookDetail
  ];
  @override
  final String wireName = 'GBookDetailData_bookDetail';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GBookDetailData_bookDetail object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'authors',
      serializers.serialize(object.authors,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];
    Object? value;
    value = object.publisher;
    if (value != null) {
      result
        ..add('publisher')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.publishedDate;
    if (value != null) {
      result
        ..add('publishedDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.pageCount;
    if (value != null) {
      result
        ..add('pageCount')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.categories;
    if (value != null) {
      result
        ..add('categories')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.isbn;
    if (value != null) {
      result
        ..add('isbn')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.coverImageUrl;
    if (value != null) {
      result
        ..add('coverImageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.amazonUrl;
    if (value != null) {
      result
        ..add('amazonUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.rakutenBooksUrl;
    if (value != null) {
      result
        ..add('rakutenBooksUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.userBook;
    if (value != null) {
      result
        ..add('userBook')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(GBookDetailData_bookDetail_userBook)));
    }
    return result;
  }

  @override
  GBookDetailData_bookDetail deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GBookDetailData_bookDetailBuilder();

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
        case 'publisher':
          result.publisher = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'publishedDate':
          result.publishedDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'pageCount':
          result.pageCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'categories':
          result.categories.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'isbn':
          result.isbn = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'coverImageUrl':
          result.coverImageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'amazonUrl':
          result.amazonUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'rakutenBooksUrl':
          result.rakutenBooksUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'userBook':
          result.userBook.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GBookDetailData_bookDetail_userBook))!
              as GBookDetailData_bookDetail_userBook);
          break;
      }
    }

    return result.build();
  }
}

class _$GBookDetailData_bookDetail_userBookSerializer
    implements StructuredSerializer<GBookDetailData_bookDetail_userBook> {
  @override
  final Iterable<Type> types = const [
    GBookDetailData_bookDetail_userBook,
    _$GBookDetailData_bookDetail_userBook
  ];
  @override
  final String wireName = 'GBookDetailData_bookDetail_userBook';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GBookDetailData_bookDetail_userBook object,
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
      'addedAt',
      serializers.serialize(object.addedAt,
          specifiedType: const FullType(DateTime)),
      'readingStatus',
      serializers.serialize(object.readingStatus,
          specifiedType: const FullType(_i2.GReadingStatus)),
    ];
    Object? value;
    value = object.publisher;
    if (value != null) {
      result
        ..add('publisher')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.publishedDate;
    if (value != null) {
      result
        ..add('publishedDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.isbn;
    if (value != null) {
      result
        ..add('isbn')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
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
    value = object.note;
    if (value != null) {
      result
        ..add('note')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.noteUpdatedAt;
    if (value != null) {
      result
        ..add('noteUpdatedAt')
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
  GBookDetailData_bookDetail_userBook deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GBookDetailData_bookDetail_userBookBuilder();

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
        case 'publisher':
          result.publisher = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'publishedDate':
          result.publishedDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'isbn':
          result.isbn = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'coverImageUrl':
          result.coverImageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'addedAt':
          result.addedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'readingStatus':
          result.readingStatus = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GReadingStatus))!
              as _i2.GReadingStatus;
          break;
        case 'startedAt':
          result.startedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'completedAt':
          result.completedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'note':
          result.note = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'noteUpdatedAt':
          result.noteUpdatedAt = serializers.deserialize(value,
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

class _$GBookDetailData extends GBookDetailData {
  @override
  final String G__typename;
  @override
  final GBookDetailData_bookDetail bookDetail;

  factory _$GBookDetailData([void Function(GBookDetailDataBuilder)? updates]) =>
      (new GBookDetailDataBuilder()..update(updates))._build();

  _$GBookDetailData._({required this.G__typename, required this.bookDetail})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GBookDetailData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        bookDetail, r'GBookDetailData', 'bookDetail');
  }

  @override
  GBookDetailData rebuild(void Function(GBookDetailDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GBookDetailDataBuilder toBuilder() =>
      new GBookDetailDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GBookDetailData &&
        G__typename == other.G__typename &&
        bookDetail == other.bookDetail;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, bookDetail.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GBookDetailData')
          ..add('G__typename', G__typename)
          ..add('bookDetail', bookDetail))
        .toString();
  }
}

class GBookDetailDataBuilder
    implements Builder<GBookDetailData, GBookDetailDataBuilder> {
  _$GBookDetailData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GBookDetailData_bookDetailBuilder? _bookDetail;
  GBookDetailData_bookDetailBuilder get bookDetail =>
      _$this._bookDetail ??= new GBookDetailData_bookDetailBuilder();
  set bookDetail(GBookDetailData_bookDetailBuilder? bookDetail) =>
      _$this._bookDetail = bookDetail;

  GBookDetailDataBuilder() {
    GBookDetailData._initializeBuilder(this);
  }

  GBookDetailDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _bookDetail = $v.bookDetail.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GBookDetailData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GBookDetailData;
  }

  @override
  void update(void Function(GBookDetailDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GBookDetailData build() => _build();

  _$GBookDetailData _build() {
    _$GBookDetailData _$result;
    try {
      _$result = _$v ??
          new _$GBookDetailData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GBookDetailData', 'G__typename'),
              bookDetail: bookDetail.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'bookDetail';
        bookDetail.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GBookDetailData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GBookDetailData_bookDetail extends GBookDetailData_bookDetail {
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
  final int? pageCount;
  @override
  final BuiltList<String>? categories;
  @override
  final String? description;
  @override
  final String? isbn;
  @override
  final String? coverImageUrl;
  @override
  final String? amazonUrl;
  @override
  final String? rakutenBooksUrl;
  @override
  final GBookDetailData_bookDetail_userBook? userBook;

  factory _$GBookDetailData_bookDetail(
          [void Function(GBookDetailData_bookDetailBuilder)? updates]) =>
      (new GBookDetailData_bookDetailBuilder()..update(updates))._build();

  _$GBookDetailData_bookDetail._(
      {required this.G__typename,
      required this.id,
      required this.title,
      required this.authors,
      this.publisher,
      this.publishedDate,
      this.pageCount,
      this.categories,
      this.description,
      this.isbn,
      this.coverImageUrl,
      this.amazonUrl,
      this.rakutenBooksUrl,
      this.userBook})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GBookDetailData_bookDetail', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GBookDetailData_bookDetail', 'id');
    BuiltValueNullFieldError.checkNotNull(
        title, r'GBookDetailData_bookDetail', 'title');
    BuiltValueNullFieldError.checkNotNull(
        authors, r'GBookDetailData_bookDetail', 'authors');
  }

  @override
  GBookDetailData_bookDetail rebuild(
          void Function(GBookDetailData_bookDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GBookDetailData_bookDetailBuilder toBuilder() =>
      new GBookDetailData_bookDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GBookDetailData_bookDetail &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        authors == other.authors &&
        publisher == other.publisher &&
        publishedDate == other.publishedDate &&
        pageCount == other.pageCount &&
        categories == other.categories &&
        description == other.description &&
        isbn == other.isbn &&
        coverImageUrl == other.coverImageUrl &&
        amazonUrl == other.amazonUrl &&
        rakutenBooksUrl == other.rakutenBooksUrl &&
        userBook == other.userBook;
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
    _$hash = $jc(_$hash, pageCount.hashCode);
    _$hash = $jc(_$hash, categories.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, isbn.hashCode);
    _$hash = $jc(_$hash, coverImageUrl.hashCode);
    _$hash = $jc(_$hash, amazonUrl.hashCode);
    _$hash = $jc(_$hash, rakutenBooksUrl.hashCode);
    _$hash = $jc(_$hash, userBook.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GBookDetailData_bookDetail')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('authors', authors)
          ..add('publisher', publisher)
          ..add('publishedDate', publishedDate)
          ..add('pageCount', pageCount)
          ..add('categories', categories)
          ..add('description', description)
          ..add('isbn', isbn)
          ..add('coverImageUrl', coverImageUrl)
          ..add('amazonUrl', amazonUrl)
          ..add('rakutenBooksUrl', rakutenBooksUrl)
          ..add('userBook', userBook))
        .toString();
  }
}

class GBookDetailData_bookDetailBuilder
    implements
        Builder<GBookDetailData_bookDetail, GBookDetailData_bookDetailBuilder> {
  _$GBookDetailData_bookDetail? _$v;

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
  ListBuilder<String> get authors =>
      _$this._authors ??= new ListBuilder<String>();
  set authors(ListBuilder<String>? authors) => _$this._authors = authors;

  String? _publisher;
  String? get publisher => _$this._publisher;
  set publisher(String? publisher) => _$this._publisher = publisher;

  String? _publishedDate;
  String? get publishedDate => _$this._publishedDate;
  set publishedDate(String? publishedDate) =>
      _$this._publishedDate = publishedDate;

  int? _pageCount;
  int? get pageCount => _$this._pageCount;
  set pageCount(int? pageCount) => _$this._pageCount = pageCount;

  ListBuilder<String>? _categories;
  ListBuilder<String> get categories =>
      _$this._categories ??= new ListBuilder<String>();
  set categories(ListBuilder<String>? categories) =>
      _$this._categories = categories;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _isbn;
  String? get isbn => _$this._isbn;
  set isbn(String? isbn) => _$this._isbn = isbn;

  String? _coverImageUrl;
  String? get coverImageUrl => _$this._coverImageUrl;
  set coverImageUrl(String? coverImageUrl) =>
      _$this._coverImageUrl = coverImageUrl;

  String? _amazonUrl;
  String? get amazonUrl => _$this._amazonUrl;
  set amazonUrl(String? amazonUrl) => _$this._amazonUrl = amazonUrl;

  String? _rakutenBooksUrl;
  String? get rakutenBooksUrl => _$this._rakutenBooksUrl;
  set rakutenBooksUrl(String? rakutenBooksUrl) =>
      _$this._rakutenBooksUrl = rakutenBooksUrl;

  GBookDetailData_bookDetail_userBookBuilder? _userBook;
  GBookDetailData_bookDetail_userBookBuilder get userBook =>
      _$this._userBook ??= new GBookDetailData_bookDetail_userBookBuilder();
  set userBook(GBookDetailData_bookDetail_userBookBuilder? userBook) =>
      _$this._userBook = userBook;

  GBookDetailData_bookDetailBuilder() {
    GBookDetailData_bookDetail._initializeBuilder(this);
  }

  GBookDetailData_bookDetailBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _authors = $v.authors.toBuilder();
      _publisher = $v.publisher;
      _publishedDate = $v.publishedDate;
      _pageCount = $v.pageCount;
      _categories = $v.categories?.toBuilder();
      _description = $v.description;
      _isbn = $v.isbn;
      _coverImageUrl = $v.coverImageUrl;
      _amazonUrl = $v.amazonUrl;
      _rakutenBooksUrl = $v.rakutenBooksUrl;
      _userBook = $v.userBook?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GBookDetailData_bookDetail other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GBookDetailData_bookDetail;
  }

  @override
  void update(void Function(GBookDetailData_bookDetailBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GBookDetailData_bookDetail build() => _build();

  _$GBookDetailData_bookDetail _build() {
    _$GBookDetailData_bookDetail _$result;
    try {
      _$result = _$v ??
          new _$GBookDetailData_bookDetail._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GBookDetailData_bookDetail', 'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, r'GBookDetailData_bookDetail', 'id'),
              title: BuiltValueNullFieldError.checkNotNull(
                  title, r'GBookDetailData_bookDetail', 'title'),
              authors: authors.build(),
              publisher: publisher,
              publishedDate: publishedDate,
              pageCount: pageCount,
              categories: _categories?.build(),
              description: description,
              isbn: isbn,
              coverImageUrl: coverImageUrl,
              amazonUrl: amazonUrl,
              rakutenBooksUrl: rakutenBooksUrl,
              userBook: _userBook?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'authors';
        authors.build();

        _$failedField = 'categories';
        _categories?.build();

        _$failedField = 'userBook';
        _userBook?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GBookDetailData_bookDetail', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GBookDetailData_bookDetail_userBook
    extends GBookDetailData_bookDetail_userBook {
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
  final String? publisher;
  @override
  final String? publishedDate;
  @override
  final String? isbn;
  @override
  final String? coverImageUrl;
  @override
  final DateTime addedAt;
  @override
  final _i2.GReadingStatus readingStatus;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? completedAt;
  @override
  final String? note;
  @override
  final DateTime? noteUpdatedAt;
  @override
  final int? rating;

  factory _$GBookDetailData_bookDetail_userBook(
          [void Function(GBookDetailData_bookDetail_userBookBuilder)?
              updates]) =>
      (new GBookDetailData_bookDetail_userBookBuilder()..update(updates))
          ._build();

  _$GBookDetailData_bookDetail_userBook._(
      {required this.G__typename,
      required this.id,
      required this.externalId,
      required this.title,
      required this.authors,
      this.publisher,
      this.publishedDate,
      this.isbn,
      this.coverImageUrl,
      required this.addedAt,
      required this.readingStatus,
      this.startedAt,
      this.completedAt,
      this.note,
      this.noteUpdatedAt,
      this.rating})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GBookDetailData_bookDetail_userBook', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GBookDetailData_bookDetail_userBook', 'id');
    BuiltValueNullFieldError.checkNotNull(
        externalId, r'GBookDetailData_bookDetail_userBook', 'externalId');
    BuiltValueNullFieldError.checkNotNull(
        title, r'GBookDetailData_bookDetail_userBook', 'title');
    BuiltValueNullFieldError.checkNotNull(
        authors, r'GBookDetailData_bookDetail_userBook', 'authors');
    BuiltValueNullFieldError.checkNotNull(
        addedAt, r'GBookDetailData_bookDetail_userBook', 'addedAt');
    BuiltValueNullFieldError.checkNotNull(
        readingStatus, r'GBookDetailData_bookDetail_userBook', 'readingStatus');
  }

  @override
  GBookDetailData_bookDetail_userBook rebuild(
          void Function(GBookDetailData_bookDetail_userBookBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GBookDetailData_bookDetail_userBookBuilder toBuilder() =>
      new GBookDetailData_bookDetail_userBookBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GBookDetailData_bookDetail_userBook &&
        G__typename == other.G__typename &&
        id == other.id &&
        externalId == other.externalId &&
        title == other.title &&
        authors == other.authors &&
        publisher == other.publisher &&
        publishedDate == other.publishedDate &&
        isbn == other.isbn &&
        coverImageUrl == other.coverImageUrl &&
        addedAt == other.addedAt &&
        readingStatus == other.readingStatus &&
        startedAt == other.startedAt &&
        completedAt == other.completedAt &&
        note == other.note &&
        noteUpdatedAt == other.noteUpdatedAt &&
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
    _$hash = $jc(_$hash, publisher.hashCode);
    _$hash = $jc(_$hash, publishedDate.hashCode);
    _$hash = $jc(_$hash, isbn.hashCode);
    _$hash = $jc(_$hash, coverImageUrl.hashCode);
    _$hash = $jc(_$hash, addedAt.hashCode);
    _$hash = $jc(_$hash, readingStatus.hashCode);
    _$hash = $jc(_$hash, startedAt.hashCode);
    _$hash = $jc(_$hash, completedAt.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jc(_$hash, noteUpdatedAt.hashCode);
    _$hash = $jc(_$hash, rating.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GBookDetailData_bookDetail_userBook')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('externalId', externalId)
          ..add('title', title)
          ..add('authors', authors)
          ..add('publisher', publisher)
          ..add('publishedDate', publishedDate)
          ..add('isbn', isbn)
          ..add('coverImageUrl', coverImageUrl)
          ..add('addedAt', addedAt)
          ..add('readingStatus', readingStatus)
          ..add('startedAt', startedAt)
          ..add('completedAt', completedAt)
          ..add('note', note)
          ..add('noteUpdatedAt', noteUpdatedAt)
          ..add('rating', rating))
        .toString();
  }
}

class GBookDetailData_bookDetail_userBookBuilder
    implements
        Builder<GBookDetailData_bookDetail_userBook,
            GBookDetailData_bookDetail_userBookBuilder> {
  _$GBookDetailData_bookDetail_userBook? _$v;

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

  DateTime? _addedAt;
  DateTime? get addedAt => _$this._addedAt;
  set addedAt(DateTime? addedAt) => _$this._addedAt = addedAt;

  _i2.GReadingStatus? _readingStatus;
  _i2.GReadingStatus? get readingStatus => _$this._readingStatus;
  set readingStatus(_i2.GReadingStatus? readingStatus) =>
      _$this._readingStatus = readingStatus;

  DateTime? _startedAt;
  DateTime? get startedAt => _$this._startedAt;
  set startedAt(DateTime? startedAt) => _$this._startedAt = startedAt;

  DateTime? _completedAt;
  DateTime? get completedAt => _$this._completedAt;
  set completedAt(DateTime? completedAt) => _$this._completedAt = completedAt;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  DateTime? _noteUpdatedAt;
  DateTime? get noteUpdatedAt => _$this._noteUpdatedAt;
  set noteUpdatedAt(DateTime? noteUpdatedAt) =>
      _$this._noteUpdatedAt = noteUpdatedAt;

  int? _rating;
  int? get rating => _$this._rating;
  set rating(int? rating) => _$this._rating = rating;

  GBookDetailData_bookDetail_userBookBuilder() {
    GBookDetailData_bookDetail_userBook._initializeBuilder(this);
  }

  GBookDetailData_bookDetail_userBookBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _externalId = $v.externalId;
      _title = $v.title;
      _authors = $v.authors.toBuilder();
      _publisher = $v.publisher;
      _publishedDate = $v.publishedDate;
      _isbn = $v.isbn;
      _coverImageUrl = $v.coverImageUrl;
      _addedAt = $v.addedAt;
      _readingStatus = $v.readingStatus;
      _startedAt = $v.startedAt;
      _completedAt = $v.completedAt;
      _note = $v.note;
      _noteUpdatedAt = $v.noteUpdatedAt;
      _rating = $v.rating;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GBookDetailData_bookDetail_userBook other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GBookDetailData_bookDetail_userBook;
  }

  @override
  void update(
      void Function(GBookDetailData_bookDetail_userBookBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GBookDetailData_bookDetail_userBook build() => _build();

  _$GBookDetailData_bookDetail_userBook _build() {
    _$GBookDetailData_bookDetail_userBook _$result;
    try {
      _$result = _$v ??
          new _$GBookDetailData_bookDetail_userBook._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  r'GBookDetailData_bookDetail_userBook', 'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, r'GBookDetailData_bookDetail_userBook', 'id'),
              externalId: BuiltValueNullFieldError.checkNotNull(externalId,
                  r'GBookDetailData_bookDetail_userBook', 'externalId'),
              title: BuiltValueNullFieldError.checkNotNull(
                  title, r'GBookDetailData_bookDetail_userBook', 'title'),
              authors: authors.build(),
              publisher: publisher,
              publishedDate: publishedDate,
              isbn: isbn,
              coverImageUrl: coverImageUrl,
              addedAt: BuiltValueNullFieldError.checkNotNull(
                  addedAt, r'GBookDetailData_bookDetail_userBook', 'addedAt'),
              readingStatus: BuiltValueNullFieldError.checkNotNull(
                  readingStatus,
                  r'GBookDetailData_bookDetail_userBook',
                  'readingStatus'),
              startedAt: startedAt,
              completedAt: completedAt,
              note: note,
              noteUpdatedAt: noteUpdatedAt,
              rating: rating);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'authors';
        authors.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GBookDetailData_bookDetail_userBook',
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
