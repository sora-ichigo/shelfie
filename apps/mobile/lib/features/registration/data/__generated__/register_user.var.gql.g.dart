// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_user.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GRegisterUserVars> _$gRegisterUserVarsSerializer =
    _$GRegisterUserVarsSerializer();

class _$GRegisterUserVarsSerializer
    implements StructuredSerializer<GRegisterUserVars> {
  @override
  final Iterable<Type> types = const [GRegisterUserVars, _$GRegisterUserVars];
  @override
  final String wireName = 'GRegisterUserVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GRegisterUserVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'input',
      serializers.serialize(
        object.input,
        specifiedType: const FullType(_i1.GRegisterUserInput),
      ),
    ];

    return result;
  }

  @override
  GRegisterUserVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GRegisterUserVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i1.GRegisterUserInput),
                )!
                as _i1.GRegisterUserInput,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GRegisterUserVars extends GRegisterUserVars {
  @override
  final _i1.GRegisterUserInput input;

  factory _$GRegisterUserVars([
    void Function(GRegisterUserVarsBuilder)? updates,
  ]) => (GRegisterUserVarsBuilder()..update(updates))._build();

  _$GRegisterUserVars._({required this.input}) : super._();
  @override
  GRegisterUserVars rebuild(void Function(GRegisterUserVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRegisterUserVarsBuilder toBuilder() =>
      GRegisterUserVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRegisterUserVars && input == other.input;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, input.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'GRegisterUserVars',
    )..add('input', input)).toString();
  }
}

class GRegisterUserVarsBuilder
    implements Builder<GRegisterUserVars, GRegisterUserVarsBuilder> {
  _$GRegisterUserVars? _$v;

  _i1.GRegisterUserInputBuilder? _input;
  _i1.GRegisterUserInputBuilder get input =>
      _$this._input ??= _i1.GRegisterUserInputBuilder();
  set input(_i1.GRegisterUserInputBuilder? input) => _$this._input = input;

  GRegisterUserVarsBuilder();

  GRegisterUserVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRegisterUserVars other) {
    _$v = other as _$GRegisterUserVars;
  }

  @override
  void update(void Function(GRegisterUserVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRegisterUserVars build() => _build();

  _$GRegisterUserVars _build() {
    _$GRegisterUserVars _$result;
    try {
      _$result = _$v ?? _$GRegisterUserVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GRegisterUserVars',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
