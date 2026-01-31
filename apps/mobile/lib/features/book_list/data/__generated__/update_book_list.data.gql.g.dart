// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_book_list.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUpdateBookListData> _$gUpdateBookListDataSerializer =
    new _$GUpdateBookListDataSerializer();
Serializer<GUpdateBookListData_updateBookList>
    _$gUpdateBookListDataUpdateBookListSerializer =
    new _$GUpdateBookListData_updateBookListSerializer();

class _$GUpdateBookListDataSerializer
    implements StructuredSerializer<GUpdateBookListData> {
  @override
  final Iterable<Type> types = const [
    GUpdateBookListData,
    _$GUpdateBookListData
  ];
  @override
  final String wireName = 'GUpdateBookListData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateBookListData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'updateBookList',
      serializers.serialize(object.updateBookList,
          specifiedType: const FullType(GUpdateBookListData_updateBookList)),
    ];

    return result;
  }

  @override
  GUpdateBookListData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateBookListDataBuilder();

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
        case 'updateBookList':
          result.updateBookList.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GUpdateBookListData_updateBookList))!
              as GUpdateBookListData_updateBookList);
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateBookListData_updateBookListSerializer
    implements StructuredSerializer<GUpdateBookListData_updateBookList> {
  @override
  final Iterable<Type> types = const [
    GUpdateBookListData_updateBookList,
    _$GUpdateBookListData_updateBookList
  ];
  @override
  final String wireName = 'GUpdateBookListData_updateBookList';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateBookListData_updateBookList object,
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
  GUpdateBookListData_updateBookList deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateBookListData_updateBookListBuilder();

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

class _$GUpdateBookListData extends GUpdateBookListData {
  @override
  final String G__typename;
  @override
  final GUpdateBookListData_updateBookList updateBookList;

  factory _$GUpdateBookListData(
          [void Function(GUpdateBookListDataBuilder)? updates]) =>
      (new GUpdateBookListDataBuilder()..update(updates))._build();

  _$GUpdateBookListData._(
      {required this.G__typename, required this.updateBookList})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GUpdateBookListData', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        updateBookList, r'GUpdateBookListData', 'updateBookList');
  }

  @override
  GUpdateBookListData rebuild(
          void Function(GUpdateBookListDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateBookListDataBuilder toBuilder() =>
      new GUpdateBookListDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateBookListData &&
        G__typename == other.G__typename &&
        updateBookList == other.updateBookList;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, updateBookList.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateBookListData')
          ..add('G__typename', G__typename)
          ..add('updateBookList', updateBookList))
        .toString();
  }
}

class GUpdateBookListDataBuilder
    implements Builder<GUpdateBookListData, GUpdateBookListDataBuilder> {
  _$GUpdateBookListData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GUpdateBookListData_updateBookListBuilder? _updateBookList;
  GUpdateBookListData_updateBookListBuilder get updateBookList =>
      _$this._updateBookList ??=
          new GUpdateBookListData_updateBookListBuilder();
  set updateBookList(
          GUpdateBookListData_updateBookListBuilder? updateBookList) =>
      _$this._updateBookList = updateBookList;

  GUpdateBookListDataBuilder() {
    GUpdateBookListData._initializeBuilder(this);
  }

  GUpdateBookListDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _updateBookList = $v.updateBookList.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateBookListData other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateBookListData;
  }

  @override
  void update(void Function(GUpdateBookListDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateBookListData build() => _build();

  _$GUpdateBookListData _build() {
    _$GUpdateBookListData _$result;
    try {
      _$result = _$v ??
          new _$GUpdateBookListData._(
              G__typename: BuiltValueNullFieldError.checkNotNull(
                  G__typename, r'GUpdateBookListData', 'G__typename'),
              updateBookList: updateBookList.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'updateBookList';
        updateBookList.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GUpdateBookListData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GUpdateBookListData_updateBookList
    extends GUpdateBookListData_updateBookList {
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

  factory _$GUpdateBookListData_updateBookList(
          [void Function(GUpdateBookListData_updateBookListBuilder)?
              updates]) =>
      (new GUpdateBookListData_updateBookListBuilder()..update(updates))
          ._build();

  _$GUpdateBookListData_updateBookList._(
      {required this.G__typename,
      required this.id,
      required this.title,
      this.description,
      required this.createdAt,
      required this.updatedAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        G__typename, r'GUpdateBookListData_updateBookList', 'G__typename');
    BuiltValueNullFieldError.checkNotNull(
        id, r'GUpdateBookListData_updateBookList', 'id');
    BuiltValueNullFieldError.checkNotNull(
        title, r'GUpdateBookListData_updateBookList', 'title');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'GUpdateBookListData_updateBookList', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, r'GUpdateBookListData_updateBookList', 'updatedAt');
  }

  @override
  GUpdateBookListData_updateBookList rebuild(
          void Function(GUpdateBookListData_updateBookListBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateBookListData_updateBookListBuilder toBuilder() =>
      new GUpdateBookListData_updateBookListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateBookListData_updateBookList &&
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
    return (newBuiltValueToStringHelper(r'GUpdateBookListData_updateBookList')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class GUpdateBookListData_updateBookListBuilder
    implements
        Builder<GUpdateBookListData_updateBookList,
            GUpdateBookListData_updateBookListBuilder> {
  _$GUpdateBookListData_updateBookList? _$v;

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

  GUpdateBookListData_updateBookListBuilder() {
    GUpdateBookListData_updateBookList._initializeBuilder(this);
  }

  GUpdateBookListData_updateBookListBuilder get _$this {
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
  void replace(GUpdateBookListData_updateBookList other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateBookListData_updateBookList;
  }

  @override
  void update(
      void Function(GUpdateBookListData_updateBookListBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateBookListData_updateBookList build() => _build();

  _$GUpdateBookListData_updateBookList _build() {
    final _$result = _$v ??
        new _$GUpdateBookListData_updateBookList._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GUpdateBookListData_updateBookList', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GUpdateBookListData_updateBookList', 'id'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'GUpdateBookListData_updateBookList', 'title'),
            description: description,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'GUpdateBookListData_updateBookList', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'GUpdateBookListData_updateBookList', 'updatedAt'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
