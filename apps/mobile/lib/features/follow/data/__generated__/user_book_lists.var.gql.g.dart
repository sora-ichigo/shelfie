// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_book_lists.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUserBookListsVars> _$gUserBookListsVarsSerializer =
    _$GUserBookListsVarsSerializer();

class _$GUserBookListsVarsSerializer
    implements StructuredSerializer<GUserBookListsVars> {
  @override
  final Iterable<Type> types = const [GUserBookListsVars, _$GUserBookListsVars];
  @override
  final String wireName = 'GUserBookListsVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUserBookListsVars object,
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
            specifiedType: const FullType(_i1.GMyBookListsInput)));
    }
    return result;
  }

  @override
  GUserBookListsVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUserBookListsVarsBuilder();

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
                  specifiedType: const FullType(_i1.GMyBookListsInput))!
              as _i1.GMyBookListsInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GUserBookListsVars extends GUserBookListsVars {
  @override
  final int userId;
  @override
  final _i1.GMyBookListsInput? input;

  factory _$GUserBookListsVars(
          [void Function(GUserBookListsVarsBuilder)? updates]) =>
      (GUserBookListsVarsBuilder()..update(updates))._build();

  _$GUserBookListsVars._({required this.userId, this.input}) : super._();
  @override
  GUserBookListsVars rebuild(
          void Function(GUserBookListsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUserBookListsVarsBuilder toBuilder() =>
      GUserBookListsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUserBookListsVars &&
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
    return (newBuiltValueToStringHelper(r'GUserBookListsVars')
          ..add('userId', userId)
          ..add('input', input))
        .toString();
  }
}

class GUserBookListsVarsBuilder
    implements Builder<GUserBookListsVars, GUserBookListsVarsBuilder> {
  _$GUserBookListsVars? _$v;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  _i1.GMyBookListsInputBuilder? _input;
  _i1.GMyBookListsInputBuilder get input =>
      _$this._input ??= _i1.GMyBookListsInputBuilder();
  set input(_i1.GMyBookListsInputBuilder? input) => _$this._input = input;

  GUserBookListsVarsBuilder();

  GUserBookListsVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _input = $v.input?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUserBookListsVars other) {
    _$v = other as _$GUserBookListsVars;
  }

  @override
  void update(void Function(GUserBookListsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUserBookListsVars build() => _build();

  _$GUserBookListsVars _build() {
    _$GUserBookListsVars _$result;
    try {
      _$result = _$v ??
          _$GUserBookListsVars._(
            userId: BuiltValueNullFieldError.checkNotNull(
                userId, r'GUserBookListsVars', 'userId'),
            input: _input?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        _input?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GUserBookListsVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
