// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_follow_request_count.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GPendingFollowRequestCountData>
    _$gPendingFollowRequestCountDataSerializer =
    _$GPendingFollowRequestCountDataSerializer();

class _$GPendingFollowRequestCountDataSerializer
    implements StructuredSerializer<GPendingFollowRequestCountData> {
  @override
  final Iterable<Type> types = const [
    GPendingFollowRequestCountData,
    _$GPendingFollowRequestCountData
  ];
  @override
  final String wireName = 'GPendingFollowRequestCountData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GPendingFollowRequestCountData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'pendingFollowRequestCount',
      serializers.serialize(object.pendingFollowRequestCount,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  GPendingFollowRequestCountData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPendingFollowRequestCountDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'pendingFollowRequestCount':
          result.pendingFollowRequestCount = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$GPendingFollowRequestCountData extends GPendingFollowRequestCountData {
  @override
  final String G__typename;
  @override
  final int pendingFollowRequestCount;

  factory _$GPendingFollowRequestCountData(
          [void Function(GPendingFollowRequestCountDataBuilder)? updates]) =>
      (GPendingFollowRequestCountDataBuilder()..update(updates))._build();

  _$GPendingFollowRequestCountData._(
      {required this.G__typename, required this.pendingFollowRequestCount})
      : super._();
  @override
  GPendingFollowRequestCountData rebuild(
          void Function(GPendingFollowRequestCountDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPendingFollowRequestCountDataBuilder toBuilder() =>
      GPendingFollowRequestCountDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPendingFollowRequestCountData &&
        G__typename == other.G__typename &&
        pendingFollowRequestCount == other.pendingFollowRequestCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, pendingFollowRequestCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPendingFollowRequestCountData')
          ..add('G__typename', G__typename)
          ..add('pendingFollowRequestCount', pendingFollowRequestCount))
        .toString();
  }
}

class GPendingFollowRequestCountDataBuilder
    implements
        Builder<GPendingFollowRequestCountData,
            GPendingFollowRequestCountDataBuilder> {
  _$GPendingFollowRequestCountData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _pendingFollowRequestCount;
  int? get pendingFollowRequestCount => _$this._pendingFollowRequestCount;
  set pendingFollowRequestCount(int? pendingFollowRequestCount) =>
      _$this._pendingFollowRequestCount = pendingFollowRequestCount;

  GPendingFollowRequestCountDataBuilder() {
    GPendingFollowRequestCountData._initializeBuilder(this);
  }

  GPendingFollowRequestCountDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _pendingFollowRequestCount = $v.pendingFollowRequestCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPendingFollowRequestCountData other) {
    _$v = other as _$GPendingFollowRequestCountData;
  }

  @override
  void update(void Function(GPendingFollowRequestCountDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPendingFollowRequestCountData build() => _build();

  _$GPendingFollowRequestCountData _build() {
    final _$result = _$v ??
        _$GPendingFollowRequestCountData._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename, r'GPendingFollowRequestCountData', 'G__typename'),
          pendingFollowRequestCount: BuiltValueNullFieldError.checkNotNull(
              pendingFollowRequestCount,
              r'GPendingFollowRequestCountData',
              'pendingFollowRequestCount'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
