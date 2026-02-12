// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_shelf.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUserShelfData> _$gUserShelfDataSerializer =
    _$GUserShelfDataSerializer();
Serializer<GUserShelfData_userShelf> _$gUserShelfDataUserShelfSerializer =
    _$GUserShelfData_userShelfSerializer();
Serializer<GUserShelfData_userShelf_items>
    _$gUserShelfDataUserShelfItemsSerializer =
    _$GUserShelfData_userShelf_itemsSerializer();

class _$GUserShelfDataSerializer
    implements StructuredSerializer<GUserShelfData> {
  @override
  final Iterable<Type> types = const [GUserShelfData, _$GUserShelfData];
  @override
  final String wireName = 'GUserShelfData';

  @override
  Iterable<Object?> serialize(Serializers serializers, GUserShelfData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'userShelf',
      serializers.serialize(object.userShelf,
          specifiedType: const FullType(GUserShelfData_userShelf)),
    ];

    return result;
  }

  @override
  GUserShelfData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUserShelfDataBuilder();

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
        case 'userShelf':
          result.userShelf.replace(serializers.deserialize(value,
                  specifiedType: const FullType(GUserShelfData_userShelf))!
              as GUserShelfData_userShelf);
          break;
      }
    }

    return result.build();
  }
}

class _$GUserShelfData_userShelfSerializer
    implements StructuredSerializer<GUserShelfData_userShelf> {
  @override
  final Iterable<Type> types = const [
    GUserShelfData_userShelf,
    _$GUserShelfData_userShelf
  ];
  @override
  final String wireName = 'GUserShelfData_userShelf';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUserShelfData_userShelf object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'items',
      serializers.serialize(object.items,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GUserShelfData_userShelf_items)])),
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
  GUserShelfData_userShelf deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUserShelfData_userShelfBuilder();

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
                const FullType(GUserShelfData_userShelf_items)
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

class _$GUserShelfData_userShelf_itemsSerializer
    implements StructuredSerializer<GUserShelfData_userShelf_items> {
  @override
  final Iterable<Type> types = const [
    GUserShelfData_userShelf_items,
    _$GUserShelfData_userShelf_items
  ];
  @override
  final String wireName = 'GUserShelfData_userShelf_items';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUserShelfData_userShelf_items object,
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
  GUserShelfData_userShelf_items deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUserShelfData_userShelf_itemsBuilder();

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

class _$GUserShelfData extends GUserShelfData {
  @override
  final String G__typename;
  @override
  final GUserShelfData_userShelf userShelf;

  factory _$GUserShelfData([void Function(GUserShelfDataBuilder)? updates]) =>
      (GUserShelfDataBuilder()..update(updates))._build();

  _$GUserShelfData._({required this.G__typename, required this.userShelf})
      : super._();
  @override
  GUserShelfData rebuild(void Function(GUserShelfDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUserShelfDataBuilder toBuilder() => GUserShelfDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUserShelfData &&
        G__typename == other.G__typename &&
        userShelf == other.userShelf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, userShelf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUserShelfData')
          ..add('G__typename', G__typename)
          ..add('userShelf', userShelf))
        .toString();
  }
}

class GUserShelfDataBuilder
    implements Builder<GUserShelfData, GUserShelfDataBuilder> {
  _$GUserShelfData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GUserShelfData_userShelfBuilder? _userShelf;
  GUserShelfData_userShelfBuilder get userShelf =>
      _$this._userShelf ??= GUserShelfData_userShelfBuilder();
  set userShelf(GUserShelfData_userShelfBuilder? userShelf) =>
      _$this._userShelf = userShelf;

  GUserShelfDataBuilder() {
    GUserShelfData._initializeBuilder(this);
  }

  GUserShelfDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _userShelf = $v.userShelf.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUserShelfData other) {
    _$v = other as _$GUserShelfData;
  }

  @override
  void update(void Function(GUserShelfDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUserShelfData build() => _build();

  _$GUserShelfData _build() {
    _$GUserShelfData _$result;
    try {
      _$result = _$v ??
          _$GUserShelfData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GUserShelfData', 'G__typename'),
            userShelf: userShelf.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'userShelf';
        userShelf.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GUserShelfData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUserShelfData_userShelf extends GUserShelfData_userShelf {
  @override
  final String G__typename;
  @override
  final BuiltList<GUserShelfData_userShelf_items> items;
  @override
  final int totalCount;
  @override
  final bool hasMore;

  factory _$GUserShelfData_userShelf(
          [void Function(GUserShelfData_userShelfBuilder)? updates]) =>
      (GUserShelfData_userShelfBuilder()..update(updates))._build();

  _$GUserShelfData_userShelf._(
      {required this.G__typename,
      required this.items,
      required this.totalCount,
      required this.hasMore})
      : super._();
  @override
  GUserShelfData_userShelf rebuild(
          void Function(GUserShelfData_userShelfBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUserShelfData_userShelfBuilder toBuilder() =>
      GUserShelfData_userShelfBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUserShelfData_userShelf &&
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
    return (newBuiltValueToStringHelper(r'GUserShelfData_userShelf')
          ..add('G__typename', G__typename)
          ..add('items', items)
          ..add('totalCount', totalCount)
          ..add('hasMore', hasMore))
        .toString();
  }
}

class GUserShelfData_userShelfBuilder
    implements
        Builder<GUserShelfData_userShelf, GUserShelfData_userShelfBuilder> {
  _$GUserShelfData_userShelf? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GUserShelfData_userShelf_items>? _items;
  ListBuilder<GUserShelfData_userShelf_items> get items =>
      _$this._items ??= ListBuilder<GUserShelfData_userShelf_items>();
  set items(ListBuilder<GUserShelfData_userShelf_items>? items) =>
      _$this._items = items;

  int? _totalCount;
  int? get totalCount => _$this._totalCount;
  set totalCount(int? totalCount) => _$this._totalCount = totalCount;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(bool? hasMore) => _$this._hasMore = hasMore;

  GUserShelfData_userShelfBuilder() {
    GUserShelfData_userShelf._initializeBuilder(this);
  }

  GUserShelfData_userShelfBuilder get _$this {
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
  void replace(GUserShelfData_userShelf other) {
    _$v = other as _$GUserShelfData_userShelf;
  }

  @override
  void update(void Function(GUserShelfData_userShelfBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUserShelfData_userShelf build() => _build();

  _$GUserShelfData_userShelf _build() {
    _$GUserShelfData_userShelf _$result;
    try {
      _$result = _$v ??
          _$GUserShelfData_userShelf._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GUserShelfData_userShelf', 'G__typename'),
            items: items.build(),
            totalCount: BuiltValueNullFieldError.checkNotNull(
                totalCount, r'GUserShelfData_userShelf', 'totalCount'),
            hasMore: BuiltValueNullFieldError.checkNotNull(
                hasMore, r'GUserShelfData_userShelf', 'hasMore'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GUserShelfData_userShelf', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUserShelfData_userShelf_items extends GUserShelfData_userShelf_items {
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

  factory _$GUserShelfData_userShelf_items(
          [void Function(GUserShelfData_userShelf_itemsBuilder)? updates]) =>
      (GUserShelfData_userShelf_itemsBuilder()..update(updates))._build();

  _$GUserShelfData_userShelf_items._(
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
      : super._();
  @override
  GUserShelfData_userShelf_items rebuild(
          void Function(GUserShelfData_userShelf_itemsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUserShelfData_userShelf_itemsBuilder toBuilder() =>
      GUserShelfData_userShelf_itemsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUserShelfData_userShelf_items &&
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
    return (newBuiltValueToStringHelper(r'GUserShelfData_userShelf_items')
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

class GUserShelfData_userShelf_itemsBuilder
    implements
        Builder<GUserShelfData_userShelf_items,
            GUserShelfData_userShelf_itemsBuilder> {
  _$GUserShelfData_userShelf_items? _$v;

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

  GUserShelfData_userShelf_itemsBuilder() {
    GUserShelfData_userShelf_items._initializeBuilder(this);
  }

  GUserShelfData_userShelf_itemsBuilder get _$this {
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
  void replace(GUserShelfData_userShelf_items other) {
    _$v = other as _$GUserShelfData_userShelf_items;
  }

  @override
  void update(void Function(GUserShelfData_userShelf_itemsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUserShelfData_userShelf_items build() => _build();

  _$GUserShelfData_userShelf_items _build() {
    _$GUserShelfData_userShelf_items _$result;
    try {
      _$result = _$v ??
          _$GUserShelfData_userShelf_items._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GUserShelfData_userShelf_items', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GUserShelfData_userShelf_items', 'id'),
            externalId: BuiltValueNullFieldError.checkNotNull(
                externalId, r'GUserShelfData_userShelf_items', 'externalId'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GUserShelfData_userShelf_items', 'title'),
            authors: authors.build(),
            coverImageUrl: coverImageUrl,
            readingStatus: BuiltValueNullFieldError.checkNotNull(readingStatus,
                r'GUserShelfData_userShelf_items', 'readingStatus'),
            source: BuiltValueNullFieldError.checkNotNull(
                source, r'GUserShelfData_userShelf_items', 'source'),
            addedAt: BuiltValueNullFieldError.checkNotNull(
                addedAt, r'GUserShelfData_userShelf_items', 'addedAt'),
            startedAt: startedAt,
            completedAt: completedAt,
            rating: rating,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'authors';
        authors.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GUserShelfData_userShelf_items', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
