// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_follow_request.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GSendFollowRequestVars> _$gSendFollowRequestVarsSerializer =
    _$GSendFollowRequestVarsSerializer();

class _$GSendFollowRequestVarsSerializer
    implements StructuredSerializer<GSendFollowRequestVars> {
  @override
  final Iterable<Type> types = const [
    GSendFollowRequestVars,
    _$GSendFollowRequestVars
  ];
  @override
  final String wireName = 'GSendFollowRequestVars';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GSendFollowRequestVars object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'receiverId',
      serializers.serialize(object.receiverId,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GSendFollowRequestVars deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GSendFollowRequestVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'receiverId':
          result.receiverId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GSendFollowRequestVars extends GSendFollowRequestVars {
  @override
  final int receiverId;

  factory _$GSendFollowRequestVars(
          [void Function(GSendFollowRequestVarsBuilder)? updates]) =>
      (GSendFollowRequestVarsBuilder()..update(updates))._build();

  _$GSendFollowRequestVars._({required this.receiverId}) : super._();
  @override
  GSendFollowRequestVars rebuild(
          void Function(GSendFollowRequestVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSendFollowRequestVarsBuilder toBuilder() =>
      GSendFollowRequestVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendFollowRequestVars && receiverId == other.receiverId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, receiverId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSendFollowRequestVars')
          ..add('receiverId', receiverId))
        .toString();
  }
}

class GSendFollowRequestVarsBuilder
    implements Builder<GSendFollowRequestVars, GSendFollowRequestVarsBuilder> {
  _$GSendFollowRequestVars? _$v;

  int? _receiverId;
  int? get receiverId => _$this._receiverId;
  set receiverId(int? receiverId) => _$this._receiverId = receiverId;

  GSendFollowRequestVarsBuilder();

  GSendFollowRequestVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _receiverId = $v.receiverId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSendFollowRequestVars other) {
    _$v = other as _$GSendFollowRequestVars;
  }

  @override
  void update(void Function(GSendFollowRequestVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendFollowRequestVars build() => _build();

  _$GSendFollowRequestVars _build() {
    final _$result = _$v ??
        _$GSendFollowRequestVars._(
          receiverId: BuiltValueNullFieldError.checkNotNull(
              receiverId, r'GSendFollowRequestVars', 'receiverId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
