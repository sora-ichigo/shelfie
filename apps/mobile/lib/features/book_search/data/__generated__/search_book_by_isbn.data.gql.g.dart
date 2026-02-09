// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_book_by_isbn.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GSearchBookByISBNData> _$gSearchBookByISBNDataSerializer =
    _$GSearchBookByISBNDataSerializer();
Serializer<GSearchBookByISBNData_searchBookByISBN>
_$gSearchBookByISBNDataSearchBookByISBNSerializer =
    _$GSearchBookByISBNData_searchBookByISBNSerializer();

class _$GSearchBookByISBNDataSerializer
    implements StructuredSerializer<GSearchBookByISBNData> {
  @override
  final Iterable<Type> types = const [
    GSearchBookByISBNData,
    _$GSearchBookByISBNData,
  ];
  @override
  final String wireName = 'GSearchBookByISBNData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GSearchBookByISBNData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
    ];
    Object? value;
    value = object.searchBookByISBN;
    if (value != null) {
      result
        ..add('searchBookByISBN')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(
              GSearchBookByISBNData_searchBookByISBN,
            ),
          ),
        );
    }
    return result;
  }

  @override
  GSearchBookByISBNData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GSearchBookByISBNDataBuilder();

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
        case 'searchBookByISBN':
          result.searchBookByISBN.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GSearchBookByISBNData_searchBookByISBN,
                  ),
                )!
                as GSearchBookByISBNData_searchBookByISBN,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GSearchBookByISBNData_searchBookByISBNSerializer
    implements StructuredSerializer<GSearchBookByISBNData_searchBookByISBN> {
  @override
  final Iterable<Type> types = const [
    GSearchBookByISBNData_searchBookByISBN,
    _$GSearchBookByISBNData_searchBookByISBN,
  ];
  @override
  final String wireName = 'GSearchBookByISBNData_searchBookByISBN';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GSearchBookByISBNData_searchBookByISBN object, {
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
  GSearchBookByISBNData_searchBookByISBN deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GSearchBookByISBNData_searchBookByISBNBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GSearchBookByISBNData extends GSearchBookByISBNData {
  @override
  final String G__typename;
  @override
  final GSearchBookByISBNData_searchBookByISBN? searchBookByISBN;

  factory _$GSearchBookByISBNData([
    void Function(GSearchBookByISBNDataBuilder)? updates,
  ]) => (GSearchBookByISBNDataBuilder()..update(updates))._build();

  _$GSearchBookByISBNData._({required this.G__typename, this.searchBookByISBN})
    : super._();
  @override
  GSearchBookByISBNData rebuild(
    void Function(GSearchBookByISBNDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GSearchBookByISBNDataBuilder toBuilder() =>
      GSearchBookByISBNDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchBookByISBNData &&
        G__typename == other.G__typename &&
        searchBookByISBN == other.searchBookByISBN;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, searchBookByISBN.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSearchBookByISBNData')
          ..add('G__typename', G__typename)
          ..add('searchBookByISBN', searchBookByISBN))
        .toString();
  }
}

class GSearchBookByISBNDataBuilder
    implements Builder<GSearchBookByISBNData, GSearchBookByISBNDataBuilder> {
  _$GSearchBookByISBNData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GSearchBookByISBNData_searchBookByISBNBuilder? _searchBookByISBN;
  GSearchBookByISBNData_searchBookByISBNBuilder get searchBookByISBN =>
      _$this._searchBookByISBN ??=
          GSearchBookByISBNData_searchBookByISBNBuilder();
  set searchBookByISBN(
    GSearchBookByISBNData_searchBookByISBNBuilder? searchBookByISBN,
  ) => _$this._searchBookByISBN = searchBookByISBN;

  GSearchBookByISBNDataBuilder() {
    GSearchBookByISBNData._initializeBuilder(this);
  }

  GSearchBookByISBNDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _searchBookByISBN = $v.searchBookByISBN?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchBookByISBNData other) {
    _$v = other as _$GSearchBookByISBNData;
  }

  @override
  void update(void Function(GSearchBookByISBNDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSearchBookByISBNData build() => _build();

  _$GSearchBookByISBNData _build() {
    _$GSearchBookByISBNData _$result;
    try {
      _$result =
          _$v ??
          _$GSearchBookByISBNData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GSearchBookByISBNData',
              'G__typename',
            ),
            searchBookByISBN: _searchBookByISBN?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'searchBookByISBN';
        _searchBookByISBN?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GSearchBookByISBNData',
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

class _$GSearchBookByISBNData_searchBookByISBN
    extends GSearchBookByISBNData_searchBookByISBN {
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

  factory _$GSearchBookByISBNData_searchBookByISBN([
    void Function(GSearchBookByISBNData_searchBookByISBNBuilder)? updates,
  ]) => (GSearchBookByISBNData_searchBookByISBNBuilder()..update(updates))
      ._build();

  _$GSearchBookByISBNData_searchBookByISBN._({
    required this.G__typename,
    required this.id,
    required this.title,
    required this.authors,
    this.publisher,
    this.publishedDate,
    this.isbn,
    this.coverImageUrl,
  }) : super._();
  @override
  GSearchBookByISBNData_searchBookByISBN rebuild(
    void Function(GSearchBookByISBNData_searchBookByISBNBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GSearchBookByISBNData_searchBookByISBNBuilder toBuilder() =>
      GSearchBookByISBNData_searchBookByISBNBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSearchBookByISBNData_searchBookByISBN &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        authors == other.authors &&
        publisher == other.publisher &&
        publishedDate == other.publishedDate &&
        isbn == other.isbn &&
        coverImageUrl == other.coverImageUrl;
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
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GSearchBookByISBNData_searchBookByISBN',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('authors', authors)
          ..add('publisher', publisher)
          ..add('publishedDate', publishedDate)
          ..add('isbn', isbn)
          ..add('coverImageUrl', coverImageUrl))
        .toString();
  }
}

class GSearchBookByISBNData_searchBookByISBNBuilder
    implements
        Builder<
          GSearchBookByISBNData_searchBookByISBN,
          GSearchBookByISBNData_searchBookByISBNBuilder
        > {
  _$GSearchBookByISBNData_searchBookByISBN? _$v;

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

  GSearchBookByISBNData_searchBookByISBNBuilder() {
    GSearchBookByISBNData_searchBookByISBN._initializeBuilder(this);
  }

  GSearchBookByISBNData_searchBookByISBNBuilder get _$this {
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
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSearchBookByISBNData_searchBookByISBN other) {
    _$v = other as _$GSearchBookByISBNData_searchBookByISBN;
  }

  @override
  void update(
    void Function(GSearchBookByISBNData_searchBookByISBNBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GSearchBookByISBNData_searchBookByISBN build() => _build();

  _$GSearchBookByISBNData_searchBookByISBN _build() {
    _$GSearchBookByISBNData_searchBookByISBN _$result;
    try {
      _$result =
          _$v ??
          _$GSearchBookByISBNData_searchBookByISBN._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GSearchBookByISBNData_searchBookByISBN',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GSearchBookByISBNData_searchBookByISBN',
              'id',
            ),
            title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'GSearchBookByISBNData_searchBookByISBN',
              'title',
            ),
            authors: authors.build(),
            publisher: publisher,
            publishedDate: publishedDate,
            isbn: isbn,
            coverImageUrl: coverImageUrl,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'authors';
        authors.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GSearchBookByISBNData_searchBookByISBN',
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
