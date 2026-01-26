// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_book_to_shelf.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GAddBookToShelfData> _$gAddBookToShelfDataSerializer =
    _$GAddBookToShelfDataSerializer();
Serializer<GAddBookToShelfData_addBookToShelf>
    _$gAddBookToShelfDataAddBookToShelfSerializer =
    _$GAddBookToShelfData_addBookToShelfSerializer();

class _$GAddBookToShelfDataSerializer
    implements StructuredSerializer<GAddBookToShelfData> {
  @override
  final Iterable<Type> types = const [
    GAddBookToShelfData,
    _$GAddBookToShelfData
  ];
  @override
  final String wireName = 'GAddBookToShelfData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAddBookToShelfData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'addBookToShelf',
      serializers.serialize(object.addBookToShelf,
          specifiedType: const FullType(GAddBookToShelfData_addBookToShelf)),
    ];

    return result;
  }

  @override
  GAddBookToShelfData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GAddBookToShelfDataBuilder();

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
        case 'addBookToShelf':
          result.addBookToShelf.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GAddBookToShelfData_addBookToShelf))!
              as GAddBookToShelfData_addBookToShelf);
          break;
      }
    }

    return result.build();
  }
}

class _$GAddBookToShelfData_addBookToShelfSerializer
    implements StructuredSerializer<GAddBookToShelfData_addBookToShelf> {
  @override
  final Iterable<Type> types = const [
    GAddBookToShelfData_addBookToShelf,
    _$GAddBookToShelfData_addBookToShelf
  ];
  @override
  final String wireName = 'GAddBookToShelfData_addBookToShelf';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAddBookToShelfData_addBookToShelf object,
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
      'source',
      serializers.serialize(object.source,
          specifiedType: const FullType(_i2.GBookSource)),
      'addedAt',
      serializers.serialize(object.addedAt,
          specifiedType: const FullType(DateTime)),
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
    return result;
  }

  @override
  GAddBookToShelfData_addBookToShelf deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GAddBookToShelfData_addBookToShelfBuilder();

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
        case 'source':
          result.source = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GBookSource))!
              as _i2.GBookSource;
          break;
        case 'addedAt':
          result.addedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
      }
    }

    return result.build();
  }
}

class _$GAddBookToShelfData extends GAddBookToShelfData {
  @override
  final String G__typename;
  @override
  final GAddBookToShelfData_addBookToShelf addBookToShelf;

  factory _$GAddBookToShelfData(
          [void Function(GAddBookToShelfDataBuilder)? updates]) =>
      (GAddBookToShelfDataBuilder()..update(updates))._build();

  _$GAddBookToShelfData._(
      {required this.G__typename, required this.addBookToShelf})
      : super._();
  @override
  GAddBookToShelfData rebuild(
          void Function(GAddBookToShelfDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAddBookToShelfDataBuilder toBuilder() =>
      GAddBookToShelfDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAddBookToShelfData &&
        G__typename == other.G__typename &&
        addBookToShelf == other.addBookToShelf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, addBookToShelf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAddBookToShelfData')
          ..add('G__typename', G__typename)
          ..add('addBookToShelf', addBookToShelf))
        .toString();
  }
}

class GAddBookToShelfDataBuilder
    implements Builder<GAddBookToShelfData, GAddBookToShelfDataBuilder> {
  _$GAddBookToShelfData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GAddBookToShelfData_addBookToShelfBuilder? _addBookToShelf;
  GAddBookToShelfData_addBookToShelfBuilder get addBookToShelf =>
      _$this._addBookToShelf ??= GAddBookToShelfData_addBookToShelfBuilder();
  set addBookToShelf(
          GAddBookToShelfData_addBookToShelfBuilder? addBookToShelf) =>
      _$this._addBookToShelf = addBookToShelf;

  GAddBookToShelfDataBuilder() {
    GAddBookToShelfData._initializeBuilder(this);
  }

  GAddBookToShelfDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _addBookToShelf = $v.addBookToShelf.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAddBookToShelfData other) {
    _$v = other as _$GAddBookToShelfData;
  }

  @override
  void update(void Function(GAddBookToShelfDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAddBookToShelfData build() => _build();

  _$GAddBookToShelfData _build() {
    _$GAddBookToShelfData _$result;
    try {
      _$result = _$v ??
          _$GAddBookToShelfData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GAddBookToShelfData', 'G__typename'),
            addBookToShelf: addBookToShelf.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'addBookToShelf';
        addBookToShelf.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GAddBookToShelfData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAddBookToShelfData_addBookToShelf
    extends GAddBookToShelfData_addBookToShelf {
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
  final _i2.GBookSource source;
  @override
  final DateTime addedAt;

  factory _$GAddBookToShelfData_addBookToShelf(
          [void Function(GAddBookToShelfData_addBookToShelfBuilder)?
              updates]) =>
      (GAddBookToShelfData_addBookToShelfBuilder()..update(updates))._build();

  _$GAddBookToShelfData_addBookToShelf._(
      {required this.G__typename,
      required this.id,
      required this.externalId,
      required this.title,
      required this.authors,
      this.publisher,
      this.publishedDate,
      this.isbn,
      this.coverImageUrl,
      required this.source,
      required this.addedAt})
      : super._();
  @override
  GAddBookToShelfData_addBookToShelf rebuild(
          void Function(GAddBookToShelfData_addBookToShelfBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAddBookToShelfData_addBookToShelfBuilder toBuilder() =>
      GAddBookToShelfData_addBookToShelfBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAddBookToShelfData_addBookToShelf &&
        G__typename == other.G__typename &&
        id == other.id &&
        externalId == other.externalId &&
        title == other.title &&
        authors == other.authors &&
        publisher == other.publisher &&
        publishedDate == other.publishedDate &&
        isbn == other.isbn &&
        coverImageUrl == other.coverImageUrl &&
        source == other.source &&
        addedAt == other.addedAt;
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
    _$hash = $jc(_$hash, source.hashCode);
    _$hash = $jc(_$hash, addedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAddBookToShelfData_addBookToShelf')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('externalId', externalId)
          ..add('title', title)
          ..add('authors', authors)
          ..add('publisher', publisher)
          ..add('publishedDate', publishedDate)
          ..add('isbn', isbn)
          ..add('coverImageUrl', coverImageUrl)
          ..add('source', source)
          ..add('addedAt', addedAt))
        .toString();
  }
}

class GAddBookToShelfData_addBookToShelfBuilder
    implements
        Builder<GAddBookToShelfData_addBookToShelf,
            GAddBookToShelfData_addBookToShelfBuilder> {
  _$GAddBookToShelfData_addBookToShelf? _$v;

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

  DateTime? _addedAt;
  DateTime? get addedAt => _$this._addedAt;
  set addedAt(DateTime? addedAt) => _$this._addedAt = addedAt;

  GAddBookToShelfData_addBookToShelfBuilder() {
    GAddBookToShelfData_addBookToShelf._initializeBuilder(this);
  }

  GAddBookToShelfData_addBookToShelfBuilder get _$this {
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
      _source = $v.source;
      _addedAt = $v.addedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAddBookToShelfData_addBookToShelf other) {
    _$v = other as _$GAddBookToShelfData_addBookToShelf;
  }

  @override
  void update(
      void Function(GAddBookToShelfData_addBookToShelfBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAddBookToShelfData_addBookToShelf build() => _build();

  _$GAddBookToShelfData_addBookToShelf _build() {
    _$GAddBookToShelfData_addBookToShelf _$result;
    try {
      _$result = _$v ??
          _$GAddBookToShelfData_addBookToShelf._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GAddBookToShelfData_addBookToShelf', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GAddBookToShelfData_addBookToShelf', 'id'),
            externalId: BuiltValueNullFieldError.checkNotNull(externalId,
                r'GAddBookToShelfData_addBookToShelf', 'externalId'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GAddBookToShelfData_addBookToShelf', 'title'),
            authors: authors.build(),
            publisher: publisher,
            publishedDate: publishedDate,
            isbn: isbn,
            coverImageUrl: coverImageUrl,
            source: BuiltValueNullFieldError.checkNotNull(
                source, r'GAddBookToShelfData_addBookToShelf', 'source'),
            addedAt: BuiltValueNullFieldError.checkNotNull(
                addedAt, r'GAddBookToShelfData_addBookToShelf', 'addedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'authors';
        authors.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GAddBookToShelfData_addBookToShelf', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
