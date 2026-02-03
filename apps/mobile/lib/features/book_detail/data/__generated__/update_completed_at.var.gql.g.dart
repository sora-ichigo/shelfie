// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_completed_at.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUpdateCompletedAtVars> _$gUpdateCompletedAtVarsSerializer =
    new _$GUpdateCompletedAtVarsSerializer();

class _$GUpdateCompletedAtVarsSerializer
    implements StructuredSerializer<GUpdateCompletedAtVars> {
  @override
  final Iterable<Type> types = const [
    GUpdateCompletedAtVars,
    _$GUpdateCompletedAtVars
  ];
  @override
  final String wireName = 'GUpdateCompletedAtVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateCompletedAtVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userBookId',
      serializers.serialize(object.userBookId,
          specifiedType: const FullType(int)),
      'completedAt',
      serializers.serialize(object.completedAt,
          specifiedType: const FullType(DateTime)),
    ];

    return result;
  }

  @override
  GUpdateCompletedAtVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateCompletedAtVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'userBookId':
          result.userBookId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'completedAt':
          result.completedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateCompletedAtVars extends GUpdateCompletedAtVars {
  @override
  final int userBookId;
  @override
  final DateTime completedAt;

  factory _$GUpdateCompletedAtVars(
          [void Function(GUpdateCompletedAtVarsBuilder)? updates]) =>
      (new GUpdateCompletedAtVarsBuilder()..update(updates))._build();

  _$GUpdateCompletedAtVars._(
      {required this.userBookId, required this.completedAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        userBookId, r'GUpdateCompletedAtVars', 'userBookId');
    BuiltValueNullFieldError.checkNotNull(
        completedAt, r'GUpdateCompletedAtVars', 'completedAt');
  }

  @override
  GUpdateCompletedAtVars rebuild(
          void Function(GUpdateCompletedAtVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateCompletedAtVarsBuilder toBuilder() =>
      new GUpdateCompletedAtVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateCompletedAtVars &&
        userBookId == other.userBookId &&
        completedAt == other.completedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userBookId.hashCode);
    _$hash = $jc(_$hash, completedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateCompletedAtVars')
          ..add('userBookId', userBookId)
          ..add('completedAt', completedAt))
        .toString();
  }
}

class GUpdateCompletedAtVarsBuilder
    implements Builder<GUpdateCompletedAtVars, GUpdateCompletedAtVarsBuilder> {
  _$GUpdateCompletedAtVars? _$v;

  int? _userBookId;
  int? get userBookId => _$this._userBookId;
  set userBookId(int? userBookId) => _$this._userBookId = userBookId;

  DateTime? _completedAt;
  DateTime? get completedAt => _$this._completedAt;
  set completedAt(DateTime? completedAt) => _$this._completedAt = completedAt;

  GUpdateCompletedAtVarsBuilder();

  GUpdateCompletedAtVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userBookId = $v.userBookId;
      _completedAt = $v.completedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateCompletedAtVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateCompletedAtVars;
  }

  @override
  void update(void Function(GUpdateCompletedAtVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateCompletedAtVars build() => _build();

  _$GUpdateCompletedAtVars _build() {
    final _$result = _$v ??
        new _$GUpdateCompletedAtVars._(
            userBookId: BuiltValueNullFieldError.checkNotNull(
                userBookId, r'GUpdateCompletedAtVars', 'userBookId'),
            completedAt: BuiltValueNullFieldError.checkNotNull(
                completedAt, r'GUpdateCompletedAtVars', 'completedAt'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
