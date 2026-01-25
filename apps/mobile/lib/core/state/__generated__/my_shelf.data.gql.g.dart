// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_shelf.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMyShelfData> _$gMyShelfDataSerializer =
    new _$GMyShelfDataSerializer();
Serializer<GMyShelfData_myShelf> _$gMyShelfDataMyShelfSerializer =
    new _$GMyShelfData_myShelfSerializer();
Serializer<GMyShelfData_myShelf_items> _$gMyShelfDataMyShelfItemsSerializer =
    new _$GMyShelfData_myShelf_itemsSerializer();

class _$GMyShelfDataSerializer implements StructuredSerializer<GMyShelfData> {
  @override
  final Iterable<Type> types = const [GMyShelfData, _$GMyShelfData];
  @override
  final String wireName = 'GMyShelfData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GMyShelfData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'myShelf',
      serializers.serialize(object.myShelf,
          specifiedType: const FullType(GMyShelfData_myShelf)),
    ];

    return result;
  }

  @override
  GMyShelfData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GMyShelfDataBuilder();

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
                  specifiedType: const FullType(GMyShelfData_myShelf))!
              as GMyShelfData_myShelf);
          break;
      }
    }

    return result.build();
  }
}

class _$GMyShelfData_myShelfSerializer
    implements StructuredSerializer<GMyShelfData_myShelf> {
  @override
  final Iterable<Type> types = const [
    GMyShelfData_myShelf,
    _$GMyShelfData_myShelf
  ];
  @override
  final String wireName = 'GMyShelfData_myShelf';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMyShelfData_myShelf object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'items',
      serializers.serialize(object.items,
          specifiedType: const FullType(
              BuiltList, const [const FullType(GMyShelfData_myShelf_items)])),
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
  GMyShelfData_myShelf deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GMyShelfData_myShelfBuilder();

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
                const FullType(GMyShelfData_myShelf_items)
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

class _$GMyShelfData_myShelf_itemsSerializer
    implements StructuredSerializer<GMyShelfData_myShelf_items> {
  @override
  final Iterable<Type> types = const [
    GMyShelfData_myShelf_items,
    _$GMyShelfData_myShelf_items
  ];
  @override
  final String wireName = 'GMyShelfData_myShelf_items';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMyShelfData_myShelf_items object,
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
      'addedAt',
      serializers.serialize(object.addedAt,
          specifiedType: const FullType(DateTime)),
    ];
    Object? value;
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
    value = object.completedAt;
    if (value != null) {
      result
        ..add('completedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    return result;
  }

  @override
  GMyShelfData_myShelf_items deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GMyShelfData_myShelf_itemsBuilder();

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
        case 'readingStatus':
          result.readingStatus = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GReadingStatus))!
              as _i2.GReadingStatus;
          break;
        case 'note':
          result.note = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'noteUpdatedAt':
          result.noteUpdatedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'addedAt':
          result.addedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'completedAt':
          result.completedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
      }
    }

    return result.build();
  }
}

class _$GMyShelfData extends GMyShelfData {
  @override
  final String G__typename;
  @override
  final GMyShelfData_myShelf myShelf;

  factory _$GMyShelfData([void Function(GMyShelfDataBuilder)? updates]) =>
      (new GMyShelfDataBuilder()..update(updates))._build();

  _$GMyShelfData._({required this.G__typename, required this.myShelf})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GMyShelfData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(myShelf, r'GMyShelfData', 'myShelf');
  }

  @override
  GMyShelfData rebuild(void Function(GMyShelfDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMyShelfDataBuilder toBuilder() => new GMyShelfDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyShelfData &&
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
    return (newBuiltValueToStringHelper(r'GMyShelfData')
          ..add('G__typename', G__typename)
          ..add('myShelf', myShelf))
        .toString();
  }
}

class GMyShelfDataBuilder
    implements Builder<GMyShelfData, GMyShelfDataBuilder> {
  _$GMyShelfData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GMyShelfData_myShelfBuilder? _myShelf;
  GMyShelfData_myShelfBuilder get myShelf =>
      _$this._myShelf ??= new GMyShelfData_myShelfBuilder();
  set myShelf(GMyShelfData_myShelfBuilder? myShelf) =>
      _$this._myShelf = myShelf;

  GMyShelfDataBuilder() {
    GMyShelfData._initializeBuilder(this);
  }

  GMyShelfDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _myShelf = $v.myShelf.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyShelfData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GMyShelfData;
  }

  @override
  void update(void Function(GMyShelfDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMyShelfData build() => _build();

  _$GMyShelfData _build() {
    _$GMyShelfData _$result;
    try {
      _$result = _$v ??
          new _$GMyShelfData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GMyShelfData', 'G__typename'),
              myShelf: myShelf.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'myShelf';
        myShelf.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GMyShelfData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMyShelfData_myShelf extends GMyShelfData_myShelf {
  @override
  final String G__typename;
  @override
  final BuiltList<GMyShelfData_myShelf_items> items;
  @override
  final int totalCount;
  @override
  final bool hasMore;

  factory _$GMyShelfData_myShelf(
          [void Function(GMyShelfData_myShelfBuilder)? updates]) =>
      (new GMyShelfData_myShelfBuilder()..update(updates))._build();

  _$GMyShelfData_myShelf._(
      {required this.G__typename,
      required this.items,
      required this.totalCount,
      required this.hasMore})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GMyShelfData_myShelf', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        items, r'GMyShelfData_myShelf', 'items');
    BuiltValueNullFieldError.checkNotNull(
        totalCount, r'GMyShelfData_myShelf', 'totalCount');
    BuiltValueNullFieldError.checkNotNull(
        hasMore, r'GMyShelfData_myShelf', 'hasMore');
  }

  @override
  GMyShelfData_myShelf rebuild(
          void Function(GMyShelfData_myShelfBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMyShelfData_myShelfBuilder toBuilder() =>
      new GMyShelfData_myShelfBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyShelfData_myShelf &&
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
    return (newBuiltValueToStringHelper(r'GMyShelfData_myShelf')
          ..add('G__typename', G__typename)
          ..add('items', items)
          ..add('totalCount', totalCount)
          ..add('hasMore', hasMore))
        .toString();
  }
}

class GMyShelfData_myShelfBuilder
    implements Builder<GMyShelfData_myShelf, GMyShelfData_myShelfBuilder> {
  _$GMyShelfData_myShelf? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GMyShelfData_myShelf_items>? _items;
  ListBuilder<GMyShelfData_myShelf_items> get items =>
      _$this._items ??= new ListBuilder<GMyShelfData_myShelf_items>();
  set items(ListBuilder<GMyShelfData_myShelf_items>? items) =>
      _$this._items = items;

  int? _totalCount;
  int? get totalCount => _$this._totalCount;
  set totalCount(int? totalCount) => _$this._totalCount = totalCount;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(bool? hasMore) => _$this._hasMore = hasMore;

  GMyShelfData_myShelfBuilder() {
    GMyShelfData_myShelf._initializeBuilder(this);
  }

  GMyShelfData_myShelfBuilder get _$this {
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
  void replace(GMyShelfData_myShelf other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GMyShelfData_myShelf;
  }

  @override
  void update(void Function(GMyShelfData_myShelfBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMyShelfData_myShelf build() => _build();

  _$GMyShelfData_myShelf _build() {
    _$GMyShelfData_myShelf _$result;
    try {
      _$result = _$v ??
          new _$GMyShelfData_myShelf._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GMyShelfData_myShelf', 'G__typename'),
              items: items.build(),
              totalCount: BuiltValueNullFieldError.checkNotNull(
                  totalCount, r'GMyShelfData_myShelf', 'totalCount'),
              hasMore: BuiltValueNullFieldError.checkNotNull(
                  hasMore, r'GMyShelfData_myShelf', 'hasMore'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GMyShelfData_myShelf', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMyShelfData_myShelf_items extends GMyShelfData_myShelf_items {
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
  final _i2.GReadingStatus readingStatus;
  @override
  final String? note;
  @override
  final DateTime? noteUpdatedAt;
  @override
  final DateTime addedAt;
  @override
  final DateTime? completedAt;

  factory _$GMyShelfData_myShelf_items(
          [void Function(GMyShelfData_myShelf_itemsBuilder)? updates]) =>
      (new GMyShelfData_myShelf_itemsBuilder()..update(updates))._build();

  _$GMyShelfData_myShelf_items._(
      {required this.G__typename,
      required this.id,
      required this.externalId,
      required this.title,
      required this.authors,
      required this.readingStatus,
      this.note,
      this.noteUpdatedAt,
      required this.addedAt,
      this.completedAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GMyShelfData_myShelf_items', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GMyShelfData_myShelf_items', 'id');
    BuiltValueNullFieldError.checkNotNull(
        externalId, r'GMyShelfData_myShelf_items', 'externalId');
    BuiltValueNullFieldError.checkNotNull(
        title, r'GMyShelfData_myShelf_items', 'title');
    BuiltValueNullFieldError.checkNotNull(
        authors, r'GMyShelfData_myShelf_items', 'authors');
    BuiltValueNullFieldError.checkNotNull(
        readingStatus, r'GMyShelfData_myShelf_items', 'readingStatus');
    BuiltValueNullFieldError.checkNotNull(
        addedAt, r'GMyShelfData_myShelf_items', 'addedAt');
  }

  @override
  GMyShelfData_myShelf_items rebuild(
          void Function(GMyShelfData_myShelf_itemsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMyShelfData_myShelf_itemsBuilder toBuilder() =>
      new GMyShelfData_myShelf_itemsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyShelfData_myShelf_items &&
        G__typename == other.G__typename &&
        id == other.id &&
        externalId == other.externalId &&
        title == other.title &&
        authors == other.authors &&
        readingStatus == other.readingStatus &&
        note == other.note &&
        noteUpdatedAt == other.noteUpdatedAt &&
        addedAt == other.addedAt &&
        completedAt == other.completedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, externalId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, authors.hashCode);
    _$hash = $jc(_$hash, readingStatus.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jc(_$hash, noteUpdatedAt.hashCode);
    _$hash = $jc(_$hash, addedAt.hashCode);
    _$hash = $jc(_$hash, completedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMyShelfData_myShelf_items')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('externalId', externalId)
          ..add('title', title)
          ..add('authors', authors)
          ..add('readingStatus', readingStatus)
          ..add('note', note)
          ..add('noteUpdatedAt', noteUpdatedAt)
          ..add('addedAt', addedAt)
          ..add('completedAt', completedAt))
        .toString();
  }
}

class GMyShelfData_myShelf_itemsBuilder
    implements
        Builder<GMyShelfData_myShelf_items, GMyShelfData_myShelf_itemsBuilder> {
  _$GMyShelfData_myShelf_items? _$v;

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

  _i2.GReadingStatus? _readingStatus;
  _i2.GReadingStatus? get readingStatus => _$this._readingStatus;
  set readingStatus(_i2.GReadingStatus? readingStatus) =>
      _$this._readingStatus = readingStatus;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  DateTime? _noteUpdatedAt;
  DateTime? get noteUpdatedAt => _$this._noteUpdatedAt;
  set noteUpdatedAt(DateTime? noteUpdatedAt) =>
      _$this._noteUpdatedAt = noteUpdatedAt;

  DateTime? _addedAt;
  DateTime? get addedAt => _$this._addedAt;
  set addedAt(DateTime? addedAt) => _$this._addedAt = addedAt;

  DateTime? _completedAt;
  DateTime? get completedAt => _$this._completedAt;
  set completedAt(DateTime? completedAt) => _$this._completedAt = completedAt;

  GMyShelfData_myShelf_itemsBuilder() {
    GMyShelfData_myShelf_items._initializeBuilder(this);
  }

  GMyShelfData_myShelf_itemsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _externalId = $v.externalId;
      _title = $v.title;
      _authors = $v.authors.toBuilder();
      _readingStatus = $v.readingStatus;
      _note = $v.note;
      _noteUpdatedAt = $v.noteUpdatedAt;
      _addedAt = $v.addedAt;
      _completedAt = $v.completedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyShelfData_myShelf_items other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GMyShelfData_myShelf_items;
  }

  @override
  void update(void Function(GMyShelfData_myShelf_itemsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMyShelfData_myShelf_items build() => _build();

  _$GMyShelfData_myShelf_items _build() {
    _$GMyShelfData_myShelf_items _$result;
    try {
      _$result = _$v ??
          new _$GMyShelfData_myShelf_items._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GMyShelfData_myShelf_items', 'G__typename'),
              id: BuiltValueNullFieldError.checkNotNull(
                  id, r'GMyShelfData_myShelf_items', 'id'),
              externalId: BuiltValueNullFieldError.checkNotNull(
                  externalId, r'GMyShelfData_myShelf_items', 'externalId'),
              title: BuiltValueNullFieldError.checkNotNull(
                  title, r'GMyShelfData_myShelf_items', 'title'),
              authors: authors.build(),
              readingStatus: BuiltValueNullFieldError.checkNotNull(
                  readingStatus,
                  r'GMyShelfData_myShelf_items',
                  'readingStatus'),
              note: note,
              noteUpdatedAt: noteUpdatedAt,
              addedAt: BuiltValueNullFieldError.checkNotNull(
                  addedAt, r'GMyShelfData_myShelf_items', 'addedAt'),
              completedAt: completedAt);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'authors';
        authors.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GMyShelfData_myShelf_items', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
