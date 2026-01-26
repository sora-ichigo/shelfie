// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_password_reset_email.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GSendPasswordResetEmailVars>
    _$gSendPasswordResetEmailVarsSerializer =
    _$GSendPasswordResetEmailVarsSerializer();

class _$GSendPasswordResetEmailVarsSerializer
    implements StructuredSerializer<GSendPasswordResetEmailVars> {
  @override
  final Iterable<Type> types = const [
    GSendPasswordResetEmailVars,
    _$GSendPasswordResetEmailVars
  ];
  @override
  final String wireName = 'GSendPasswordResetEmailVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSendPasswordResetEmailVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'input',
      serializers.serialize(object.input,
          specifiedType: const FullType(_i1.GSendPasswordResetEmailInput)),
    ];

    return result;
  }

  @override
  GSendPasswordResetEmailVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GSendPasswordResetEmailVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(_i1.GSendPasswordResetEmailInput))!
              as _i1.GSendPasswordResetEmailInput);
          break;
      }
    }

    return result.build();
  }
}

class _$GSendPasswordResetEmailVars extends GSendPasswordResetEmailVars {
  @override
  final _i1.GSendPasswordResetEmailInput input;

  factory _$GSendPasswordResetEmailVars(
          [void Function(GSendPasswordResetEmailVarsBuilder)? updates]) =>
      (GSendPasswordResetEmailVarsBuilder()..update(updates))._build();

  _$GSendPasswordResetEmailVars._({required this.input}) : super._();
  @override
  GSendPasswordResetEmailVars rebuild(
          void Function(GSendPasswordResetEmailVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSendPasswordResetEmailVarsBuilder toBuilder() =>
      GSendPasswordResetEmailVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendPasswordResetEmailVars && input == other.input;
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
    return (newBuiltValueToStringHelper(r'GSendPasswordResetEmailVars')
          ..add('input', input))
        .toString();
  }
}

class GSendPasswordResetEmailVarsBuilder
    implements
        Builder<GSendPasswordResetEmailVars,
            GSendPasswordResetEmailVarsBuilder> {
  _$GSendPasswordResetEmailVars? _$v;

  _i1.GSendPasswordResetEmailInputBuilder? _input;
  _i1.GSendPasswordResetEmailInputBuilder get input =>
      _$this._input ??= _i1.GSendPasswordResetEmailInputBuilder();
  set input(_i1.GSendPasswordResetEmailInputBuilder? input) =>
      _$this._input = input;

  GSendPasswordResetEmailVarsBuilder();

  GSendPasswordResetEmailVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSendPasswordResetEmailVars other) {
    _$v = other as _$GSendPasswordResetEmailVars;
  }

  @override
  void update(void Function(GSendPasswordResetEmailVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendPasswordResetEmailVars build() => _build();

  _$GSendPasswordResetEmailVars _build() {
    _$GSendPasswordResetEmailVars _$result;
    try {
      _$result = _$v ??
          _$GSendPasswordResetEmailVars._(
            input: input.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GSendPasswordResetEmailVars', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
