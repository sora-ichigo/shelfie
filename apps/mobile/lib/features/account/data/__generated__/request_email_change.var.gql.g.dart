// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_email_change.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GRequestEmailChangeVars> _$gRequestEmailChangeVarsSerializer =
    new _$GRequestEmailChangeVarsSerializer();

class _$GRequestEmailChangeVarsSerializer
    implements StructuredSerializer<GRequestEmailChangeVars> {
  @override
  final Iterable<Type> types = const [
    GRequestEmailChangeVars,
    _$GRequestEmailChangeVars
  ];
  @override
  final String wireName = 'GRequestEmailChangeVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GRequestEmailChangeVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'input',
      serializers.serialize(object.input,
          specifiedType: const FullType(_i1.GRequestEmailChangeInput)),
    ];

    return result;
  }

  @override
  GRequestEmailChangeVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GRequestEmailChangeVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i1.GRequestEmailChangeInput))!
              as _i1.GRequestEmailChangeInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GRequestEmailChangeVars extends GRequestEmailChangeVars {
  @override
  final _i1.GRequestEmailChangeInput input;

  factory _$GRequestEmailChangeVars(
          [void Function(GRequestEmailChangeVarsBuilder)? updates]) =>
      (new GRequestEmailChangeVarsBuilder()..update(updates))._build();

  _$GRequestEmailChangeVars._({required this.input}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        input, r'GRequestEmailChangeVars', 'input');
  }

  @override
  GRequestEmailChangeVars rebuild(
          void Function(GRequestEmailChangeVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRequestEmailChangeVarsBuilder toBuilder() =>
      new GRequestEmailChangeVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRequestEmailChangeVars && input == other.input;
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
    return (newBuiltValueToStringHelper(r'GRequestEmailChangeVars')
          ..add('input', input))
        .toString();
  }
}

class GRequestEmailChangeVarsBuilder
    implements
        Builder<GRequestEmailChangeVars, GRequestEmailChangeVarsBuilder> {
  _$GRequestEmailChangeVars? _$v;

  _i1.GRequestEmailChangeInputBuilder? _input;
  _i1.GRequestEmailChangeInputBuilder get input =>
      _$this._input ??= new _i1.GRequestEmailChangeInputBuilder();
  set input(_i1.GRequestEmailChangeInputBuilder? input) =>
      _$this._input = input;

  GRequestEmailChangeVarsBuilder();

  GRequestEmailChangeVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRequestEmailChangeVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GRequestEmailChangeVars;
  }

  @override
  void update(void Function(GRequestEmailChangeVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRequestEmailChangeVars build() => _build();

  _$GRequestEmailChangeVars _build() {
    _$GRequestEmailChangeVars _$result;
    try {
      _$result = _$v ?? new _$GRequestEmailChangeVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'GRequestEmailChangeVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
