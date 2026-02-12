// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_book_lists.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUserBookListsData> _$gUserBookListsDataSerializer =
    _$GUserBookListsDataSerializer();
Serializer<GUserBookListsData_userBookLists>
    _$gUserBookListsDataUserBookListsSerializer =
    _$GUserBookListsData_userBookListsSerializer();
Serializer<GUserBookListsData_userBookLists_items>
    _$gUserBookListsDataUserBookListsItemsSerializer =
    _$GUserBookListsData_userBookLists_itemsSerializer();

class _$GUserBookListsDataSerializer
    implements StructuredSerializer<GUserBookListsData> {
  @override
  final Iterable<Type> types = const [GUserBookListsData, _$GUserBookListsData];
  @override
  final String wireName = 'GUserBookListsData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUserBookListsData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'userBookLists',
      serializers.serialize(object.userBookLists,
          specifiedType: const FullType(GUserBookListsData_userBookLists)),
    ];

    return result;
  }

  @override
  GUserBookListsData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUserBookListsDataBuilder();

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
        case 'userBookLists':
          result.userBookLists.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GUserBookListsData_userBookLists))!
              as GUserBookListsData_userBookLists);
          break;
      }
    }

    return result.build();
  }
}

class _$GUserBookListsData_userBookListsSerializer
    implements StructuredSerializer<GUserBookListsData_userBookLists> {
  @override
  final Iterable<Type> types = const [
    GUserBookListsData_userBookLists,
    _$GUserBookListsData_userBookLists
  ];
  @override
  final String wireName = 'GUserBookListsData_userBookLists';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUserBookListsData_userBookLists object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'items',
      serializers.serialize(object.items,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GUserBookListsData_userBookLists_items)])),
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
  GUserBookListsData_userBookLists deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUserBookListsData_userBookListsBuilder();

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
                const FullType(GUserBookListsData_userBookLists_items)
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

class _$GUserBookListsData_userBookLists_itemsSerializer
    implements StructuredSerializer<GUserBookListsData_userBookLists_items> {
  @override
  final Iterable<Type> types = const [
    GUserBookListsData_userBookLists_items,
    _$GUserBookListsData_userBookLists_items
  ];
  @override
  final String wireName = 'GUserBookListsData_userBookLists_items';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUserBookListsData_userBookLists_items object,
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
      'bookCount',
      serializers.serialize(object.bookCount,
          specifiedType: const FullType(int)),
      'coverImages',
      serializers.serialize(object.coverImages,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
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
  GUserBookListsData_userBookLists_items deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUserBookListsData_userBookLists_itemsBuilder();

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
        case 'bookCount':
          result.bookCount = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'coverImages':
          result.coverImages.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
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

class _$GUserBookListsData extends GUserBookListsData {
  @override
  final String G__typename;
  @override
  final GUserBookListsData_userBookLists userBookLists;

  factory _$GUserBookListsData(
          [void Function(GUserBookListsDataBuilder)? updates]) =>
      (GUserBookListsDataBuilder()..update(updates))._build();

  _$GUserBookListsData._(
      {required this.G__typename, required this.userBookLists})
      : super._();
  @override
  GUserBookListsData rebuild(
          void Function(GUserBookListsDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUserBookListsDataBuilder toBuilder() =>
      GUserBookListsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUserBookListsData &&
        G__typename == other.G__typename &&
        userBookLists == other.userBookLists;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, userBookLists.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUserBookListsData')
          ..add('G__typename', G__typename)
          ..add('userBookLists', userBookLists))
        .toString();
  }
}

class GUserBookListsDataBuilder
    implements Builder<GUserBookListsData, GUserBookListsDataBuilder> {
  _$GUserBookListsData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GUserBookListsData_userBookListsBuilder? _userBookLists;
  GUserBookListsData_userBookListsBuilder get userBookLists =>
      _$this._userBookLists ??= GUserBookListsData_userBookListsBuilder();
  set userBookLists(GUserBookListsData_userBookListsBuilder? userBookLists) =>
      _$this._userBookLists = userBookLists;

  GUserBookListsDataBuilder() {
    GUserBookListsData._initializeBuilder(this);
  }

  GUserBookListsDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _userBookLists = $v.userBookLists.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUserBookListsData other) {
    _$v = other as _$GUserBookListsData;
  }

  @override
  void update(void Function(GUserBookListsDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUserBookListsData build() => _build();

  _$GUserBookListsData _build() {
    _$GUserBookListsData _$result;
    try {
      _$result = _$v ??
          _$GUserBookListsData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GUserBookListsData', 'G__typename'),
            userBookLists: userBookLists.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'userBookLists';
        userBookLists.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GUserBookListsData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUserBookListsData_userBookLists
    extends GUserBookListsData_userBookLists {
  @override
  final String G__typename;
  @override
  final BuiltList<GUserBookListsData_userBookLists_items> items;
  @override
  final int totalCount;
  @override
  final bool hasMore;

  factory _$GUserBookListsData_userBookLists(
          [void Function(GUserBookListsData_userBookListsBuilder)? updates]) =>
      (GUserBookListsData_userBookListsBuilder()..update(updates))._build();

  _$GUserBookListsData_userBookLists._(
      {required this.G__typename,
      required this.items,
      required this.totalCount,
      required this.hasMore})
      : super._();
  @override
  GUserBookListsData_userBookLists rebuild(
          void Function(GUserBookListsData_userBookListsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUserBookListsData_userBookListsBuilder toBuilder() =>
      GUserBookListsData_userBookListsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUserBookListsData_userBookLists &&
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
    return (newBuiltValueToStringHelper(r'GUserBookListsData_userBookLists')
          ..add('G__typename', G__typename)
          ..add('items', items)
          ..add('totalCount', totalCount)
          ..add('hasMore', hasMore))
        .toString();
  }
}

class GUserBookListsData_userBookListsBuilder
    implements
        Builder<GUserBookListsData_userBookLists,
            GUserBookListsData_userBookListsBuilder> {
  _$GUserBookListsData_userBookLists? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GUserBookListsData_userBookLists_items>? _items;
  ListBuilder<GUserBookListsData_userBookLists_items> get items =>
      _$this._items ??= ListBuilder<GUserBookListsData_userBookLists_items>();
  set items(ListBuilder<GUserBookListsData_userBookLists_items>? items) =>
      _$this._items = items;

  int? _totalCount;
  int? get totalCount => _$this._totalCount;
  set totalCount(int? totalCount) => _$this._totalCount = totalCount;

  bool? _hasMore;
  bool? get hasMore => _$this._hasMore;
  set hasMore(bool? hasMore) => _$this._hasMore = hasMore;

  GUserBookListsData_userBookListsBuilder() {
    GUserBookListsData_userBookLists._initializeBuilder(this);
  }

  GUserBookListsData_userBookListsBuilder get _$this {
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
  void replace(GUserBookListsData_userBookLists other) {
    _$v = other as _$GUserBookListsData_userBookLists;
  }

  @override
  void update(void Function(GUserBookListsData_userBookListsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUserBookListsData_userBookLists build() => _build();

  _$GUserBookListsData_userBookLists _build() {
    _$GUserBookListsData_userBookLists _$result;
    try {
      _$result = _$v ??
          _$GUserBookListsData_userBookLists._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GUserBookListsData_userBookLists', 'G__typename'),
            items: items.build(),
            totalCount: BuiltValueNullFieldError.checkNotNull(
                totalCount, r'GUserBookListsData_userBookLists', 'totalCount'),
            hasMore: BuiltValueNullFieldError.checkNotNull(
                hasMore, r'GUserBookListsData_userBookLists', 'hasMore'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GUserBookListsData_userBookLists', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUserBookListsData_userBookLists_items
    extends GUserBookListsData_userBookLists_items {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final int bookCount;
  @override
  final BuiltList<String> coverImages;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  factory _$GUserBookListsData_userBookLists_items(
          [void Function(GUserBookListsData_userBookLists_itemsBuilder)?
              updates]) =>
      (GUserBookListsData_userBookLists_itemsBuilder()..update(updates))
          ._build();

  _$GUserBookListsData_userBookLists_items._(
      {required this.G__typename,
      required this.id,
      required this.title,
      this.description,
      required this.bookCount,
      required this.coverImages,
      required this.createdAt,
      required this.updatedAt})
      : super._();
  @override
  GUserBookListsData_userBookLists_items rebuild(
          void Function(GUserBookListsData_userBookLists_itemsBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUserBookListsData_userBookLists_itemsBuilder toBuilder() =>
      GUserBookListsData_userBookLists_itemsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUserBookListsData_userBookLists_items &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        bookCount == other.bookCount &&
        coverImages == other.coverImages &&
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
    _$hash = $jc(_$hash, bookCount.hashCode);
    _$hash = $jc(_$hash, coverImages.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GUserBookListsData_userBookLists_items')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('bookCount', bookCount)
          ..add('coverImages', coverImages)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class GUserBookListsData_userBookLists_itemsBuilder
    implements
        Builder<GUserBookListsData_userBookLists_items,
            GUserBookListsData_userBookLists_itemsBuilder> {
  _$GUserBookListsData_userBookLists_items? _$v;

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

  int? _bookCount;
  int? get bookCount => _$this._bookCount;
  set bookCount(int? bookCount) => _$this._bookCount = bookCount;

  ListBuilder<String>? _coverImages;
  ListBuilder<String> get coverImages =>
      _$this._coverImages ??= ListBuilder<String>();
  set coverImages(ListBuilder<String>? coverImages) =>
      _$this._coverImages = coverImages;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  GUserBookListsData_userBookLists_itemsBuilder() {
    GUserBookListsData_userBookLists_items._initializeBuilder(this);
  }

  GUserBookListsData_userBookLists_itemsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _bookCount = $v.bookCount;
      _coverImages = $v.coverImages.toBuilder();
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUserBookListsData_userBookLists_items other) {
    _$v = other as _$GUserBookListsData_userBookLists_items;
  }

  @override
  void update(
      void Function(GUserBookListsData_userBookLists_itemsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUserBookListsData_userBookLists_items build() => _build();

  _$GUserBookListsData_userBookLists_items _build() {
    _$GUserBookListsData_userBookLists_items _$result;
    try {
      _$result = _$v ??
          _$GUserBookListsData_userBookLists_items._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GUserBookListsData_userBookLists_items', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GUserBookListsData_userBookLists_items', 'id'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GUserBookListsData_userBookLists_items', 'title'),
            description: description,
            bookCount: BuiltValueNullFieldError.checkNotNull(bookCount,
                r'GUserBookListsData_userBookLists_items', 'bookCount'),
            coverImages: coverImages.build(),
            createdAt: BuiltValueNullFieldError.checkNotNull(createdAt,
                r'GUserBookListsData_userBookLists_items', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(updatedAt,
                r'GUserBookListsData_userBookLists_items', 'updatedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'coverImages';
        coverImages.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GUserBookListsData_userBookLists_items',
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
