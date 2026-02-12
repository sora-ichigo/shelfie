// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_shelf.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUserShelfVars> _$gUserShelfVarsSerializer =
    _$GUserShelfVarsSerializer();

class _$GUserShelfVarsSerializer
    implements StructuredSerializer<GUserShelfVars> {
  @override
  final Iterable<Type> types = const [GUserShelfVars, _$GUserShelfVars];
  @override
  final String wireName = 'GUserShelfVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GUserShelfVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userId',
      serializers.serialize(object.userId, specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.input;
    if (value != null) {
      result
        ..add('input')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(_i1.GMyShelfInput)));
    }
    return result;
  }

  @override
  GUserShelfVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUserShelfVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'input':
          result.input.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i1.GMyShelfInput))!
              as _i1.GMyShelfInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GUserShelfVars extends GUserShelfVars {
  @override
  final int userId;
  @override
  final _i1.GMyShelfInput? input;

  factory _$GUserShelfVars([void Function(GUserShelfVarsBuilder)? updates]) =>
      (GUserShelfVarsBuilder()..update(updates))._build();

  _$GUserShelfVars._({required this.userId, this.input}) : super._();
  @override
  GUserShelfVars rebuild(void Function(GUserShelfVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUserShelfVarsBuilder toBuilder() => GUserShelfVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUserShelfVars &&
        userId == other.userId &&
        input == other.input;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, input.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUserShelfVars')
          ..add('userId', userId)
          ..add('input', input))
        .toString();
  }
}

class GUserShelfVarsBuilder
    implements Builder<GUserShelfVars, GUserShelfVarsBuilder> {
  _$GUserShelfVars? _$v;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  _i1.GMyShelfInputBuilder? _input;
  _i1.GMyShelfInputBuilder get input =>
      _$this._input ??= _i1.GMyShelfInputBuilder();
  set input(_i1.GMyShelfInputBuilder? input) => _$this._input = input;

  GUserShelfVarsBuilder();

  GUserShelfVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _input = $v.input?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUserShelfVars other) {
    _$v = other as _$GUserShelfVars;
  }

  @override
  void update(void Function(GUserShelfVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUserShelfVars build() => _build();

  _$GUserShelfVars _build() {
    _$GUserShelfVars _$result;
    try {
      _$result = _$v ??
          _$GUserShelfVars._(
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'GUserShelfVars', 'userId'),
            input: _input?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        _input?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GUserShelfVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
