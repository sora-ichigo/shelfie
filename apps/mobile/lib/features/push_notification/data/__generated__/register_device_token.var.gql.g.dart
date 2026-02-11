// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_device_token.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GRegisterDeviceTokenVars> _$gRegisterDeviceTokenVarsSerializer =
    _$GRegisterDeviceTokenVarsSerializer();

class _$GRegisterDeviceTokenVarsSerializer
    implements StructuredSerializer<GRegisterDeviceTokenVars> {
  @override
  final Iterable<Type> types = const [
    GRegisterDeviceTokenVars,
    _$GRegisterDeviceTokenVars
  ];
  @override
  final String wireName = 'GRegisterDeviceTokenVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GRegisterDeviceTokenVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'input',
      serializers.serialize(object.input,
          specifiedType: const FullType(_i1.GRegisterDeviceTokenInput)),
    ];

    return result;
  }

  @override
  GRegisterDeviceTokenVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GRegisterDeviceTokenVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(serializers.deserialize(value,
                  specifiedType: const FullType(_i1.GRegisterDeviceTokenInput))!
              as _i1.GRegisterDeviceTokenInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GRegisterDeviceTokenVars extends GRegisterDeviceTokenVars {
  @override
  final _i1.GRegisterDeviceTokenInput input;

  factory _$GRegisterDeviceTokenVars(
          [void Function(GRegisterDeviceTokenVarsBuilder)? updates]) =>
      (GRegisterDeviceTokenVarsBuilder()..update(updates))._build();

  _$GRegisterDeviceTokenVars._({required this.input}) : super._();
  @override
  GRegisterDeviceTokenVars rebuild(
          void Function(GRegisterDeviceTokenVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRegisterDeviceTokenVarsBuilder toBuilder() =>
      GRegisterDeviceTokenVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRegisterDeviceTokenVars && input == other.input;
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
    return (newBuiltValueToStringHelper(r'GRegisterDeviceTokenVars')
          ..add('input', input))
        .toString();
  }
}

class GRegisterDeviceTokenVarsBuilder
    implements
        Builder<GRegisterDeviceTokenVars, GRegisterDeviceTokenVarsBuilder> {
  _$GRegisterDeviceTokenVars? _$v;

  _i1.GRegisterDeviceTokenInputBuilder? _input;
  _i1.GRegisterDeviceTokenInputBuilder get input =>
      _$this._input ??= _i1.GRegisterDeviceTokenInputBuilder();
  set input(_i1.GRegisterDeviceTokenInputBuilder? input) =>
      _$this._input = input;

  GRegisterDeviceTokenVarsBuilder();

  GRegisterDeviceTokenVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRegisterDeviceTokenVars other) {
    _$v = other as _$GRegisterDeviceTokenVars;
  }

  @override
  void update(void Function(GRegisterDeviceTokenVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRegisterDeviceTokenVars build() => _build();

  _$GRegisterDeviceTokenVars _build() {
    _$GRegisterDeviceTokenVars _$result;
    try {
      _$result = _$v ??
          _$GRegisterDeviceTokenVars._(
            input: input.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GRegisterDeviceTokenVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
