// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_thoughts.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUpdateThoughtsVars> _$gUpdateThoughtsVarsSerializer =
    _$GUpdateThoughtsVarsSerializer();

class _$GUpdateThoughtsVarsSerializer
    implements StructuredSerializer<GUpdateThoughtsVars> {
  @override
  final Iterable<Type> types = const [
    GUpdateThoughtsVars,
    _$GUpdateThoughtsVars
  ];
  @override
  final String wireName = 'GUpdateThoughtsVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateThoughtsVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userBookId',
      serializers.serialize(object.userBookId,
          specifiedType: const FullType(int)),
      'thoughts',
      serializers.serialize(object.thoughts,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GUpdateThoughtsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUpdateThoughtsVarsBuilder();

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
        case 'thoughts':
          result.thoughts = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateThoughtsVars extends GUpdateThoughtsVars {
  @override
  final int userBookId;
  @override
  final String thoughts;

  factory _$GUpdateThoughtsVars(
          [void Function(GUpdateThoughtsVarsBuilder)? updates]) =>
      (GUpdateThoughtsVarsBuilder()..update(updates))._build();

  _$GUpdateThoughtsVars._({required this.userBookId, required this.thoughts})
      : super._();
  @override
  GUpdateThoughtsVars rebuild(
          void Function(GUpdateThoughtsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateThoughtsVarsBuilder toBuilder() =>
      GUpdateThoughtsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateThoughtsVars &&
        userBookId == other.userBookId &&
        thoughts == other.thoughts;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userBookId.hashCode);
    _$hash = $jc(_$hash, thoughts.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateThoughtsVars')
          ..add('userBookId', userBookId)
          ..add('thoughts', thoughts))
        .toString();
  }
}

class GUpdateThoughtsVarsBuilder
    implements Builder<GUpdateThoughtsVars, GUpdateThoughtsVarsBuilder> {
  _$GUpdateThoughtsVars? _$v;

  int? _userBookId;
  int? get userBookId => _$this._userBookId;
  set userBookId(int? userBookId) => _$this._userBookId = userBookId;

  String? _thoughts;
  String? get thoughts => _$this._thoughts;
  set thoughts(String? thoughts) => _$this._thoughts = thoughts;

  GUpdateThoughtsVarsBuilder();

  GUpdateThoughtsVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userBookId = $v.userBookId;
      _thoughts = $v.thoughts;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateThoughtsVars other) {
    _$v = other as _$GUpdateThoughtsVars;
  }

  @override
  void update(void Function(GUpdateThoughtsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateThoughtsVars build() => _build();

  _$GUpdateThoughtsVars _build() {
    final _$result = _$v ??
        _$GUpdateThoughtsVars._(
          userBookId: BuiltValueNullFieldError.checkNotNull(
              userBookId, r'GUpdateThoughtsVars', 'userBookId'),
          thoughts: BuiltValueNullFieldError.checkNotNull(
              thoughts, r'GUpdateThoughtsVars', 'thoughts'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
