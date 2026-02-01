// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_reading_status.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUpdateReadingStatusVars> _$gUpdateReadingStatusVarsSerializer =
    new _$GUpdateReadingStatusVarsSerializer();

class _$GUpdateReadingStatusVarsSerializer
    implements StructuredSerializer<GUpdateReadingStatusVars> {
  @override
  final Iterable<Type> types = const [
    GUpdateReadingStatusVars,
    _$GUpdateReadingStatusVars
  ];
  @override
  final String wireName = 'GUpdateReadingStatusVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GUpdateReadingStatusVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'userBookId',
      serializers.serialize(object.userBookId,
          specifiedType: const FullType(int)),
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(_i1.GReadingStatus)),
    ];

    return result;
  }

  @override
  GUpdateReadingStatusVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GUpdateReadingStatusVarsBuilder();

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
        case 'status':
          result.status = serializers.deserialize(value,
                  specifiedType: const FullType(_i1.GReadingStatus))!
              as _i1.GReadingStatus;
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateReadingStatusVars extends GUpdateReadingStatusVars {
  @override
  final int userBookId;
  @override
  final _i1.GReadingStatus status;

  factory _$GUpdateReadingStatusVars(
          [void Function(GUpdateReadingStatusVarsBuilder)? updates]) =>
      (new GUpdateReadingStatusVarsBuilder()..update(updates))._build();

  _$GUpdateReadingStatusVars._({required this.userBookId, required this.status})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        userBookId, r'GUpdateReadingStatusVars', 'userBookId');
    BuiltValueNullFieldError.checkNotNull(
        status, r'GUpdateReadingStatusVars', 'status');
  }

  @override
  GUpdateReadingStatusVars rebuild(
          void Function(GUpdateReadingStatusVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GUpdateReadingStatusVarsBuilder toBuilder() =>
      new GUpdateReadingStatusVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateReadingStatusVars &&
        userBookId == other.userBookId &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userBookId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateReadingStatusVars')
          ..add('userBookId', userBookId)
          ..add('status', status))
        .toString();
  }
}

class GUpdateReadingStatusVarsBuilder
    implements
        Builder<GUpdateReadingStatusVars, GUpdateReadingStatusVarsBuilder> {
  _$GUpdateReadingStatusVars? _$v;

  int? _userBookId;
  int? get userBookId => _$this._userBookId;
  set userBookId(int? userBookId) => _$this._userBookId = userBookId;

  _i1.GReadingStatus? _status;
  _i1.GReadingStatus? get status => _$this._status;
  set status(_i1.GReadingStatus? status) => _$this._status = status;

  GUpdateReadingStatusVarsBuilder();

  GUpdateReadingStatusVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userBookId = $v.userBookId;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateReadingStatusVars other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GUpdateReadingStatusVars;
  }

  @override
  void update(void Function(GUpdateReadingStatusVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateReadingStatusVars build() => _build();

  _$GUpdateReadingStatusVars _build() {
    final _$result = _$v ??
        new _$GUpdateReadingStatusVars._(
            userBookId: BuiltValueNullFieldError.checkNotNull(
                userBookId, r'GUpdateReadingStatusVars', 'userBookId'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'GUpdateReadingStatusVars', 'status'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
