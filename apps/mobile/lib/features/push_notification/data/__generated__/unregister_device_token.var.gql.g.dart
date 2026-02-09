// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unregister_device_token.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUnregisterDeviceTokenVars> _$gUnregisterDeviceTokenVarsSerializer =
    _$GUnregisterDeviceTokenVarsSerializer();

class _$GUnregisterDeviceTokenVarsSerializer
    implements StructuredSerializer<GUnregisterDeviceTokenVars> {
  @override
  final Iterable<Type> types = const [
    GUnregisterDeviceTokenVars,
    _$GUnregisterDeviceTokenVars,
  ];
  @override
  final String wireName = 'GUnregisterDeviceTokenVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GUnregisterDeviceTokenVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'input',
      serializers.serialize(
        object.input,
        specifiedType: const FullType(_i1.GUnregisterDeviceTokenInput),
      ),
    ];

    return result;
  }

  @override
  GUnregisterDeviceTokenVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GUnregisterDeviceTokenVarsBuilder();

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
                  specifiedType: const FullType(
                    _i1.GUnregisterDeviceTokenInput,
                  ),
                )!
                as _i1.GUnregisterDeviceTokenInput,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GUnregisterDeviceTokenVars extends GUnregisterDeviceTokenVars {
  @override
  final _i1.GUnregisterDeviceTokenInput input;

  factory _$GUnregisterDeviceTokenVars([
    void Function(GUnregisterDeviceTokenVarsBuilder)? updates,
  ]) => (GUnregisterDeviceTokenVarsBuilder()..update(updates))._build();

  _$GUnregisterDeviceTokenVars._({required this.input}) : super._();
  @override
  GUnregisterDeviceTokenVars rebuild(
    void Function(GUnregisterDeviceTokenVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GUnregisterDeviceTokenVarsBuilder toBuilder() =>
      GUnregisterDeviceTokenVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUnregisterDeviceTokenVars && input == other.input;
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
      r'GUnregisterDeviceTokenVars',
    )..add('input', input)).toString();
  }
}

class GUnregisterDeviceTokenVarsBuilder
    implements
        Builder<GUnregisterDeviceTokenVars, GUnregisterDeviceTokenVarsBuilder> {
  _$GUnregisterDeviceTokenVars? _$v;

  _i1.GUnregisterDeviceTokenInputBuilder? _input;
  _i1.GUnregisterDeviceTokenInputBuilder get input =>
      _$this._input ??= _i1.GUnregisterDeviceTokenInputBuilder();
  set input(_i1.GUnregisterDeviceTokenInputBuilder? input) =>
      _$this._input = input;

  GUnregisterDeviceTokenVarsBuilder();

  GUnregisterDeviceTokenVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUnregisterDeviceTokenVars other) {
    _$v = other as _$GUnregisterDeviceTokenVars;
  }

  @override
  void update(void Function(GUnregisterDeviceTokenVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUnregisterDeviceTokenVars build() => _build();

  _$GUnregisterDeviceTokenVars _build() {
    _$GUnregisterDeviceTokenVars _$result;
    try {
      _$result = _$v ?? _$GUnregisterDeviceTokenVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GUnregisterDeviceTokenVars',
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
