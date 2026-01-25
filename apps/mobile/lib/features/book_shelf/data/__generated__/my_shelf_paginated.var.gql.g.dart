// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_shelf_paginated.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMyShelfPaginatedVars> _$gMyShelfPaginatedVarsSerializer =
    _$GMyShelfPaginatedVarsSerializer();

class _$GMyShelfPaginatedVarsSerializer
    implements StructuredSerializer<GMyShelfPaginatedVars> {
  @override
  final Iterable<Type> types = const [
    GMyShelfPaginatedVars,
    _$GMyShelfPaginatedVars
  ];
  @override
  final String wireName = 'GMyShelfPaginatedVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GMyShelfPaginatedVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
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
  GMyShelfPaginatedVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GMyShelfPaginatedVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
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

class _$GMyShelfPaginatedVars extends GMyShelfPaginatedVars {
  @override
  final _i1.GMyShelfInput? input;

  factory _$GMyShelfPaginatedVars(
          [void Function(GMyShelfPaginatedVarsBuilder)? updates]) =>
      (GMyShelfPaginatedVarsBuilder()..update(updates))._build();

  _$GMyShelfPaginatedVars._({this.input}) : super._();
  @override
  GMyShelfPaginatedVars rebuild(
          void Function(GMyShelfPaginatedVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMyShelfPaginatedVarsBuilder toBuilder() =>
      GMyShelfPaginatedVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyShelfPaginatedVars && input == other.input;
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
    return (newBuiltValueToStringHelper(r'GMyShelfPaginatedVars')
          ..add('input', input))
        .toString();
  }
}

class GMyShelfPaginatedVarsBuilder
    implements Builder<GMyShelfPaginatedVars, GMyShelfPaginatedVarsBuilder> {
  _$GMyShelfPaginatedVars? _$v;

  _i1.GMyShelfInputBuilder? _input;
  _i1.GMyShelfInputBuilder get input =>
      _$this._input ??= _i1.GMyShelfInputBuilder();
  set input(_i1.GMyShelfInputBuilder? input) => _$this._input = input;

  GMyShelfPaginatedVarsBuilder();

  GMyShelfPaginatedVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyShelfPaginatedVars other) {
    _$v = other as _$GMyShelfPaginatedVars;
  }

  @override
  void update(void Function(GMyShelfPaginatedVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMyShelfPaginatedVars build() => _build();

  _$GMyShelfPaginatedVars _build() {
    _$GMyShelfPaginatedVars _$result;
    try {
      _$result = _$v ??
          _$GMyShelfPaginatedVars._(
            input: _input?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        _input?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GMyShelfPaginatedVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
