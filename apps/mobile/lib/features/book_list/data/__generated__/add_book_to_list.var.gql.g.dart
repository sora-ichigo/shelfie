// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_book_to_list.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GAddBookToListVars> _$gAddBookToListVarsSerializer =
    new _$GAddBookToListVarsSerializer();

class _$GAddBookToListVarsSerializer
    implements StructuredSerializer<GAddBookToListVars> {
  @override
  final Iterable<Type> types = const [GAddBookToListVars, _$GAddBookToListVars];
  @override
  final String wireName = 'GAddBookToListVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GAddBookToListVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'listId',
      serializers.serialize(object.listId, specifiedType: const FullType(int)),
      'userBookId',
      serializers.serialize(object.userBookId,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GAddBookToListVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GAddBookToListVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'listId':
          result.listId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'userBookId':
          result.userBookId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GAddBookToListVars extends GAddBookToListVars {
  @override
  final int listId;
  @override
  final int userBookId;

  factory _$GAddBookToListVars(
          [void Function(GAddBookToListVarsBuilder)? updates]) =>
      (new GAddBookToListVarsBuilder()..update(updates))._build();

  _$GAddBookToListVars._({required this.listId, required this.userBookId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        listId, r'GAddBookToListVars', 'listId');
    BuiltValueNullFieldError.checkNotNull(
        userBookId, r'GAddBookToListVars', 'userBookId');
  }

  @override
  GAddBookToListVars rebuild(
          void Function(GAddBookToListVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GAddBookToListVarsBuilder toBuilder() =>
      new GAddBookToListVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GAddBookToListVars &&
        listId == other.listId &&
        userBookId == other.userBookId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, listId.hashCode);
    _$hash = $jc(_$hash, userBookId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GAddBookToListVars')
          ..add('listId', listId)
          ..add('userBookId', userBookId))
        .toString();
  }
}

class GAddBookToListVarsBuilder
    implements Builder<GAddBookToListVars, GAddBookToListVarsBuilder> {
  _$GAddBookToListVars? _$v;

  int? _listId;
  int? get listId => _$this._listId;
  set listId(int? listId) => _$this._listId = listId;

  int? _userBookId;
  int? get userBookId => _$this._userBookId;
  set userBookId(int? userBookId) => _$this._userBookId = userBookId;

  GAddBookToListVarsBuilder();

  GAddBookToListVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _listId = $v.listId;
      _userBookId = $v.userBookId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GAddBookToListVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GAddBookToListVars;
  }

  @override
  void update(void Function(GAddBookToListVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GAddBookToListVars build() => _build();

  _$GAddBookToListVars _build() {
    final _$result = _$v ??
        new _$GAddBookToListVars._(
            listId: BuiltValueNullFieldError.checkNotNull(
                listId, r'GAddBookToListVars', 'listId'),
            userBookId: BuiltValueNullFieldError.checkNotNull(
                userBookId, r'GAddBookToListVars', 'userBookId'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
