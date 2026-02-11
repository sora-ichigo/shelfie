// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_reading_status.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUpdateReadingStatusData> _$gUpdateReadingStatusDataSerializer =
    _$GUpdateReadingStatusDataSerializer();
Serializer<GUpdateReadingStatusData_updateReadingStatus>
    _$gUpdateReadingStatusDataUpdateReadingStatusSerializer =
    _$GUpdateReadingStatusData_updateReadingStatusSerializer();

class _$GUpdateReadingStatusDataSerializer
    implements StructuredSerializer<GUpdateReadingStatusData> {
  @override
  final Iterable<Type> types = const [
    GUpdateReadingStatusData,
    _$GUpdateReadingStatusData
  ];
  @override
  final String wireName = 'GUpdateReadingStatusData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateReadingStatusData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'updateReadingStatus',
      serializers.serialize(object.updateReadingStatus,
          specifiedType:
              const FullType(GUpdateReadingStatusData_updateReadingStatus)),
    ];

    return result;
  }

  @override
  GUpdateReadingStatusData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUpdateReadingStatusDataBuilder();

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
        case 'updateReadingStatus':
          result.updateReadingStatus.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GUpdateReadingStatusData_updateReadingStatus))!
              as GUpdateReadingStatusData_updateReadingStatus);
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateReadingStatusData_updateReadingStatusSerializer
    implements
        StructuredSerializer<GUpdateReadingStatusData_updateReadingStatus> {
  @override
  final Iterable<Type> types = const [
    GUpdateReadingStatusData_updateReadingStatus,
    _$GUpdateReadingStatusData_updateReadingStatus
  ];
  @override
  final String wireName = 'GUpdateReadingStatusData_updateReadingStatus';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GUpdateReadingStatusData_updateReadingStatus object,
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
  GUpdateReadingStatusData_updateReadingStatus deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUpdateReadingStatusData_updateReadingStatusBuilder();

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

class _$GUpdateReadingStatusData extends GUpdateReadingStatusData {
  @override
  final String G__typename;
  @override
  final GUpdateReadingStatusData_updateReadingStatus updateReadingStatus;

  factory _$GUpdateReadingStatusData(
          [void Function(GUpdateReadingStatusDataBuilder)? updates]) =>
      (GUpdateReadingStatusDataBuilder()..update(updates))._build();

  _$GUpdateReadingStatusData._(
      {required this.G__typename, required this.updateReadingStatus})
      : super._();
  @override
  GUpdateReadingStatusData rebuild(
          void Function(GUpdateReadingStatusDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateReadingStatusDataBuilder toBuilder() =>
      GUpdateReadingStatusDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateReadingStatusData &&
        G__typename == other.G__typename &&
        updateReadingStatus == other.updateReadingStatus;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, updateReadingStatus.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateReadingStatusData')
          ..add('G__typename', G__typename)
          ..add('updateReadingStatus', updateReadingStatus))
        .toString();
  }
}

class GUpdateReadingStatusDataBuilder
    implements
        Builder<GUpdateReadingStatusData, GUpdateReadingStatusDataBuilder> {
  _$GUpdateReadingStatusData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GUpdateReadingStatusData_updateReadingStatusBuilder? _updateReadingStatus;
  GUpdateReadingStatusData_updateReadingStatusBuilder get updateReadingStatus =>
      _$this._updateReadingStatus ??=
          GUpdateReadingStatusData_updateReadingStatusBuilder();
  set updateReadingStatus(
          GUpdateReadingStatusData_updateReadingStatusBuilder?
              updateReadingStatus) =>
      _$this._updateReadingStatus = updateReadingStatus;

  GUpdateReadingStatusDataBuilder() {
    GUpdateReadingStatusData._initializeBuilder(this);
  }

  GUpdateReadingStatusDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _updateReadingStatus = $v.updateReadingStatus.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateReadingStatusData other) {
    _$v = other as _$GUpdateReadingStatusData;
  }

  @override
  void update(void Function(GUpdateReadingStatusDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateReadingStatusData build() => _build();

  _$GUpdateReadingStatusData _build() {
    _$GUpdateReadingStatusData _$result;
    try {
      _$result = _$v ??
          _$GUpdateReadingStatusData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GUpdateReadingStatusData', 'G__typename'),
            updateReadingStatus: updateReadingStatus.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'updateReadingStatus';
        updateReadingStatus.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GUpdateReadingStatusData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateReadingStatusData_updateReadingStatus
    extends GUpdateReadingStatusData_updateReadingStatus {
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

  factory _$GUpdateReadingStatusData_updateReadingStatus(
          [void Function(GUpdateReadingStatusData_updateReadingStatusBuilder)?
              updates]) =>
      (GUpdateReadingStatusData_updateReadingStatusBuilder()..update(updates))
          ._build();

  _$GUpdateReadingStatusData_updateReadingStatus._(
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
  GUpdateReadingStatusData_updateReadingStatus rebuild(
          void Function(GUpdateReadingStatusData_updateReadingStatusBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateReadingStatusData_updateReadingStatusBuilder toBuilder() =>
      GUpdateReadingStatusData_updateReadingStatusBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateReadingStatusData_updateReadingStatus &&
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
            r'GUpdateReadingStatusData_updateReadingStatus')
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

class GUpdateReadingStatusData_updateReadingStatusBuilder
    implements
        Builder<GUpdateReadingStatusData_updateReadingStatus,
            GUpdateReadingStatusData_updateReadingStatusBuilder> {
  _$GUpdateReadingStatusData_updateReadingStatus? _$v;

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

  GUpdateReadingStatusData_updateReadingStatusBuilder() {
    GUpdateReadingStatusData_updateReadingStatus._initializeBuilder(this);
  }

  GUpdateReadingStatusData_updateReadingStatusBuilder get _$this {
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
  void replace(GUpdateReadingStatusData_updateReadingStatus other) {
    _$v = other as _$GUpdateReadingStatusData_updateReadingStatus;
  }

  @override
  void update(
      void Function(GUpdateReadingStatusData_updateReadingStatusBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateReadingStatusData_updateReadingStatus build() => _build();

  _$GUpdateReadingStatusData_updateReadingStatus _build() {
    _$GUpdateReadingStatusData_updateReadingStatus _$result;
    try {
      _$result = _$v ??
          _$GUpdateReadingStatusData_updateReadingStatus._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GUpdateReadingStatusData_updateReadingStatus', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GUpdateReadingStatusData_updateReadingStatus', 'id'),
            externalId: BuiltValueNullFieldError.checkNotNull(externalId,
                r'GUpdateReadingStatusData_updateReadingStatus', 'externalId'),
            title: BuiltValueNullFieldError.checkNotNull(title,
                r'GUpdateReadingStatusData_updateReadingStatus', 'title'),
            authors: authors.build(),
            publisher: publisher,
            publishedDate: publishedDate,
            isbn: isbn,
            coverImageUrl: coverImageUrl,
            addedAt: BuiltValueNullFieldError.checkNotNull(addedAt,
                r'GUpdateReadingStatusData_updateReadingStatus', 'addedAt'),
            readingStatus: BuiltValueNullFieldError.checkNotNull(
                readingStatus,
                r'GUpdateReadingStatusData_updateReadingStatus',
                'readingStatus'),
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
            r'GUpdateReadingStatusData_updateReadingStatus',
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
