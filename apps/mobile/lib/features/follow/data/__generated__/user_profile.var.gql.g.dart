// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUserProfileVars> _$gUserProfileVarsSerializer =
    _$GUserProfileVarsSerializer();

class _$GUserProfileVarsSerializer
    implements StructuredSerializer<GUserProfileVars> {
  @override
  final Iterable<Type> types = const [GUserProfileVars, _$GUserProfileVars];
  @override
  final String wireName = 'GUserProfileVars';

  @override
  Iterable<Object?> serialize(Serializers serializers, GUserProfileVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'handle',
      serializers.serialize(object.handle,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GUserProfileVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GUserProfileVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'handle':
          result.handle = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GUserProfileVars extends GUserProfileVars {
  @override
  final String handle;

  factory _$GUserProfileVars(
          [void Function(GUserProfileVarsBuilder)? updates]) =>
      (GUserProfileVarsBuilder()..update(updates))._build();

  _$GUserProfileVars._({required this.handle}) : super._();
  @override
  GUserProfileVars rebuild(void Function(GUserProfileVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUserProfileVarsBuilder toBuilder() =>
      GUserProfileVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUserProfileVars && handle == other.handle;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, handle.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUserProfileVars')
          ..add('handle', handle))
        .toString();
  }
}

class GUserProfileVarsBuilder
    implements Builder<GUserProfileVars, GUserProfileVarsBuilder> {
  _$GUserProfileVars? _$v;

  String? _handle;
  String? get handle => _$this._handle;
  set handle(String? handle) => _$this._handle = handle;

  GUserProfileVarsBuilder();

  GUserProfileVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _handle = $v.handle;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUserProfileVars other) {
    _$v = other as _$GUserProfileVars;
  }

  @override
  void update(void Function(GUserProfileVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUserProfileVars build() => _build();

  _$GUserProfileVars _build() {
    final _$result = _$v ??
        _$GUserProfileVars._(
          handle: BuiltValueNullFieldError.checkNotNull(
              handle, r'GUserProfileVars', 'handle'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
