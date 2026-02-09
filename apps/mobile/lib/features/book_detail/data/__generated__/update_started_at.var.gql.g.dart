// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_started_at.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUpdateStartedAtVars> _$gUpdateStartedAtVarsSerializer =
    _$GUpdateStartedAtVarsSerializer();

class _$GUpdateStartedAtVarsSerializer
    implements StructuredSerializer<GUpdateStartedAtVars> {
  @override
  final Iterable<Type> types = const [
    GUpdateStartedAtVars,
    _$GUpdateStartedAtVars,
  ];
  @override
  final String wireName = 'GUpdateStartedAtVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GUpdateStartedAtVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'userBookId',
      serializers.serialize(
        object.userBookId,
        specifiedType: const FullType(int),
      ),
      'startedAt',
      serializers.serialize(
        object.startedAt,
        specifiedType: const FullType(DateTime),
      ),
    ];

    return result;
  }

  @override
  GUpdateStartedAtVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GUpdateStartedAtVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'userBookId':
          result.userBookId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'startedAt':
          result.startedAt =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(DateTime),
                  )!
                  as DateTime;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateStartedAtVars extends GUpdateStartedAtVars {
  @override
  final int userBookId;
  @override
  final DateTime startedAt;

  factory _$GUpdateStartedAtVars([
    void Function(GUpdateStartedAtVarsBuilder)? updates,
  ]) => (GUpdateStartedAtVarsBuilder()..update(updates))._build();

  _$GUpdateStartedAtVars._({required this.userBookId, required this.startedAt})
    : super._();
  @override
  GUpdateStartedAtVars rebuild(
    void Function(GUpdateStartedAtVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GUpdateStartedAtVarsBuilder toBuilder() =>
      GUpdateStartedAtVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateStartedAtVars &&
        userBookId == other.userBookId &&
        startedAt == other.startedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userBookId.hashCode);
    _$hash = $jc(_$hash, startedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateStartedAtVars')
          ..add('userBookId', userBookId)
          ..add('startedAt', startedAt))
        .toString();
  }
}

class GUpdateStartedAtVarsBuilder
    implements Builder<GUpdateStartedAtVars, GUpdateStartedAtVarsBuilder> {
  _$GUpdateStartedAtVars? _$v;

  int? _userBookId;
  int? get userBookId => _$this._userBookId;
  set userBookId(int? userBookId) => _$this._userBookId = userBookId;

  DateTime? _startedAt;
  DateTime? get startedAt => _$this._startedAt;
  set startedAt(DateTime? startedAt) => _$this._startedAt = startedAt;

  GUpdateStartedAtVarsBuilder();

  GUpdateStartedAtVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userBookId = $v.userBookId;
      _startedAt = $v.startedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateStartedAtVars other) {
    _$v = other as _$GUpdateStartedAtVars;
  }

  @override
  void update(void Function(GUpdateStartedAtVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateStartedAtVars build() => _build();

  _$GUpdateStartedAtVars _build() {
    final _$result =
        _$v ??
        _$GUpdateStartedAtVars._(
          userBookId: BuiltValueNullFieldError.checkNotNull(
            userBookId,
            r'GUpdateStartedAtVars',
            'userBookId',
          ),
          startedAt: BuiltValueNullFieldError.checkNotNull(
            startedAt,
            r'GUpdateStartedAtVars',
            'startedAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
