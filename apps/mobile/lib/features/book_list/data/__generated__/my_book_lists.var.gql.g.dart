// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_book_lists.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMyBookListsVars> _$gMyBookListsVarsSerializer =
    _$GMyBookListsVarsSerializer();

class _$GMyBookListsVarsSerializer
    implements StructuredSerializer<GMyBookListsVars> {
  @override
  final Iterable<Type> types = const [GMyBookListsVars, _$GMyBookListsVars];
  @override
  final String wireName = 'GMyBookListsVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyBookListsVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.input;
    if (value != null) {
      result
        ..add('input')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(_i1.GMyBookListsInput),
          ),
        );
    }
    return result;
  }

  @override
  GMyBookListsVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMyBookListsVarsBuilder();

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
                  specifiedType: const FullType(_i1.GMyBookListsInput),
                )!
                as _i1.GMyBookListsInput,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GMyBookListsVars extends GMyBookListsVars {
  @override
  final _i1.GMyBookListsInput? input;

  factory _$GMyBookListsVars([
    void Function(GMyBookListsVarsBuilder)? updates,
  ]) => (GMyBookListsVarsBuilder()..update(updates))._build();

  _$GMyBookListsVars._({this.input}) : super._();
  @override
  GMyBookListsVars rebuild(void Function(GMyBookListsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMyBookListsVarsBuilder toBuilder() =>
      GMyBookListsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyBookListsVars && input == other.input;
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
      r'GMyBookListsVars',
    )..add('input', input)).toString();
  }
}

class GMyBookListsVarsBuilder
    implements Builder<GMyBookListsVars, GMyBookListsVarsBuilder> {
  _$GMyBookListsVars? _$v;

  _i1.GMyBookListsInputBuilder? _input;
  _i1.GMyBookListsInputBuilder get input =>
      _$this._input ??= _i1.GMyBookListsInputBuilder();
  set input(_i1.GMyBookListsInputBuilder? input) => _$this._input = input;

  GMyBookListsVarsBuilder();

  GMyBookListsVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyBookListsVars other) {
    _$v = other as _$GMyBookListsVars;
  }

  @override
  void update(void Function(GMyBookListsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMyBookListsVars build() => _build();

  _$GMyBookListsVars _build() {
    _$GMyBookListsVars _$result;
    try {
      _$result = _$v ?? _$GMyBookListsVars._(input: _input?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        _input?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GMyBookListsVars',
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
