// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_book_to_list.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GAddBookToListData> _$gAddBookToListDataSerializer =
    _$GAddBookToListDataSerializer();
Serializer<GAddBookToListData_addBookToList>
    _$gAddBookToListDataAddBookToListSerializer =
    _$GAddBookToListData_addBookToListSerializer();

class _$GAddBookToListDataSerializer
    implements StructuredSerializer<GAddBookToListData> {
  @override
  final Iterable<Type> types = const [GAddBookToListData, _$GAddBookToListData];
  @override
  final String wireName = 'GAddBookToListData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAddBookToListData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'addBookToList',
      serializers.serialize(object.addBookToList,
          specifiedType: const FullType(GAddBookToListData_addBookToList)),
    ];

    return result;
  }

  @override
  GAddBookToListData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GAddBookToListDataBuilder();

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
        case 'addBookToList':
          result.addBookToList.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GAddBookToListData_addBookToList))!
              as GAddBookToListData_addBookToList);
          break;
      }
    }

    return result.build();
  }
}

class _$GAddBookToListData_addBookToListSerializer
    implements StructuredSerializer<GAddBookToListData_addBookToList> {
  @override
  final Iterable<Type> types = const [
    GAddBookToListData_addBookToList,
    _$GAddBookToListData_addBookToList
  ];
  @override
  final String wireName = 'GAddBookToListData_addBookToList';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAddBookToListData_addBookToList object,
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
  GAddBookToListData_addBookToList deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GAddBookToListData_addBookToListBuilder();

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

class _$GAddBookToListData extends GAddBookToListData {
  @override
  final String G__typename;
  @override
  final GAddBookToListData_addBookToList addBookToList;

  factory _$GAddBookToListData(
          [void Function(GAddBookToListDataBuilder)? updates]) =>
      (GAddBookToListDataBuilder()..update(updates))._build();

  _$GAddBookToListData._(
      {required this.G__typename, required this.addBookToList})
      : super._();
  @override
  GAddBookToListData rebuild(
          void Function(GAddBookToListDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAddBookToListDataBuilder toBuilder() =>
      GAddBookToListDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAddBookToListData &&
        G__typename == other.G__typename &&
        addBookToList == other.addBookToList;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, addBookToList.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAddBookToListData')
          ..add('G__typename', G__typename)
          ..add('addBookToList', addBookToList))
        .toString();
  }
}

class GAddBookToListDataBuilder
    implements Builder<GAddBookToListData, GAddBookToListDataBuilder> {
  _$GAddBookToListData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GAddBookToListData_addBookToListBuilder? _addBookToList;
  GAddBookToListData_addBookToListBuilder get addBookToList =>
      _$this._addBookToList ??= GAddBookToListData_addBookToListBuilder();
  set addBookToList(GAddBookToListData_addBookToListBuilder? addBookToList) =>
      _$this._addBookToList = addBookToList;

  GAddBookToListDataBuilder() {
    GAddBookToListData._initializeBuilder(this);
  }

  GAddBookToListDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _addBookToList = $v.addBookToList.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAddBookToListData other) {
    _$v = other as _$GAddBookToListData;
  }

  @override
  void update(void Function(GAddBookToListDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAddBookToListData build() => _build();

  _$GAddBookToListData _build() {
    _$GAddBookToListData _$result;
    try {
      _$result = _$v ??
          _$GAddBookToListData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GAddBookToListData', 'G__typename'),
            addBookToList: addBookToList.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'addBookToList';
        addBookToList.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GAddBookToListData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GAddBookToListData_addBookToList
    extends GAddBookToListData_addBookToList {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final int position;
  @override
  final DateTime addedAt;

  factory _$GAddBookToListData_addBookToList(
          [void Function(GAddBookToListData_addBookToListBuilder)? updates]) =>
      (GAddBookToListData_addBookToListBuilder()..update(updates))._build();

  _$GAddBookToListData_addBookToList._(
      {required this.G__typename,
      required this.id,
      required this.position,
      required this.addedAt})
      : super._();
  @override
  GAddBookToListData_addBookToList rebuild(
          void Function(GAddBookToListData_addBookToListBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAddBookToListData_addBookToListBuilder toBuilder() =>
      GAddBookToListData_addBookToListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAddBookToListData_addBookToList &&
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
    return (newBuiltValueToStringHelper(r'GAddBookToListData_addBookToList')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('position', position)
          ..add('addedAt', addedAt))
        .toString();
  }
}

class GAddBookToListData_addBookToListBuilder
    implements
        Builder<GAddBookToListData_addBookToList,
            GAddBookToListData_addBookToListBuilder> {
  _$GAddBookToListData_addBookToList? _$v;

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

  GAddBookToListData_addBookToListBuilder() {
    GAddBookToListData_addBookToList._initializeBuilder(this);
  }

  GAddBookToListData_addBookToListBuilder get _$this {
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
  void replace(GAddBookToListData_addBookToList other) {
    _$v = other as _$GAddBookToListData_addBookToList;
  }

  @override
  void update(void Function(GAddBookToListData_addBookToListBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAddBookToListData_addBookToList build() => _build();

  _$GAddBookToListData_addBookToList _build() {
    final _$result = _$v ??
        _$GAddBookToListData_addBookToList._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GAddBookToListData_addBookToList', 'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GAddBookToListData_addBookToList', 'id'),
          position: BuiltValueNullFieldError.checkNotNull(
              position, r'GAddBookToListData_addBookToList', 'position'),
          addedAt: BuiltValueNullFieldError.checkNotNull(
              addedAt, r'GAddBookToListData_addBookToList', 'addedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
