// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_completed_at.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUpdateCompletedAtData> _$gUpdateCompletedAtDataSerializer =
    new _$GUpdateCompletedAtDataSerializer();
Serializer<GUpdateCompletedAtData_updateCompletedAt>
    _$gUpdateCompletedAtDataUpdateCompletedAtSerializer =
    new _$GUpdateCompletedAtData_updateCompletedAtSerializer();

class _$GUpdateCompletedAtDataSerializer
    implements StructuredSerializer<GUpdateCompletedAtData> {
  @override
  final Iterable<Type> types = const [
    GUpdateCompletedAtData,
    _$GUpdateCompletedAtData
  ];
  @override
  final String wireName = 'GUpdateCompletedAtData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateCompletedAtData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'updateCompletedAt',
      serializers.serialize(object.updateCompletedAt,
          specifiedType:
              const FullType(GUpdateCompletedAtData_updateCompletedAt)),
    ];

    return result;
  }

  @override
  GUpdateCompletedAtData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateCompletedAtDataBuilder();

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
        case 'updateCompletedAt':
          result.updateCompletedAt.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GUpdateCompletedAtData_updateCompletedAt))!
              as GUpdateCompletedAtData_updateCompletedAt);
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateCompletedAtData_updateCompletedAtSerializer
    implements StructuredSerializer<GUpdateCompletedAtData_updateCompletedAt> {
  @override
  final Iterable<Type> types = const [
    GUpdateCompletedAtData_updateCompletedAt,
    _$GUpdateCompletedAtData_updateCompletedAt
  ];
  @override
  final String wireName = 'GUpdateCompletedAtData_updateCompletedAt';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateCompletedAtData_updateCompletedAt object,
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
  GUpdateCompletedAtData_updateCompletedAt deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateCompletedAtData_updateCompletedAtBuilder();

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

class _$GUpdateCompletedAtData extends GUpdateCompletedAtData {
  @override
  final String G__typename;
  @override
  final GUpdateCompletedAtData_updateCompletedAt updateCompletedAt;

  factory _$GUpdateCompletedAtData(
          [void Function(GUpdateCompletedAtDataBuilder)? updates]) =>
      (new GUpdateCompletedAtDataBuilder()..update(updates))._build();

  _$GUpdateCompletedAtData._(
      {required this.G__typename, required this.updateCompletedAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GUpdateCompletedAtData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        updateCompletedAt, r'GUpdateCompletedAtData', 'updateCompletedAt');
  }

  @override
  GUpdateCompletedAtData rebuild(
          void Function(GUpdateCompletedAtDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateCompletedAtDataBuilder toBuilder() =>
      new GUpdateCompletedAtDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateCompletedAtData &&
        G__typename == other.G__typename &&
        updateCompletedAt == other.updateCompletedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, updateCompletedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateCompletedAtData')
          ..add('G__typename', G__typename)
          ..add('updateCompletedAt', updateCompletedAt))
        .toString();
  }
}

class GUpdateCompletedAtDataBuilder
    implements Builder<GUpdateCompletedAtData, GUpdateCompletedAtDataBuilder> {
  _$GUpdateCompletedAtData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GUpdateCompletedAtData_updateCompletedAtBuilder? _updateCompletedAt;
  GUpdateCompletedAtData_updateCompletedAtBuilder get updateCompletedAt =>
      _$this._updateCompletedAt ??=
          new GUpdateCompletedAtData_updateCompletedAtBuilder();
  set updateCompletedAt(
          GUpdateCompletedAtData_updateCompletedAtBuilder? updateCompletedAt) =>
      _$this._updateCompletedAt = updateCompletedAt;

  GUpdateCompletedAtDataBuilder() {
    GUpdateCompletedAtData._initializeBuilder(this);
  }

  GUpdateCompletedAtDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _updateCompletedAt = $v.updateCompletedAt.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateCompletedAtData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateCompletedAtData;
  }

  @override
  void update(void Function(GUpdateCompletedAtDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateCompletedAtData build() => _build();

  _$GUpdateCompletedAtData _build() {
    _$GUpdateCompletedAtData _$result;
    try {
      _$result = _$v ??
          new _$GUpdateCompletedAtData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GUpdateCompletedAtData', 'G__typename'),
              updateCompletedAt: updateCompletedAt.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'updateCompletedAt';
        updateCompletedAt.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GUpdateCompletedAtData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateCompletedAtData_updateCompletedAt
    extends GUpdateCompletedAtData_updateCompletedAt {
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

  factory _$GUpdateCompletedAtData_updateCompletedAt(
          [void Function(GUpdateCompletedAtData_updateCompletedAtBuilder)?
              updates]) =>
      (new GUpdateCompletedAtData_updateCompletedAtBuilder()..update(updates))
          ._build();

  _$GUpdateCompletedAtData_updateCompletedAt._(
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
    BuiltValueNullFieldError.checkNotNull(G__typename,
        r'GUpdateCompletedAtData_updateCompletedAt', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GUpdateCompletedAtData_updateCompletedAt', 'id');
    BuiltValueNullFieldError.checkNotNull(
        externalId, r'GUpdateCompletedAtData_updateCompletedAt', 'externalId');
    BuiltValueNullFieldError.checkNotNull(
        title, r'GUpdateCompletedAtData_updateCompletedAt', 'title');
    BuiltValueNullFieldError.checkNotNull(
        authors, r'GUpdateCompletedAtData_updateCompletedAt', 'authors');
    BuiltValueNullFieldError.checkNotNull(
        addedAt, r'GUpdateCompletedAtData_updateCompletedAt', 'addedAt');
    BuiltValueNullFieldError.checkNotNull(readingStatus,
        r'GUpdateCompletedAtData_updateCompletedAt', 'readingStatus');
  }

  @override
  GUpdateCompletedAtData_updateCompletedAt rebuild(
          void Function(GUpdateCompletedAtData_updateCompletedAtBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateCompletedAtData_updateCompletedAtBuilder toBuilder() =>
      new GUpdateCompletedAtData_updateCompletedAtBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateCompletedAtData_updateCompletedAt &&
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
    return (newBuiltValueToStringHelper(
            r'GUpdateCompletedAtData_updateCompletedAt')
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

class GUpdateCompletedAtData_updateCompletedAtBuilder
    implements
        Builder<GUpdateCompletedAtData_updateCompletedAt,
            GUpdateCompletedAtData_updateCompletedAtBuilder> {
  _$GUpdateCompletedAtData_updateCompletedAt? _$v;

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

  GUpdateCompletedAtData_updateCompletedAtBuilder() {
    GUpdateCompletedAtData_updateCompletedAt._initializeBuilder(this);
  }

  GUpdateCompletedAtData_updateCompletedAtBuilder get _$this {
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
  void replace(GUpdateCompletedAtData_updateCompletedAt other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateCompletedAtData_updateCompletedAt;
  }

  @override
  void update(
      void Function(GUpdateCompletedAtData_updateCompletedAtBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateCompletedAtData_updateCompletedAt build() => _build();

  _$GUpdateCompletedAtData_updateCompletedAt _build() {
    _$GUpdateCompletedAtData_updateCompletedAt _$result;
    try {
      _$result = _$v ??
          new _$GUpdateCompletedAtData_updateCompletedAt._(
              G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                  r'GUpdateCompletedAtData_updateCompletedAt', 'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, r'GUpdateCompletedAtData_updateCompletedAt', 'id'),
              externalId: BuiltValueNullFieldError.checkNotNull(
                  externalId, r'GUpdateCompletedAtData_updateCompletedAt', 'externalId'),
              title: BuiltValueNullFieldError.checkNotNull(
                  title, r'GUpdateCompletedAtData_updateCompletedAt', 'title'),
              authors: authors.build(),
              publisher: publisher,
              publishedDate: publishedDate,
              isbn: isbn,
              coverImageUrl: coverImageUrl,
              addedAt: BuiltValueNullFieldError.checkNotNull(
                  addedAt, r'GUpdateCompletedAtData_updateCompletedAt', 'addedAt'),
              readingStatus: BuiltValueNullFieldError.checkNotNull(
                  readingStatus,
                  r'GUpdateCompletedAtData_updateCompletedAt',
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
            r'GUpdateCompletedAtData_updateCompletedAt',
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
