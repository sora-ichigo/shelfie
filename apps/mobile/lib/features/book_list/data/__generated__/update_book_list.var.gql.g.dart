// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_book_list.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUpdateBookListVars> _$gUpdateBookListVarsSerializer =
    _$GUpdateBookListVarsSerializer();

class _$GUpdateBookListVarsSerializer
    implements StructuredSerializer<GUpdateBookListVars> {
  @override
  final Iterable<Type> types = const [
    GUpdateBookListVars,
    _$GUpdateBookListVars,
  ];
  @override
  final String wireName = 'GUpdateBookListVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GUpdateBookListVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'input',
      serializers.serialize(
        object.input,
        specifiedType: const FullType(_i1.GUpdateBookListInput),
      ),
    ];

    return result;
  }

  @override
  GUpdateBookListVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GUpdateBookListVarsBuilder();

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
                  specifiedType: const FullType(_i1.GUpdateBookListInput),
                )!
                as _i1.GUpdateBookListInput,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateBookListVars extends GUpdateBookListVars {
  @override
  final _i1.GUpdateBookListInput input;

  factory _$GUpdateBookListVars([
    void Function(GUpdateBookListVarsBuilder)? updates,
  ]) => (GUpdateBookListVarsBuilder()..update(updates))._build();

  _$GUpdateBookListVars._({required this.input}) : super._();
  @override
  GUpdateBookListVars rebuild(
    void Function(GUpdateBookListVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GUpdateBookListVarsBuilder toBuilder() =>
      GUpdateBookListVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateBookListVars && input == other.input;
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
      r'GUpdateBookListVars',
    )..add('input', input)).toString();
  }
}

class GUpdateBookListVarsBuilder
    implements Builder<GUpdateBookListVars, GUpdateBookListVarsBuilder> {
  _$GUpdateBookListVars? _$v;

  _i1.GUpdateBookListInputBuilder? _input;
  _i1.GUpdateBookListInputBuilder get input =>
      _$this._input ??= _i1.GUpdateBookListInputBuilder();
  set input(_i1.GUpdateBookListInputBuilder? input) => _$this._input = input;

  GUpdateBookListVarsBuilder();

  GUpdateBookListVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateBookListVars other) {
    _$v = other as _$GUpdateBookListVars;
  }

  @override
  void update(void Function(GUpdateBookListVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateBookListVars build() => _build();

  _$GUpdateBookListVars _build() {
    _$GUpdateBookListVars _$result;
    try {
      _$result = _$v ?? _$GUpdateBookListVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GUpdateBookListVars',
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
