// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_ids_containing_user_book.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GListIdsContainingUserBookVars>
    _$gListIdsContainingUserBookVarsSerializer =
    _$GListIdsContainingUserBookVarsSerializer();

class _$GListIdsContainingUserBookVarsSerializer
    implements StructuredSerializer<GListIdsContainingUserBookVars> {
  @override
  final Iterable<Type> types = const [
    GListIdsContainingUserBookVars,
    _$GListIdsContainingUserBookVars
  ];
  @override
  final String wireName = 'GListIdsContainingUserBookVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GListIdsContainingUserBookVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userBookId',
      serializers.serialize(object.userBookId,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GListIdsContainingUserBookVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GListIdsContainingUserBookVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'userBookId':
          result.userBookId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GListIdsContainingUserBookVars extends GListIdsContainingUserBookVars {
  @override
  final int userBookId;

  factory _$GListIdsContainingUserBookVars(
          [void Function(GListIdsContainingUserBookVarsBuilder)? updates]) =>
      (GListIdsContainingUserBookVarsBuilder()..update(updates))._build();

  _$GListIdsContainingUserBookVars._({required this.userBookId}) : super._();
  @override
  GListIdsContainingUserBookVars rebuild(
          void Function(GListIdsContainingUserBookVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GListIdsContainingUserBookVarsBuilder toBuilder() =>
      GListIdsContainingUserBookVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GListIdsContainingUserBookVars &&
        userBookId == other.userBookId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userBookId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GListIdsContainingUserBookVars')
          ..add('userBookId', userBookId))
        .toString();
  }
}

class GListIdsContainingUserBookVarsBuilder
    implements
        Builder<GListIdsContainingUserBookVars,
            GListIdsContainingUserBookVarsBuilder> {
  _$GListIdsContainingUserBookVars? _$v;

  int? _userBookId;
  int? get userBookId => _$this._userBookId;
  set userBookId(int? userBookId) => _$this._userBookId = userBookId;

  GListIdsContainingUserBookVarsBuilder();

  GListIdsContainingUserBookVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userBookId = $v.userBookId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GListIdsContainingUserBookVars other) {
    _$v = other as _$GListIdsContainingUserBookVars;
  }

  @override
  void update(void Function(GListIdsContainingUserBookVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GListIdsContainingUserBookVars build() => _build();

  _$GListIdsContainingUserBookVars _build() {
    final _$result = _$v ??
        _$GListIdsContainingUserBookVars._(
          userBookId: BuiltValueNullFieldError.checkNotNull(
              userBookId, r'GListIdsContainingUserBookVars', 'userBookId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
