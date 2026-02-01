// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remove_book_from_list.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GRemoveBookFromListVars> _$gRemoveBookFromListVarsSerializer =
    new _$GRemoveBookFromListVarsSerializer();

class _$GRemoveBookFromListVarsSerializer
    implements StructuredSerializer<GRemoveBookFromListVars> {
  @override
  final Iterable<Type> types = const [
    GRemoveBookFromListVars,
    _$GRemoveBookFromListVars
  ];
  @override
  final String wireName = 'GRemoveBookFromListVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GRemoveBookFromListVars object,
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
  GRemoveBookFromListVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GRemoveBookFromListVarsBuilder();

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

class _$GRemoveBookFromListVars extends GRemoveBookFromListVars {
  @override
  final int listId;
  @override
  final int userBookId;

  factory _$GRemoveBookFromListVars(
          [void Function(GRemoveBookFromListVarsBuilder)? updates]) =>
      (new GRemoveBookFromListVarsBuilder()..update(updates))._build();

  _$GRemoveBookFromListVars._({required this.listId, required this.userBookId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        listId, r'GRemoveBookFromListVars', 'listId');
    BuiltValueNullFieldError.checkNotNull(
        userBookId, r'GRemoveBookFromListVars', 'userBookId');
  }

  @override
  GRemoveBookFromListVars rebuild(
          void Function(GRemoveBookFromListVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRemoveBookFromListVarsBuilder toBuilder() =>
      new GRemoveBookFromListVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRemoveBookFromListVars &&
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
    return (newBuiltValueToStringHelper(r'GRemoveBookFromListVars')
          ..add('listId', listId)
          ..add('userBookId', userBookId))
        .toString();
  }
}

class GRemoveBookFromListVarsBuilder
    implements
        Builder<GRemoveBookFromListVars, GRemoveBookFromListVarsBuilder> {
  _$GRemoveBookFromListVars? _$v;

  int? _listId;
  int? get listId => _$this._listId;
  set listId(int? listId) => _$this._listId = listId;

  int? _userBookId;
  int? get userBookId => _$this._userBookId;
  set userBookId(int? userBookId) => _$this._userBookId = userBookId;

  GRemoveBookFromListVarsBuilder();

  GRemoveBookFromListVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _listId = $v.listId;
      _userBookId = $v.userBookId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRemoveBookFromListVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GRemoveBookFromListVars;
  }

  @override
  void update(void Function(GRemoveBookFromListVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRemoveBookFromListVars build() => _build();

  _$GRemoveBookFromListVars _build() {
    final _$result = _$v ??
        new _$GRemoveBookFromListVars._(
            listId: BuiltValueNullFieldError.checkNotNull(
                listId, r'GRemoveBookFromListVars', 'listId'),
            userBookId: BuiltValueNullFieldError.checkNotNull(
                userBookId, r'GRemoveBookFromListVars', 'userBookId'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
