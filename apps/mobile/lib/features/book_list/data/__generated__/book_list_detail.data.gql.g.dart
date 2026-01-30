// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_list_detail.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GBookListDetailData> _$gBookListDetailDataSerializer =
    _$GBookListDetailDataSerializer();
Serializer<GBookListDetailData_bookListDetail>
    _$gBookListDetailDataBookListDetailSerializer =
    _$GBookListDetailData_bookListDetailSerializer();
Serializer<GBookListDetailData_bookListDetail_items>
    _$gBookListDetailDataBookListDetailItemsSerializer =
    _$GBookListDetailData_bookListDetail_itemsSerializer();
Serializer<GBookListDetailData_bookListDetail_items_userBook>
    _$gBookListDetailDataBookListDetailItemsUserBookSerializer =
    _$GBookListDetailData_bookListDetail_items_userBookSerializer();
Serializer<GBookListDetailData_bookListDetail_stats>
    _$gBookListDetailDataBookListDetailStatsSerializer =
    _$GBookListDetailData_bookListDetail_statsSerializer();

class _$GBookListDetailDataSerializer
    implements StructuredSerializer<GBookListDetailData> {
  @override
  final Iterable<Type> types = const [
    GBookListDetailData,
    _$GBookListDetailData
  ];
  @override
  final String wireName = 'GBookListDetailData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GBookListDetailData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'bookListDetail',
      serializers.serialize(object.bookListDetail,
          specifiedType: const FullType(GBookListDetailData_bookListDetail)),
    ];

    return result;
  }

  @override
  GBookListDetailData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GBookListDetailDataBuilder();

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
        case 'bookListDetail':
          result.bookListDetail.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GBookListDetailData_bookListDetail))!
              as GBookListDetailData_bookListDetail);
          break;
      }
    }

    return result.build();
  }
}

class _$GBookListDetailData_bookListDetailSerializer
    implements StructuredSerializer<GBookListDetailData_bookListDetail> {
  @override
  final Iterable<Type> types = const [
    GBookListDetailData_bookListDetail,
    _$GBookListDetailData_bookListDetail
  ];
  @override
  final String wireName = 'GBookListDetailData_bookListDetail';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GBookListDetailData_bookListDetail object,
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
      'items',
      serializers.serialize(object.items,
          specifiedType: const FullType(BuiltList, const [
            const FullType(GBookListDetailData_bookListDetail_items)
          ])),
      'stats',
      serializers.serialize(object.stats,
          specifiedType:
              const FullType(GBookListDetailData_bookListDetail_stats)),
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
  GBookListDetailData_bookListDetail deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GBookListDetailData_bookListDetailBuilder();

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
        case 'items':
          result.items.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GBookListDetailData_bookListDetail_items)
              ]))! as BuiltList<Object?>);
          break;
        case 'stats':
          result.stats.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GBookListDetailData_bookListDetail_stats))!
              as GBookListDetailData_bookListDetail_stats);
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

class _$GBookListDetailData_bookListDetail_itemsSerializer
    implements StructuredSerializer<GBookListDetailData_bookListDetail_items> {
  @override
  final Iterable<Type> types = const [
    GBookListDetailData_bookListDetail_items,
    _$GBookListDetailData_bookListDetail_items
  ];
  @override
  final String wireName = 'GBookListDetailData_bookListDetail_items';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GBookListDetailData_bookListDetail_items object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'position',
      serializers.serialize(object.position,
          specifiedType: const FullType(int)),
      'addedAt',
      serializers.serialize(object.addedAt,
          specifiedType: const FullType(DateTime)),
    ];
    Object? value;
    value = object.userBook;
    if (value != null) {
      result
        ..add('userBook')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                GBookListDetailData_bookListDetail_items_userBook)));
    }
    return result;
  }

  @override
  GBookListDetailData_bookListDetail_items deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GBookListDetailData_bookListDetail_itemsBuilder();

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
        case 'position':
          result.position = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'addedAt':
          result.addedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'userBook':
          result.userBook.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      GBookListDetailData_bookListDetail_items_userBook))!
              as GBookListDetailData_bookListDetail_items_userBook);
          break;
      }
    }

    return result.build();
  }
}

class _$GBookListDetailData_bookListDetail_items_userBookSerializer
    implements
        StructuredSerializer<
            GBookListDetailData_bookListDetail_items_userBook> {
  @override
  final Iterable<Type> types = const [
    GBookListDetailData_bookListDetail_items_userBook,
    _$GBookListDetailData_bookListDetail_items_userBook
  ];
  @override
  final String wireName = 'GBookListDetailData_bookListDetail_items_userBook';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GBookListDetailData_bookListDetail_items_userBook object,
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
          specifiedType: const FullType(String)),
      'source',
      serializers.serialize(object.source,
          specifiedType: const FullType(String)),
    ];
    Object? value;
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
  GBookListDetailData_bookListDetail_items_userBook deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GBookListDetailData_bookListDetail_items_userBookBuilder();

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
              specifiedType: const FullType(String))! as String;
          break;
        case 'source':
          result.source = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GBookListDetailData_bookListDetail_statsSerializer
    implements StructuredSerializer<GBookListDetailData_bookListDetail_stats> {
  @override
  final Iterable<Type> types = const [
    GBookListDetailData_bookListDetail_stats,
    _$GBookListDetailData_bookListDetail_stats
  ];
  @override
  final String wireName = 'GBookListDetailData_bookListDetail_stats';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GBookListDetailData_bookListDetail_stats object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'bookCount',
      serializers.serialize(object.bookCount,
          specifiedType: const FullType(int)),
      'completedCount',
      serializers.serialize(object.completedCount,
          specifiedType: const FullType(int)),
      'coverImages',
      serializers.serialize(object.coverImages,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  GBookListDetailData_bookListDetail_stats deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GBookListDetailData_bookListDetail_statsBuilder();

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
        case 'bookCount':
          result.bookCount = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'completedCount':
          result.completedCount = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'coverImages':
          result.coverImages.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GBookListDetailData extends GBookListDetailData {
  @override
  final String G__typename;
  @override
  final GBookListDetailData_bookListDetail bookListDetail;

  factory _$GBookListDetailData(
          [void Function(GBookListDetailDataBuilder)? updates]) =>
      (GBookListDetailDataBuilder()..update(updates))._build();

  _$GBookListDetailData._(
      {required this.G__typename, required this.bookListDetail})
      : super._();
  @override
  GBookListDetailData rebuild(
          void Function(GBookListDetailDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GBookListDetailDataBuilder toBuilder() =>
      GBookListDetailDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GBookListDetailData &&
        G__typename == other.G__typename &&
        bookListDetail == other.bookListDetail;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, bookListDetail.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GBookListDetailData')
          ..add('G__typename', G__typename)
          ..add('bookListDetail', bookListDetail))
        .toString();
  }
}

class GBookListDetailDataBuilder
    implements Builder<GBookListDetailData, GBookListDetailDataBuilder> {
  _$GBookListDetailData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GBookListDetailData_bookListDetailBuilder? _bookListDetail;
  GBookListDetailData_bookListDetailBuilder get bookListDetail =>
      _$this._bookListDetail ??= GBookListDetailData_bookListDetailBuilder();
  set bookListDetail(
          GBookListDetailData_bookListDetailBuilder? bookListDetail) =>
      _$this._bookListDetail = bookListDetail;

  GBookListDetailDataBuilder() {
    GBookListDetailData._initializeBuilder(this);
  }

  GBookListDetailDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _bookListDetail = $v.bookListDetail.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GBookListDetailData other) {
    _$v = other as _$GBookListDetailData;
  }

  @override
  void update(void Function(GBookListDetailDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GBookListDetailData build() => _build();

  _$GBookListDetailData _build() {
    _$GBookListDetailData _$result;
    try {
      _$result = _$v ??
          _$GBookListDetailData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GBookListDetailData', 'G__typename'),
            bookListDetail: bookListDetail.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'bookListDetail';
        bookListDetail.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GBookListDetailData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GBookListDetailData_bookListDetail
    extends GBookListDetailData_bookListDetail {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final BuiltList<GBookListDetailData_bookListDetail_items> items;
  @override
  final GBookListDetailData_bookListDetail_stats stats;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  factory _$GBookListDetailData_bookListDetail(
          [void Function(GBookListDetailData_bookListDetailBuilder)?
              updates]) =>
      (GBookListDetailData_bookListDetailBuilder()..update(updates))._build();

  _$GBookListDetailData_bookListDetail._(
      {required this.G__typename,
      required this.id,
      required this.title,
      this.description,
      required this.items,
      required this.stats,
      required this.createdAt,
      required this.updatedAt})
      : super._();
  @override
  GBookListDetailData_bookListDetail rebuild(
          void Function(GBookListDetailData_bookListDetailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GBookListDetailData_bookListDetailBuilder toBuilder() =>
      GBookListDetailData_bookListDetailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GBookListDetailData_bookListDetail &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        items == other.items &&
        stats == other.stats &&
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
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, stats.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GBookListDetailData_bookListDetail')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('items', items)
          ..add('stats', stats)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class GBookListDetailData_bookListDetailBuilder
    implements
        Builder<GBookListDetailData_bookListDetail,
            GBookListDetailData_bookListDetailBuilder> {
  _$GBookListDetailData_bookListDetail? _$v;

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

  ListBuilder<GBookListDetailData_bookListDetail_items>? _items;
  ListBuilder<GBookListDetailData_bookListDetail_items> get items =>
      _$this._items ??= ListBuilder<GBookListDetailData_bookListDetail_items>();
  set items(ListBuilder<GBookListDetailData_bookListDetail_items>? items) =>
      _$this._items = items;

  GBookListDetailData_bookListDetail_statsBuilder? _stats;
  GBookListDetailData_bookListDetail_statsBuilder get stats =>
      _$this._stats ??= GBookListDetailData_bookListDetail_statsBuilder();
  set stats(GBookListDetailData_bookListDetail_statsBuilder? stats) =>
      _$this._stats = stats;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  GBookListDetailData_bookListDetailBuilder() {
    GBookListDetailData_bookListDetail._initializeBuilder(this);
  }

  GBookListDetailData_bookListDetailBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _items = $v.items.toBuilder();
      _stats = $v.stats.toBuilder();
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GBookListDetailData_bookListDetail other) {
    _$v = other as _$GBookListDetailData_bookListDetail;
  }

  @override
  void update(
      void Function(GBookListDetailData_bookListDetailBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GBookListDetailData_bookListDetail build() => _build();

  _$GBookListDetailData_bookListDetail _build() {
    _$GBookListDetailData_bookListDetail _$result;
    try {
      _$result = _$v ??
          _$GBookListDetailData_bookListDetail._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GBookListDetailData_bookListDetail', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GBookListDetailData_bookListDetail', 'id'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GBookListDetailData_bookListDetail', 'title'),
            description: description,
            items: items.build(),
            stats: stats.build(),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'GBookListDetailData_bookListDetail', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'GBookListDetailData_bookListDetail', 'updatedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
        _$failedField = 'stats';
        stats.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GBookListDetailData_bookListDetail', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GBookListDetailData_bookListDetail_items
    extends GBookListDetailData_bookListDetail_items {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final int position;
  @override
  final DateTime addedAt;
  @override
  final GBookListDetailData_bookListDetail_items_userBook? userBook;

  factory _$GBookListDetailData_bookListDetail_items(
          [void Function(GBookListDetailData_bookListDetail_itemsBuilder)?
              updates]) =>
      (GBookListDetailData_bookListDetail_itemsBuilder()..update(updates))
          ._build();

  _$GBookListDetailData_bookListDetail_items._(
      {required this.G__typename,
      required this.id,
      required this.position,
      required this.addedAt,
      this.userBook})
      : super._();
  @override
  GBookListDetailData_bookListDetail_items rebuild(
          void Function(GBookListDetailData_bookListDetail_itemsBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GBookListDetailData_bookListDetail_itemsBuilder toBuilder() =>
      GBookListDetailData_bookListDetail_itemsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GBookListDetailData_bookListDetail_items &&
        G__typename == other.G__typename &&
        id == other.id &&
        position == other.position &&
        addedAt == other.addedAt &&
        userBook == other.userBook;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, position.hashCode);
    _$hash = $jc(_$hash, addedAt.hashCode);
    _$hash = $jc(_$hash, userBook.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GBookListDetailData_bookListDetail_items')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('position', position)
          ..add('addedAt', addedAt)
          ..add('userBook', userBook))
        .toString();
  }
}

class GBookListDetailData_bookListDetail_itemsBuilder
    implements
        Builder<GBookListDetailData_bookListDetail_items,
            GBookListDetailData_bookListDetail_itemsBuilder> {
  _$GBookListDetailData_bookListDetail_items? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _position;
  int? get position => _$this._position;
  set position(int? position) => _$this._position = position;

  DateTime? _addedAt;
  DateTime? get addedAt => _$this._addedAt;
  set addedAt(DateTime? addedAt) => _$this._addedAt = addedAt;

  GBookListDetailData_bookListDetail_items_userBookBuilder? _userBook;
  GBookListDetailData_bookListDetail_items_userBookBuilder get userBook =>
      _$this._userBook ??=
          GBookListDetailData_bookListDetail_items_userBookBuilder();
  set userBook(
          GBookListDetailData_bookListDetail_items_userBookBuilder? userBook) =>
      _$this._userBook = userBook;

  GBookListDetailData_bookListDetail_itemsBuilder() {
    GBookListDetailData_bookListDetail_items._initializeBuilder(this);
  }

  GBookListDetailData_bookListDetail_itemsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _position = $v.position;
      _addedAt = $v.addedAt;
      _userBook = $v.userBook?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GBookListDetailData_bookListDetail_items other) {
    _$v = other as _$GBookListDetailData_bookListDetail_items;
  }

  @override
  void update(
      void Function(GBookListDetailData_bookListDetail_itemsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GBookListDetailData_bookListDetail_items build() => _build();

  _$GBookListDetailData_bookListDetail_items _build() {
    _$GBookListDetailData_bookListDetail_items _$result;
    try {
      _$result = _$v ??
          _$GBookListDetailData_bookListDetail_items._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GBookListDetailData_bookListDetail_items', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GBookListDetailData_bookListDetail_items', 'id'),
            position: BuiltValueNullFieldError.checkNotNull(position,
                r'GBookListDetailData_bookListDetail_items', 'position'),
            addedAt: BuiltValueNullFieldError.checkNotNull(addedAt,
                r'GBookListDetailData_bookListDetail_items', 'addedAt'),
            userBook: _userBook?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'userBook';
        _userBook?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GBookListDetailData_bookListDetail_items',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GBookListDetailData_bookListDetail_items_userBook
    extends GBookListDetailData_bookListDetail_items_userBook {
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
  final String readingStatus;
  @override
  final String source;

  factory _$GBookListDetailData_bookListDetail_items_userBook(
          [void Function(
                  GBookListDetailData_bookListDetail_items_userBookBuilder)?
              updates]) =>
      (GBookListDetailData_bookListDetail_items_userBookBuilder()
            ..update(updates))
          ._build();

  _$GBookListDetailData_bookListDetail_items_userBook._(
      {required this.G__typename,
      required this.id,
      required this.externalId,
      required this.title,
      required this.authors,
      this.coverImageUrl,
      required this.readingStatus,
      required this.source})
      : super._();
  @override
  GBookListDetailData_bookListDetail_items_userBook rebuild(
          void Function(
                  GBookListDetailData_bookListDetail_items_userBookBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GBookListDetailData_bookListDetail_items_userBookBuilder toBuilder() =>
      GBookListDetailData_bookListDetail_items_userBookBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GBookListDetailData_bookListDetail_items_userBook &&
        G__typename == other.G__typename &&
        id == other.id &&
        externalId == other.externalId &&
        title == other.title &&
        authors == other.authors &&
        coverImageUrl == other.coverImageUrl &&
        readingStatus == other.readingStatus &&
        source == other.source;
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
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GBookListDetailData_bookListDetail_items_userBook')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('externalId', externalId)
          ..add('title', title)
          ..add('authors', authors)
          ..add('coverImageUrl', coverImageUrl)
          ..add('readingStatus', readingStatus)
          ..add('source', source))
        .toString();
  }
}

class GBookListDetailData_bookListDetail_items_userBookBuilder
    implements
        Builder<GBookListDetailData_bookListDetail_items_userBook,
            GBookListDetailData_bookListDetail_items_userBookBuilder> {
  _$GBookListDetailData_bookListDetail_items_userBook? _$v;

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

  String? _readingStatus;
  String? get readingStatus => _$this._readingStatus;
  set readingStatus(String? readingStatus) =>
      _$this._readingStatus = readingStatus;

  String? _source;
  String? get source => _$this._source;
  set source(String? source) => _$this._source = source;

  GBookListDetailData_bookListDetail_items_userBookBuilder() {
    GBookListDetailData_bookListDetail_items_userBook._initializeBuilder(this);
  }

  GBookListDetailData_bookListDetail_items_userBookBuilder get _$this {
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
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GBookListDetailData_bookListDetail_items_userBook other) {
    _$v = other as _$GBookListDetailData_bookListDetail_items_userBook;
  }

  @override
  void update(
      void Function(GBookListDetailData_bookListDetail_items_userBookBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GBookListDetailData_bookListDetail_items_userBook build() => _build();

  _$GBookListDetailData_bookListDetail_items_userBook _build() {
    _$GBookListDetailData_bookListDetail_items_userBook _$result;
    try {
      _$result = _$v ??
          _$GBookListDetailData_bookListDetail_items_userBook._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename,
                r'GBookListDetailData_bookListDetail_items_userBook',
                'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GBookListDetailData_bookListDetail_items_userBook', 'id'),
            externalId: BuiltValueNullFieldError.checkNotNull(
                externalId,
                r'GBookListDetailData_bookListDetail_items_userBook',
                'externalId'),
            title: BuiltValueNullFieldError.checkNotNull(title,
                r'GBookListDetailData_bookListDetail_items_userBook', 'title'),
            authors: authors.build(),
            coverImageUrl: coverImageUrl,
            readingStatus: BuiltValueNullFieldError.checkNotNull(
                readingStatus,
                r'GBookListDetailData_bookListDetail_items_userBook',
                'readingStatus'),
            source: BuiltValueNullFieldError.checkNotNull(source,
                r'GBookListDetailData_bookListDetail_items_userBook', 'source'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'authors';
        authors.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GBookListDetailData_bookListDetail_items_userBook',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GBookListDetailData_bookListDetail_stats
    extends GBookListDetailData_bookListDetail_stats {
  @override
  final String G__typename;
  @override
  final int bookCount;
  @override
  final int completedCount;
  @override
  final BuiltList<String> coverImages;

  factory _$GBookListDetailData_bookListDetail_stats(
          [void Function(GBookListDetailData_bookListDetail_statsBuilder)?
              updates]) =>
      (GBookListDetailData_bookListDetail_statsBuilder()..update(updates))
          ._build();

  _$GBookListDetailData_bookListDetail_stats._(
      {required this.G__typename,
      required this.bookCount,
      required this.completedCount,
      required this.coverImages})
      : super._();
  @override
  GBookListDetailData_bookListDetail_stats rebuild(
          void Function(GBookListDetailData_bookListDetail_statsBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GBookListDetailData_bookListDetail_statsBuilder toBuilder() =>
      GBookListDetailData_bookListDetail_statsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GBookListDetailData_bookListDetail_stats &&
        G__typename == other.G__typename &&
        bookCount == other.bookCount &&
        completedCount == other.completedCount &&
        coverImages == other.coverImages;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, bookCount.hashCode);
    _$hash = $jc(_$hash, completedCount.hashCode);
    _$hash = $jc(_$hash, coverImages.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GBookListDetailData_bookListDetail_stats')
          ..add('G__typename', G__typename)
          ..add('bookCount', bookCount)
          ..add('completedCount', completedCount)
          ..add('coverImages', coverImages))
        .toString();
  }
}

class GBookListDetailData_bookListDetail_statsBuilder
    implements
        Builder<GBookListDetailData_bookListDetail_stats,
            GBookListDetailData_bookListDetail_statsBuilder> {
  _$GBookListDetailData_bookListDetail_stats? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _bookCount;
  int? get bookCount => _$this._bookCount;
  set bookCount(int? bookCount) => _$this._bookCount = bookCount;

  int? _completedCount;
  int? get completedCount => _$this._completedCount;
  set completedCount(int? completedCount) =>
      _$this._completedCount = completedCount;

  ListBuilder<String>? _coverImages;
  ListBuilder<String> get coverImages =>
      _$this._coverImages ??= ListBuilder<String>();
  set coverImages(ListBuilder<String>? coverImages) =>
      _$this._coverImages = coverImages;

  GBookListDetailData_bookListDetail_statsBuilder() {
    GBookListDetailData_bookListDetail_stats._initializeBuilder(this);
  }

  GBookListDetailData_bookListDetail_statsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _bookCount = $v.bookCount;
      _completedCount = $v.completedCount;
      _coverImages = $v.coverImages.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GBookListDetailData_bookListDetail_stats other) {
    _$v = other as _$GBookListDetailData_bookListDetail_stats;
  }

  @override
  void update(
      void Function(GBookListDetailData_bookListDetail_statsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GBookListDetailData_bookListDetail_stats build() => _build();

  _$GBookListDetailData_bookListDetail_stats _build() {
    _$GBookListDetailData_bookListDetail_stats _$result;
    try {
      _$result = _$v ??
          _$GBookListDetailData_bookListDetail_stats._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GBookListDetailData_bookListDetail_stats', 'G__typename'),
            bookCount: BuiltValueNullFieldError.checkNotNull(bookCount,
                r'GBookListDetailData_bookListDetail_stats', 'bookCount'),
            completedCount: BuiltValueNullFieldError.checkNotNull(
                completedCount,
                r'GBookListDetailData_bookListDetail_stats',
                'completedCount'),
            coverImages: coverImages.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'coverImages';
        coverImages.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GBookListDetailData_bookListDetail_stats',
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
