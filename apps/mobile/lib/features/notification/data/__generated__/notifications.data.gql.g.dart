// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GNotificationsData> _$gNotificationsDataSerializer =
    _$GNotificationsDataSerializer();
Serializer<GNotificationsData_notifications>
    _$gNotificationsDataNotificationsSerializer =
    _$GNotificationsData_notificationsSerializer();
Serializer<GNotificationsData_notifications_sender>
    _$gNotificationsDataNotificationsSenderSerializer =
    _$GNotificationsData_notifications_senderSerializer();

class _$GNotificationsDataSerializer
    implements StructuredSerializer<GNotificationsData> {
  @override
  final Iterable<Type> types = const [GNotificationsData, _$GNotificationsData];
  @override
  final String wireName = 'GNotificationsData';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GNotificationsData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'notifications',
      serializers.serialize(object.notifications,
          specifiedType: const FullType(BuiltList,
              const [const FullType(GNotificationsData_notifications)])),
    ];

    return result;
  }

  @override
  GNotificationsData deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GNotificationsDataBuilder();

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
        case 'notifications':
          result.notifications.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(GNotificationsData_notifications)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationsData_notificationsSerializer
    implements StructuredSerializer<GNotificationsData_notifications> {
  @override
  final Iterable<Type> types = const [
    GNotificationsData_notifications,
    _$GNotificationsData_notifications
  ];
  @override
  final String wireName = 'GNotificationsData_notifications';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GNotificationsData_notifications object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'sender',
      serializers.serialize(object.sender,
          specifiedType:
              const FullType(GNotificationsData_notifications_sender)),
      'type',
      serializers.serialize(object.type,
          specifiedType: const FullType(_i2.GNotificationType)),
      'followStatus',
      serializers.serialize(object.followStatus,
          specifiedType: const FullType(_i2.GFollowStatus)),
      'isRead',
      serializers.serialize(object.isRead, specifiedType: const FullType(bool)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(DateTime)),
    ];

    return result;
  }

  @override
  GNotificationsData_notifications deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GNotificationsData_notificationsBuilder();

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
        case 'sender':
          result.sender.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(GNotificationsData_notifications_sender))!
              as GNotificationsData_notifications_sender);
          break;
        case 'type':
          result.type = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GNotificationType))!
              as _i2.GNotificationType;
          break;
        case 'followStatus':
          result.followStatus = serializers.deserialize(value,
                  specifiedType: const FullType(_i2.GFollowStatus))!
              as _i2.GFollowStatus;
          break;
        case 'isRead':
          result.isRead = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
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

class _$GNotificationsData_notifications_senderSerializer
    implements StructuredSerializer<GNotificationsData_notifications_sender> {
  @override
  final Iterable<Type> types = const [
    GNotificationsData_notifications_sender,
    _$GNotificationsData_notifications_sender
  ];
  @override
  final String wireName = 'GNotificationsData_notifications_sender';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, GNotificationsData_notifications_sender object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(object.G__typename,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.avatarUrl;
    if (value != null) {
      result
        ..add('avatarUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.handle;
    if (value != null) {
      result
        ..add('handle')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  GNotificationsData_notifications_sender deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = GNotificationsData_notifications_senderBuilder();

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
              specifiedType: const FullType(int)) as int?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'avatarUrl':
          result.avatarUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'handle':
          result.handle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GNotificationsData extends GNotificationsData {
  @override
  final String G__typename;
  @override
  final BuiltList<GNotificationsData_notifications> notifications;

  factory _$GNotificationsData(
          [void Function(GNotificationsDataBuilder)? updates]) =>
      (GNotificationsDataBuilder()..update(updates))._build();

  _$GNotificationsData._(
      {required this.G__typename, required this.notifications})
      : super._();
  @override
  GNotificationsData rebuild(
          void Function(GNotificationsDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationsDataBuilder toBuilder() =>
      GNotificationsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GNotificationsData &&
        G__typename == other.G__typename &&
        notifications == other.notifications;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, notifications.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GNotificationsData')
          ..add('G__typename', G__typename)
          ..add('notifications', notifications))
        .toString();
  }
}

class GNotificationsDataBuilder
    implements Builder<GNotificationsData, GNotificationsDataBuilder> {
  _$GNotificationsData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GNotificationsData_notifications>? _notifications;
  ListBuilder<GNotificationsData_notifications> get notifications =>
      _$this._notifications ??= ListBuilder<GNotificationsData_notifications>();
  set notifications(
          ListBuilder<GNotificationsData_notifications>? notifications) =>
      _$this._notifications = notifications;

  GNotificationsDataBuilder() {
    GNotificationsData._initializeBuilder(this);
  }

  GNotificationsDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _notifications = $v.notifications.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GNotificationsData other) {
    _$v = other as _$GNotificationsData;
  }

  @override
  void update(void Function(GNotificationsDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationsData build() => _build();

  _$GNotificationsData _build() {
    _$GNotificationsData _$result;
    try {
      _$result = _$v ??
          _$GNotificationsData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
                G__typename, r'GNotificationsData', 'G__typename'),
            notifications: notifications.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'notifications';
        notifications.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GNotificationsData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationsData_notifications
    extends GNotificationsData_notifications {
  @override
  final String G__typename;
  @override
  final int id;
  @override
  final GNotificationsData_notifications_sender sender;
  @override
  final _i2.GNotificationType type;
  @override
  final _i2.GFollowStatus followStatus;
  @override
  final bool isRead;
  @override
  final DateTime createdAt;

  factory _$GNotificationsData_notifications(
          [void Function(GNotificationsData_notificationsBuilder)? updates]) =>
      (GNotificationsData_notificationsBuilder()..update(updates))._build();

  _$GNotificationsData_notifications._(
      {required this.G__typename,
      required this.id,
      required this.sender,
      required this.type,
      required this.followStatus,
      required this.isRead,
      required this.createdAt})
      : super._();
  @override
  GNotificationsData_notifications rebuild(
          void Function(GNotificationsData_notificationsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationsData_notificationsBuilder toBuilder() =>
      GNotificationsData_notificationsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GNotificationsData_notifications &&
        G__typename == other.G__typename &&
        id == other.id &&
        sender == other.sender &&
        type == other.type &&
        followStatus == other.followStatus &&
        isRead == other.isRead &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, sender.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, followStatus.hashCode);
    _$hash = $jc(_$hash, isRead.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GNotificationsData_notifications')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('sender', sender)
          ..add('type', type)
          ..add('followStatus', followStatus)
          ..add('isRead', isRead)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class GNotificationsData_notificationsBuilder
    implements
        Builder<GNotificationsData_notifications,
            GNotificationsData_notificationsBuilder> {
  _$GNotificationsData_notifications? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  GNotificationsData_notifications_senderBuilder? _sender;
  GNotificationsData_notifications_senderBuilder get sender =>
      _$this._sender ??= GNotificationsData_notifications_senderBuilder();
  set sender(GNotificationsData_notifications_senderBuilder? sender) =>
      _$this._sender = sender;

  _i2.GNotificationType? _type;
  _i2.GNotificationType? get type => _$this._type;
  set type(_i2.GNotificationType? type) => _$this._type = type;

  _i2.GFollowStatus? _followStatus;
  _i2.GFollowStatus? get followStatus => _$this._followStatus;
  set followStatus(_i2.GFollowStatus? followStatus) =>
      _$this._followStatus = followStatus;

  bool? _isRead;
  bool? get isRead => _$this._isRead;
  set isRead(bool? isRead) => _$this._isRead = isRead;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  GNotificationsData_notificationsBuilder() {
    GNotificationsData_notifications._initializeBuilder(this);
  }

  GNotificationsData_notificationsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _sender = $v.sender.toBuilder();
      _type = $v.type;
      _followStatus = $v.followStatus;
      _isRead = $v.isRead;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GNotificationsData_notifications other) {
    _$v = other as _$GNotificationsData_notifications;
  }

  @override
  void update(void Function(GNotificationsData_notificationsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationsData_notifications build() => _build();

  _$GNotificationsData_notifications _build() {
    _$GNotificationsData_notifications _$result;
    try {
      _$result = _$v ??
          _$GNotificationsData_notifications._(
            G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
                r'GNotificationsData_notifications', 'G__typename'),
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'GNotificationsData_notifications', 'id'),
            sender: sender.build(),
            type: BuiltValueNullFieldError.checkNotNull(
                type, r'GNotificationsData_notifications', 'type'),
            followStatus: BuiltValueNullFieldError.checkNotNull(followStatus,
                r'GNotificationsData_notifications', 'followStatus'),
            isRead: BuiltValueNullFieldError.checkNotNull(
                isRead, r'GNotificationsData_notifications', 'isRead'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'GNotificationsData_notifications', 'createdAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'sender';
        sender.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'GNotificationsData_notifications', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GNotificationsData_notifications_sender
    extends GNotificationsData_notifications_sender {
  @override
  final String G__typename;
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? avatarUrl;
  @override
  final String? handle;

  factory _$GNotificationsData_notifications_sender(
          [void Function(GNotificationsData_notifications_senderBuilder)?
              updates]) =>
      (GNotificationsData_notifications_senderBuilder()..update(updates))
          ._build();

  _$GNotificationsData_notifications_sender._(
      {required this.G__typename,
      this.id,
      this.name,
      this.avatarUrl,
      this.handle})
      : super._();
  @override
  GNotificationsData_notifications_sender rebuild(
          void Function(GNotificationsData_notifications_senderBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GNotificationsData_notifications_senderBuilder toBuilder() =>
      GNotificationsData_notifications_senderBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GNotificationsData_notifications_sender &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name &&
        avatarUrl == other.avatarUrl &&
        handle == other.handle;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, avatarUrl.hashCode);
    _$hash = $jc(_$hash, handle.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GNotificationsData_notifications_sender')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name)
          ..add('avatarUrl', avatarUrl)
          ..add('handle', handle))
        .toString();
  }
}

class GNotificationsData_notifications_senderBuilder
    implements
        Builder<GNotificationsData_notifications_sender,
            GNotificationsData_notifications_senderBuilder> {
  _$GNotificationsData_notifications_sender? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _avatarUrl;
  String? get avatarUrl => _$this._avatarUrl;
  set avatarUrl(String? avatarUrl) => _$this._avatarUrl = avatarUrl;

  String? _handle;
  String? get handle => _$this._handle;
  set handle(String? handle) => _$this._handle = handle;

  GNotificationsData_notifications_senderBuilder() {
    GNotificationsData_notifications_sender._initializeBuilder(this);
  }

  GNotificationsData_notifications_senderBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _avatarUrl = $v.avatarUrl;
      _handle = $v.handle;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GNotificationsData_notifications_sender other) {
    _$v = other as _$GNotificationsData_notifications_sender;
  }

  @override
  void update(
      void Function(GNotificationsData_notifications_senderBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GNotificationsData_notifications_sender build() => _build();

  _$GNotificationsData_notifications_sender _build() {
    final _$result = _$v ??
        _$GNotificationsData_notifications_sender._(
          G__typename: BuiltValueNullFieldError.checkNotNull(G__typename,
              r'GNotificationsData_notifications_sender', 'G__typename'),
          id: id,
          name: name,
          avatarUrl: avatarUrl,
          handle: handle,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
