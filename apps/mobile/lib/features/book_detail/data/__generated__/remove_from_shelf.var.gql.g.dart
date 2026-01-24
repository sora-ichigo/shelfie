// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remove_from_shelf.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GRemoveFromShelfVars> _$gRemoveFromShelfVarsSerializer =
    new _$GRemoveFromShelfVarsSerializer();

class _$GRemoveFromShelfVarsSerializer
    implements StructuredSerializer<GRemoveFromShelfVars> {
  @override
  final Iterable<Type> types = const [
    GRemoveFromShelfVars,
    _$GRemoveFromShelfVars
  ];
  @override
  final String wireName = 'GRemoveFromShelfVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GRemoveFromShelfVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userBookId',
      serializers.serialize(object.userBookId,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GRemoveFromShelfVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GRemoveFromShelfVarsBuilder();

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

class _$GRemoveFromShelfVars extends GRemoveFromShelfVars {
  @override
  final int userBookId;

  factory _$GRemoveFromShelfVars(
          [void Function(GRemoveFromShelfVarsBuilder)? updates]) =>
      (new GRemoveFromShelfVarsBuilder()..update(updates))._build();

  _$GRemoveFromShelfVars._({required this.userBookId}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        userBookId, r'GRemoveFromShelfVars', 'userBookId');
  }

  @override
  GRemoveFromShelfVars rebuild(
          void Function(GRemoveFromShelfVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRemoveFromShelfVarsBuilder toBuilder() =>
      new GRemoveFromShelfVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRemoveFromShelfVars && userBookId == other.userBookId;
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
    return (newBuiltValueToStringHelper(r'GRemoveFromShelfVars')
          ..add('userBookId', userBookId))
        .toString();
  }
}

class GRemoveFromShelfVarsBuilder
    implements Builder<GRemoveFromShelfVars, GRemoveFromShelfVarsBuilder> {
  _$GRemoveFromShelfVars? _$v;

  int? _userBookId;
  int? get userBookId => _$this._userBookId;
  set userBookId(int? userBookId) => _$this._userBookId = userBookId;

  GRemoveFromShelfVarsBuilder();

  GRemoveFromShelfVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userBookId = $v.userBookId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRemoveFromShelfVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GRemoveFromShelfVars;
  }

  @override
  void update(void Function(GRemoveFromShelfVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRemoveFromShelfVars build() => _build();

  _$GRemoveFromShelfVars _build() {
    final _$result = _$v ??
        new _$GRemoveFromShelfVars._(
            userBookId: BuiltValueNullFieldError.checkNotNull(
                userBookId, r'GRemoveFromShelfVars', 'userBookId'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
