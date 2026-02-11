// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_started_at.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUpdateStartedAtData> _$gUpdateStartedAtDataSerializer =
    _$GUpdateStartedAtDataSerializer();
Serializer<GUpdateStartedAtData_updateStartedAt>
    _$gUpdateStartedAtDataUpdateStartedAtSerializer =
    _$GUpdateStartedAtData_updateStartedAtSerializer();

class _$GUpdateStartedAtDataSerializer
    implements StructuredSerializer<GUpdateStartedAtData> {
  @override
  final Iterable<Type> types = const [
    GUpdateStartedAtData,
    _$GUpdateStartedAtData
  ];
  @override
  final String wireName = 'GUpdateStartedAtData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateStartedAtData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'updateStartedAt',
      serializers.serialize(object.updateStartedAt,
          specifiedType: const FullType(GUpdateStartedAtData_updateStartedAt)),
    ];

    return result;
  }

  @override
  GUpdateStartedAtData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUpdateStartedAtDataBuilder();

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
        case 'updateStartedAt':
          result.updateStartedAt.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GUpdateStartedAtData_updateStartedAt))!
              as GUpdateStartedAtData_updateStartedAt);
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateStartedAtData_updateStartedAtSerializer
    implements StructuredSerializer<GUpdateStartedAtData_updateStartedAt> {
  @override
  final Iterable<Type> types = const [
    GUpdateStartedAtData_updateStartedAt,
    _$GUpdateStartedAtData_updateStartedAt
  ];
  @override
  final String wireName = 'GUpdateStartedAtData_updateStartedAt';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateStartedAtData_updateStartedAt object,
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
  GUpdateStartedAtData_updateStartedAt deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUpdateStartedAtData_updateStartedAtBuilder();

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

class _$GUpdateStartedAtData extends GUpdateStartedAtData {
  @override
  final String G__typename;
  @override
  final GUpdateStartedAtData_updateStartedAt updateStartedAt;

  factory _$GUpdateStartedAtData(
          [void Function(GUpdateStartedAtDataBuilder)? updates]) =>
      (GUpdateStartedAtDataBuilder()..update(updates))._build();

  _$GUpdateStartedAtData._(
      {required this.G__typename, required this.updateStartedAt})
      : super._();
  @override
  GUpdateStartedAtData rebuild(
          void Function(GUpdateStartedAtDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateStartedAtDataBuilder toBuilder() =>
      GUpdateStartedAtDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateStartedAtData &&
        G__typename == other.G__typename &&
        updateStartedAt == other.updateStartedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, updateStartedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateStartedAtData')
          ..add('G__typename', G__typename)
          ..add('updateStartedAt', updateStartedAt))
        .toString();
  }
}

class GUpdateStartedAtDataBuilder
    implements Builder<GUpdateStartedAtData, GUpdateStartedAtDataBuilder> {
  _$GUpdateStartedAtData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GUpdateStartedAtData_updateStartedAtBuilder? _updateStartedAt;
  GUpdateStartedAtData_updateStartedAtBuilder get updateStartedAt =>
      _$this._updateStartedAt ??= GUpdateStartedAtData_updateStartedAtBuilder();
  set updateStartedAt(
          GUpdateStartedAtData_updateStartedAtBuilder? updateStartedAt) =>
      _$this._updateStartedAt = updateStartedAt;

  GUpdateStartedAtDataBuilder() {
    GUpdateStartedAtData._initializeBuilder(this);
  }

  GUpdateStartedAtDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _updateStartedAt = $v.updateStartedAt.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateStartedAtData other) {
    _$v = other as _$GUpdateStartedAtData;
  }

  @override
  void update(void Function(GUpdateStartedAtDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateStartedAtData build() => _build();

  _$GUpdateStartedAtData _build() {
    _$GUpdateStartedAtData _$result;
    try {
      _$result = _$v ??
          _$GUpdateStartedAtData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GUpdateStartedAtData', 'G__typename'),
            updateStartedAt: updateStartedAt.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'updateStartedAt';
        updateStartedAt.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GUpdateStartedAtData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateStartedAtData_updateStartedAt
    extends GUpdateStartedAtData_updateStartedAt {
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

  factory _$GUpdateStartedAtData_updateStartedAt(
          [void Function(GUpdateStartedAtData_updateStartedAtBuilder)?
              updates]) =>
      (GUpdateStartedAtData_updateStartedAtBuilder()..update(updates))._build();

  _$GUpdateStartedAtData_updateStartedAt._(
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
      : super._();
  @override
  GUpdateStartedAtData_updateStartedAt rebuild(
          void Function(GUpdateStartedAtData_updateStartedAtBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateStartedAtData_updateStartedAtBuilder toBuilder() =>
      GUpdateStartedAtData_updateStartedAtBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateStartedAtData_updateStartedAt &&
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
    return (newBuiltValueToStringHelper(r'GUpdateStartedAtData_updateStartedAt')
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

class GUpdateStartedAtData_updateStartedAtBuilder
    implements
        Builder<GUpdateStartedAtData_updateStartedAt,
            GUpdateStartedAtData_updateStartedAtBuilder> {
  _$GUpdateStartedAtData_updateStartedAt? _$v;

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

  GUpdateStartedAtData_updateStartedAtBuilder() {
    GUpdateStartedAtData_updateStartedAt._initializeBuilder(this);
  }

  GUpdateStartedAtData_updateStartedAtBuilder get _$this {
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
  void replace(GUpdateStartedAtData_updateStartedAt other) {
    _$v = other as _$GUpdateStartedAtData_updateStartedAt;
  }

  @override
  void update(
      void Function(GUpdateStartedAtData_updateStartedAtBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateStartedAtData_updateStartedAt build() => _build();

  _$GUpdateStartedAtData_updateStartedAt _build() {
    _$GUpdateStartedAtData_updateStartedAt _$result;
    try {
      _$result = _$v ??
          _$GUpdateStartedAtData_updateStartedAt._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GUpdateStartedAtData_updateStartedAt', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GUpdateStartedAtData_updateStartedAt', 'id'),
            externalId: BuiltValueNullFieldError.checkNotNull(externalId,
                r'GUpdateStartedAtData_updateStartedAt', 'externalId'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GUpdateStartedAtData_updateStartedAt', 'title'),
            authors: authors.build(),
            publisher: publisher,
            publishedDate: publishedDate,
            isbn: isbn,
            coverImageUrl: coverImageUrl,
            addedAt: BuiltValueNullFieldError.checkNotNull(
                addedAt, r'GUpdateStartedAtData_updateStartedAt', 'addedAt'),
            readingStatus: BuiltValueNullFieldError.checkNotNull(readingStatus,
                r'GUpdateStartedAtData_updateStartedAt', 'readingStatus'),
            startedAt: startedAt,
            completedAt: completedAt,
            note: note,
            noteUpdatedAt: noteUpdatedAt,
            rating: rating,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'authors';
        authors.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GUpdateStartedAtData_updateStartedAt',
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
