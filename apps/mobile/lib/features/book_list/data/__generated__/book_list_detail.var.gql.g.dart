// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_list_detail.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GBookListDetailVars> _$gBookListDetailVarsSerializer =
    _$GBookListDetailVarsSerializer();

class _$GBookListDetailVarsSerializer
    implements StructuredSerializer<GBookListDetailVars> {
  @override
  final Iterable<Type> types = const [
    GBookListDetailVars,
    _$GBookListDetailVars
  ];
  @override
  final String wireName = 'GBookListDetailVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GBookListDetailVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'listId',
      serializers.serialize(object.listId, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GBookListDetailVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GBookListDetailVarsBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GBookListDetailVars extends GBookListDetailVars {
  @override
  final int listId;

  factory _$GBookListDetailVars(
          [void Function(GBookListDetailVarsBuilder)? updates]) =>
      (GBookListDetailVarsBuilder()..update(updates))._build();

  _$GBookListDetailVars._({required this.listId}) : super._();
  @override
  GBookListDetailVars rebuild(
          void Function(GBookListDetailVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GBookListDetailVarsBuilder toBuilder() =>
      GBookListDetailVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GBookListDetailVars && listId == other.listId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, listId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GBookListDetailVars')
          ..add('listId', listId))
        .toString();
  }
}

class GBookListDetailVarsBuilder
    implements Builder<GBookListDetailVars, GBookListDetailVarsBuilder> {
  _$GBookListDetailVars? _$v;

  int? _listId;
  int? get listId => _$this._listId;
  set listId(int? listId) => _$this._listId = listId;

  GBookListDetailVarsBuilder();

  GBookListDetailVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _listId = $v.listId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GBookListDetailVars other) {
    _$v = other as _$GBookListDetailVars;
  }

  @override
  void update(void Function(GBookListDetailVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GBookListDetailVars build() => _build();

  _$GBookListDetailVars _build() {
    final _$result = _$v ??
        _$GBookListDetailVars._(
          listId: BuiltValueNullFieldError.checkNotNull(
              listId, r'GBookListDetailVars', 'listId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
