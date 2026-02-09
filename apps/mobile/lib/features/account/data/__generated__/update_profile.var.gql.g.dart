// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUpdateProfileVars> _$gUpdateProfileVarsSerializer =
    _$GUpdateProfileVarsSerializer();

class _$GUpdateProfileVarsSerializer
    implements StructuredSerializer<GUpdateProfileVars> {
  @override
  final Iterable<Type> types = const [GUpdateProfileVars, _$GUpdateProfileVars];
  @override
  final String wireName = 'GUpdateProfileVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GUpdateProfileVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'input',
      serializers.serialize(
        object.input,
        specifiedType: const FullType(_i1.GUpdateProfileInput),
      ),
    ];

    return result;
  }

  @override
  GUpdateProfileVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GUpdateProfileVarsBuilder();

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
                  specifiedType: const FullType(_i1.GUpdateProfileInput),
                )!
                as _i1.GUpdateProfileInput,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateProfileVars extends GUpdateProfileVars {
  @override
  final _i1.GUpdateProfileInput input;

  factory _$GUpdateProfileVars([
    void Function(GUpdateProfileVarsBuilder)? updates,
  ]) => (GUpdateProfileVarsBuilder()..update(updates))._build();

  _$GUpdateProfileVars._({required this.input}) : super._();
  @override
  GUpdateProfileVars rebuild(
    void Function(GUpdateProfileVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GUpdateProfileVarsBuilder toBuilder() =>
      GUpdateProfileVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateProfileVars && input == other.input;
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
      r'GUpdateProfileVars',
    )..add('input', input)).toString();
  }
}

class GUpdateProfileVarsBuilder
    implements Builder<GUpdateProfileVars, GUpdateProfileVarsBuilder> {
  _$GUpdateProfileVars? _$v;

  _i1.GUpdateProfileInputBuilder? _input;
  _i1.GUpdateProfileInputBuilder get input =>
      _$this._input ??= _i1.GUpdateProfileInputBuilder();
  set input(_i1.GUpdateProfileInputBuilder? input) => _$this._input = input;

  GUpdateProfileVarsBuilder();

  GUpdateProfileVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateProfileVars other) {
    _$v = other as _$GUpdateProfileVars;
  }

  @override
  void update(void Function(GUpdateProfileVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateProfileVars build() => _build();

  _$GUpdateProfileVars _build() {
    _$GUpdateProfileVars _$result;
    try {
      _$result = _$v ?? _$GUpdateProfileVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GUpdateProfileVars',
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
