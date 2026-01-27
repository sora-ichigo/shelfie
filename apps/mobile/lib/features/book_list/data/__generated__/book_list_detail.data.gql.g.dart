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

  factory _$GBookListDetailData_bookListDetail_items(
          [void Function(GBookListDetailData_bookListDetail_itemsBuilder)?
              updates]) =>
      (GBookListDetailData_bookListDetail_itemsBuilder()..update(updates))
          ._build();

  _$GBookListDetailData_bookListDetail_items._(
      {required this.G__typename,
      required this.id,
      required this.position,
      required this.addedAt})
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
        addedAt == other.addedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, position.hashCode);
    _$hash = $jc(_$hash, addedAt.hashCode);
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
          ..add('addedAt', addedAt))
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
    final _$result = _$v ??
        _$GBookListDetailData_bookListDetail_items._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GBookListDetailData_bookListDetail_items', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GBookListDetailData_bookListDetail_items', 'id'),
          position: BuiltValueNullFieldError.checkNotNull(position,
              r'GBookListDetailData_bookListDetail_items', 'position'),
          addedAt: BuiltValueNullFieldError.checkNotNull(
              addedAt, r'GBookListDetailData_bookListDetail_items', 'addedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
