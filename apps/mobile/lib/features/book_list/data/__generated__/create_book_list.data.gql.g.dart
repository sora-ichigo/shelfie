// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_book_list.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GCreateBookListData> _$gCreateBookListDataSerializer =
    _$GCreateBookListDataSerializer();
Serializer<GCreateBookListData_createBookList>
    _$gCreateBookListDataCreateBookListSerializer =
    _$GCreateBookListData_createBookListSerializer();

class _$GCreateBookListDataSerializer
    implements StructuredSerializer<GCreateBookListData> {
  @override
  final Iterable<Type> types = const [
    GCreateBookListData,
    _$GCreateBookListData
  ];
  @override
  final String wireName = 'GCreateBookListData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateBookListData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'createBookList',
      serializers.serialize(object.createBookList,
          specifiedType: const FullType(GCreateBookListData_createBookList)),
    ];

    return result;
  }

  @override
  GCreateBookListData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCreateBookListDataBuilder();

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
        case 'createBookList':
          result.createBookList.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GCreateBookListData_createBookList))!
              as GCreateBookListData_createBookList);
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateBookListData_createBookListSerializer
    implements StructuredSerializer<GCreateBookListData_createBookList> {
  @override
  final Iterable<Type> types = const [
    GCreateBookListData_createBookList,
    _$GCreateBookListData_createBookList
  ];
  @override
  final String wireName = 'GCreateBookListData_createBookList';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateBookListData_createBookList object,
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
  GCreateBookListData_createBookList deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCreateBookListData_createBookListBuilder();

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

class _$GCreateBookListData extends GCreateBookListData {
  @override
  final String G__typename;
  @override
  final GCreateBookListData_createBookList createBookList;

  factory _$GCreateBookListData(
          [void Function(GCreateBookListDataBuilder)? updates]) =>
      (GCreateBookListDataBuilder()..update(updates))._build();

  _$GCreateBookListData._(
      {required this.G__typename, required this.createBookList})
      : super._();
  @override
  GCreateBookListData rebuild(
          void Function(GCreateBookListDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateBookListDataBuilder toBuilder() =>
      GCreateBookListDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateBookListData &&
        G__typename == other.G__typename &&
        createBookList == other.createBookList;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, createBookList.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateBookListData')
          ..add('G__typename', G__typename)
          ..add('createBookList', createBookList))
        .toString();
  }
}

class GCreateBookListDataBuilder
    implements Builder<GCreateBookListData, GCreateBookListDataBuilder> {
  _$GCreateBookListData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GCreateBookListData_createBookListBuilder? _createBookList;
  GCreateBookListData_createBookListBuilder get createBookList =>
      _$this._createBookList ??= GCreateBookListData_createBookListBuilder();
  set createBookList(
          GCreateBookListData_createBookListBuilder? createBookList) =>
      _$this._createBookList = createBookList;

  GCreateBookListDataBuilder() {
    GCreateBookListData._initializeBuilder(this);
  }

  GCreateBookListDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _createBookList = $v.createBookList.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateBookListData other) {
    _$v = other as _$GCreateBookListData;
  }

  @override
  void update(void Function(GCreateBookListDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateBookListData build() => _build();

  _$GCreateBookListData _build() {
    _$GCreateBookListData _$result;
    try {
      _$result = _$v ??
          _$GCreateBookListData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GCreateBookListData', 'G__typename'),
            createBookList: createBookList.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createBookList';
        createBookList.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GCreateBookListData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GCreateBookListData_createBookList
    extends GCreateBookListData_createBookList {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  factory _$GCreateBookListData_createBookList(
          [void Function(GCreateBookListData_createBookListBuilder)?
              updates]) =>
      (GCreateBookListData_createBookListBuilder()..update(updates))._build();

  _$GCreateBookListData_createBookList._(
      {required this.G__typename,
      required this.id,
      required this.title,
      this.description,
      required this.createdAt,
      required this.updatedAt})
      : super._();
  @override
  GCreateBookListData_createBookList rebuild(
          void Function(GCreateBookListData_createBookListBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateBookListData_createBookListBuilder toBuilder() =>
      GCreateBookListData_createBookListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateBookListData_createBookList &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
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
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateBookListData_createBookList')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class GCreateBookListData_createBookListBuilder
    implements
        Builder<GCreateBookListData_createBookList,
            GCreateBookListData_createBookListBuilder> {
  _$GCreateBookListData_createBookList? _$v;

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

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  GCreateBookListData_createBookListBuilder() {
    GCreateBookListData_createBookList._initializeBuilder(this);
  }

  GCreateBookListData_createBookListBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateBookListData_createBookList other) {
    _$v = other as _$GCreateBookListData_createBookList;
  }

  @override
  void update(
      void Function(GCreateBookListData_createBookListBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateBookListData_createBookList build() => _build();

  _$GCreateBookListData_createBookList _build() {
    final _$result = _$v ??
        _$GCreateBookListData_createBookList._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GCreateBookListData_createBookList', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GCreateBookListData_createBookList', 'id'),
          title: BuiltValueNullFieldError.checkNotNull(
              title, r'GCreateBookListData_createBookList', 'title'),
          description: description,
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'GCreateBookListData_createBookList', 'createdAt'),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
              updatedAt, r'GCreateBookListData_createBookList', 'updatedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
