// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_book_list.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GCreateBookListVars> _$gCreateBookListVarsSerializer =
    _$GCreateBookListVarsSerializer();

class _$GCreateBookListVarsSerializer
    implements StructuredSerializer<GCreateBookListVars> {
  @override
  final Iterable<Type> types = const [
    GCreateBookListVars,
    _$GCreateBookListVars
  ];
  @override
  final String wireName = 'GCreateBookListVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GCreateBookListVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'input',
      serializers.serialize(object.input,
          specifiedType: const FullType(_i1.GCreateBookListInput)),
    ];

    return result;
  }

  @override
  GCreateBookListVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GCreateBookListVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i1.GCreateBookListInput))!
              as _i1.GCreateBookListInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateBookListVars extends GCreateBookListVars {
  @override
  final _i1.GCreateBookListInput input;

  factory _$GCreateBookListVars(
          [void Function(GCreateBookListVarsBuilder)? updates]) =>
      (GCreateBookListVarsBuilder()..update(updates))._build();

  _$GCreateBookListVars._({required this.input}) : super._();
  @override
  GCreateBookListVars rebuild(
          void Function(GCreateBookListVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GCreateBookListVarsBuilder toBuilder() =>
      GCreateBookListVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateBookListVars && input == other.input;
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
    return (newBuiltValueToStringHelper(r'GCreateBookListVars')
          ..add('input', input))
        .toString();
  }
}

class GCreateBookListVarsBuilder
    implements Builder<GCreateBookListVars, GCreateBookListVarsBuilder> {
  _$GCreateBookListVars? _$v;

  _i1.GCreateBookListInputBuilder? _input;
  _i1.GCreateBookListInputBuilder get input =>
      _$this._input ??= _i1.GCreateBookListInputBuilder();
  set input(_i1.GCreateBookListInputBuilder? input) => _$this._input = input;

  GCreateBookListVarsBuilder();

  GCreateBookListVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateBookListVars other) {
    _$v = other as _$GCreateBookListVars;
  }

  @override
  void update(void Function(GCreateBookListVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateBookListVars build() => _build();

  _$GCreateBookListVars _build() {
    _$GCreateBookListVars _$result;
    try {
      _$result = _$v ??
          _$GCreateBookListVars._(
            input: input.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GCreateBookListVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
