// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_follow_requests.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GPendingFollowRequestsData> _$gPendingFollowRequestsDataSerializer =
    _$GPendingFollowRequestsDataSerializer();
Serializer<GPendingFollowRequestsData_pendingFollowRequests>
    _$gPendingFollowRequestsDataPendingFollowRequestsSerializer =
    _$GPendingFollowRequestsData_pendingFollowRequestsSerializer();

class _$GPendingFollowRequestsDataSerializer
    implements StructuredSerializer<GPendingFollowRequestsData> {
  @override
  final Iterable<Type> types = const [
    GPendingFollowRequestsData,
    _$GPendingFollowRequestsData
  ];
  @override
  final String wireName = 'GPendingFollowRequestsData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GPendingFollowRequestsData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'pendingFollowRequests',
      serializers.serialize(object.pendingFollowRequests,
          specifiedType: const FullType(BuiltList, const [
            const FullType(GPendingFollowRequestsData_pendingFollowRequests)
          ])),
    ];

    return result;
  }

  @override
  GPendingFollowRequestsData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPendingFollowRequestsDataBuilder();

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
        case 'pendingFollowRequests':
          result.pendingFollowRequests.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GPendingFollowRequestsData_pendingFollowRequests)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GPendingFollowRequestsData_pendingFollowRequestsSerializer
    implements
        StructuredSerializer<GPendingFollowRequestsData_pendingFollowRequests> {
  @override
  final Iterable<Type> types = const [
    GPendingFollowRequestsData_pendingFollowRequests,
    _$GPendingFollowRequestsData_pendingFollowRequests
  ];
  @override
  final String wireName = 'GPendingFollowRequestsData_pendingFollowRequests';

  @override
  Iterable<Object?> serialize(Serializers serializers,
      GPendingFollowRequestsData_pendingFollowRequests object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'senderId',
      serializers.serialize(object.senderId,
          specifiedType: const FullType(int)),
      'receiverId',
      serializers.serialize(object.receiverId,
          specifiedType: const FullType(int)),
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(_i2.GFollowRequestStatus)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(DateTime)),
    ];

    return result;
  }

  @override
  GPendingFollowRequestsData_pendingFollowRequests deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GPendingFollowRequestsData_pendingFollowRequestsBuilder();

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
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'senderId':
          result.senderId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'receiverId':
          result.receiverId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GFollowRequestStatus))!
              as _i2.GFollowRequestStatus;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
      }
    }

    return result.build();
  }
}

class _$GPendingFollowRequestsData extends GPendingFollowRequestsData {
  @override
  final String G__typename;
  @override
  final BuiltList<GPendingFollowRequestsData_pendingFollowRequests>
      pendingFollowRequests;

  factory _$GPendingFollowRequestsData(
          [void Function(GPendingFollowRequestsDataBuilder)? updates]) =>
      (GPendingFollowRequestsDataBuilder()..update(updates))._build();

  _$GPendingFollowRequestsData._(
      {required this.G__typename, required this.pendingFollowRequests})
      : super._();
  @override
  GPendingFollowRequestsData rebuild(
          void Function(GPendingFollowRequestsDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPendingFollowRequestsDataBuilder toBuilder() =>
      GPendingFollowRequestsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPendingFollowRequestsData &&
        G__typename == other.G__typename &&
        pendingFollowRequests == other.pendingFollowRequests;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, pendingFollowRequests.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GPendingFollowRequestsData')
          ..add('G__typename', G__typename)
          ..add('pendingFollowRequests', pendingFollowRequests))
        .toString();
  }
}

class GPendingFollowRequestsDataBuilder
    implements
        Builder<GPendingFollowRequestsData, GPendingFollowRequestsDataBuilder> {
  _$GPendingFollowRequestsData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GPendingFollowRequestsData_pendingFollowRequests>?
      _pendingFollowRequests;
  ListBuilder<GPendingFollowRequestsData_pendingFollowRequests>
      get pendingFollowRequests => _$this._pendingFollowRequests ??=
          ListBuilder<GPendingFollowRequestsData_pendingFollowRequests>();
  set pendingFollowRequests(
          ListBuilder<GPendingFollowRequestsData_pendingFollowRequests>?
              pendingFollowRequests) =>
      _$this._pendingFollowRequests = pendingFollowRequests;

  GPendingFollowRequestsDataBuilder() {
    GPendingFollowRequestsData._initializeBuilder(this);
  }

  GPendingFollowRequestsDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _pendingFollowRequests = $v.pendingFollowRequests.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPendingFollowRequestsData other) {
    _$v = other as _$GPendingFollowRequestsData;
  }

  @override
  void update(void Function(GPendingFollowRequestsDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GPendingFollowRequestsData build() => _build();

  _$GPendingFollowRequestsData _build() {
    _$GPendingFollowRequestsData _$result;
    try {
      _$result = _$v ??
          _$GPendingFollowRequestsData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GPendingFollowRequestsData', 'G__typename'),
            pendingFollowRequests: pendingFollowRequests.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'pendingFollowRequests';
        pendingFollowRequests.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GPendingFollowRequestsData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GPendingFollowRequestsData_pendingFollowRequests
    extends GPendingFollowRequestsData_pendingFollowRequests {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final int senderId;
  @override
  final int receiverId;
  @override
  final _i2.GFollowRequestStatus status;
  @override
  final DateTime createdAt;

  factory _$GPendingFollowRequestsData_pendingFollowRequests(
          [void Function(
                  GPendingFollowRequestsData_pendingFollowRequestsBuilder)?
              updates]) =>
      (GPendingFollowRequestsData_pendingFollowRequestsBuilder()
            ..update(updates))
          ._build();

  _$GPendingFollowRequestsData_pendingFollowRequests._(
      {required this.G__typename,
      required this.id,
      required this.senderId,
      required this.receiverId,
      required this.status,
      required this.createdAt})
      : super._();
  @override
  GPendingFollowRequestsData_pendingFollowRequests rebuild(
          void Function(GPendingFollowRequestsData_pendingFollowRequestsBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GPendingFollowRequestsData_pendingFollowRequestsBuilder toBuilder() =>
      GPendingFollowRequestsData_pendingFollowRequestsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GPendingFollowRequestsData_pendingFollowRequests &&
        G__typename == other.G__typename &&
        id == other.id &&
        senderId == other.senderId &&
        receiverId == other.receiverId &&
        status == other.status &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, senderId.hashCode);
    _$hash = $jc(_$hash, receiverId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GPendingFollowRequestsData_pendingFollowRequests')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('senderId', senderId)
          ..add('receiverId', receiverId)
          ..add('status', status)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class GPendingFollowRequestsData_pendingFollowRequestsBuilder
    implements
        Builder<GPendingFollowRequestsData_pendingFollowRequests,
            GPendingFollowRequestsData_pendingFollowRequestsBuilder> {
  _$GPendingFollowRequestsData_pendingFollowRequests? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _senderId;
  int? get senderId => _$this._senderId;
  set senderId(int? senderId) => _$this._senderId = senderId;

  int? _receiverId;
  int? get receiverId => _$this._receiverId;
  set receiverId(int? receiverId) => _$this._receiverId = receiverId;

  _i2.GFollowRequestStatus? _status;
  _i2.GFollowRequestStatus? get status => _$this._status;
  set status(_i2.GFollowRequestStatus? status) => _$this._status = status;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  GPendingFollowRequestsData_pendingFollowRequestsBuilder() {
    GPendingFollowRequestsData_pendingFollowRequests._initializeBuilder(this);
  }

  GPendingFollowRequestsData_pendingFollowRequestsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _senderId = $v.senderId;
      _receiverId = $v.receiverId;
      _status = $v.status;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GPendingFollowRequestsData_pendingFollowRequests other) {
    _$v = other as _$GPendingFollowRequestsData_pendingFollowRequests;
  }

  @override
  void update(
      void Function(GPendingFollowRequestsData_pendingFollowRequestsBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  GPendingFollowRequestsData_pendingFollowRequests build() => _build();

  _$GPendingFollowRequestsData_pendingFollowRequests _build() {
    final _$result = _$v ??
        _$GPendingFollowRequestsData_pendingFollowRequests._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GPendingFollowRequestsData_pendingFollowRequests',
              'G__typename'),
          id: BuiltValueNullFieldError.checkNotNull(
              id, r'GPendingFollowRequestsData_pendingFollowRequests', 'id'),
          senderId: BuiltValueNullFieldError.checkNotNull(senderId,
              r'GPendingFollowRequestsData_pendingFollowRequests', 'senderId'),
          receiverId: BuiltValueNullFieldError.checkNotNull(
              receiverId,
              r'GPendingFollowRequestsData_pendingFollowRequests',
              'receiverId'),
          status: BuiltValueNullFieldError.checkNotNull(status,
              r'GPendingFollowRequestsData_pendingFollowRequests', 'status'),
          createdAt: BuiltValueNullFieldError.checkNotNull(createdAt,
              r'GPendingFollowRequestsData_pendingFollowRequests', 'createdAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
