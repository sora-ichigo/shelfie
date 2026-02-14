// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NotificationModel {
  int get id => throw _privateConstructorUsedError;
  UserSummary get sender => throw _privateConstructorUsedError;
  NotificationType get type => throw _privateConstructorUsedError;
  FollowStatusType get outgoingFollowStatus =>
      throw _privateConstructorUsedError;
  FollowStatusType get incomingFollowStatus =>
      throw _privateConstructorUsedError;
  int? get followRequestId => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of NotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationModelCopyWith<NotificationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationModelCopyWith<$Res> {
  factory $NotificationModelCopyWith(
          NotificationModel value, $Res Function(NotificationModel) then) =
      _$NotificationModelCopyWithImpl<$Res, NotificationModel>;
  @useResult
  $Res call(
      {int id,
      UserSummary sender,
      NotificationType type,
      FollowStatusType outgoingFollowStatus,
      FollowStatusType incomingFollowStatus,
      int? followRequestId,
      bool isRead,
      DateTime createdAt});

  $UserSummaryCopyWith<$Res> get sender;
}

/// @nodoc
class _$NotificationModelCopyWithImpl<$Res, $Val extends NotificationModel>
    implements $NotificationModelCopyWith<$Res> {
  _$NotificationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sender = null,
    Object? type = null,
    Object? outgoingFollowStatus = null,
    Object? incomingFollowStatus = null,
    Object? followRequestId = freezed,
    Object? isRead = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as UserSummary,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      outgoingFollowStatus: null == outgoingFollowStatus
          ? _value.outgoingFollowStatus
          : outgoingFollowStatus // ignore: cast_nullable_to_non_nullable
              as FollowStatusType,
      incomingFollowStatus: null == incomingFollowStatus
          ? _value.incomingFollowStatus
          : incomingFollowStatus // ignore: cast_nullable_to_non_nullable
              as FollowStatusType,
      followRequestId: freezed == followRequestId
          ? _value.followRequestId
          : followRequestId // ignore: cast_nullable_to_non_nullable
              as int?,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of NotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSummaryCopyWith<$Res> get sender {
    return $UserSummaryCopyWith<$Res>(_value.sender, (value) {
      return _then(_value.copyWith(sender: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NotificationModelImplCopyWith<$Res>
    implements $NotificationModelCopyWith<$Res> {
  factory _$$NotificationModelImplCopyWith(_$NotificationModelImpl value,
          $Res Function(_$NotificationModelImpl) then) =
      __$$NotificationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      UserSummary sender,
      NotificationType type,
      FollowStatusType outgoingFollowStatus,
      FollowStatusType incomingFollowStatus,
      int? followRequestId,
      bool isRead,
      DateTime createdAt});

  @override
  $UserSummaryCopyWith<$Res> get sender;
}

/// @nodoc
class __$$NotificationModelImplCopyWithImpl<$Res>
    extends _$NotificationModelCopyWithImpl<$Res, _$NotificationModelImpl>
    implements _$$NotificationModelImplCopyWith<$Res> {
  __$$NotificationModelImplCopyWithImpl(_$NotificationModelImpl _value,
      $Res Function(_$NotificationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sender = null,
    Object? type = null,
    Object? outgoingFollowStatus = null,
    Object? incomingFollowStatus = null,
    Object? followRequestId = freezed,
    Object? isRead = null,
    Object? createdAt = null,
  }) {
    return _then(_$NotificationModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as UserSummary,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      outgoingFollowStatus: null == outgoingFollowStatus
          ? _value.outgoingFollowStatus
          : outgoingFollowStatus // ignore: cast_nullable_to_non_nullable
              as FollowStatusType,
      incomingFollowStatus: null == incomingFollowStatus
          ? _value.incomingFollowStatus
          : incomingFollowStatus // ignore: cast_nullable_to_non_nullable
              as FollowStatusType,
      followRequestId: freezed == followRequestId
          ? _value.followRequestId
          : followRequestId // ignore: cast_nullable_to_non_nullable
              as int?,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$NotificationModelImpl implements _NotificationModel {
  const _$NotificationModelImpl(
      {required this.id,
      required this.sender,
      required this.type,
      required this.outgoingFollowStatus,
      required this.incomingFollowStatus,
      required this.followRequestId,
      required this.isRead,
      required this.createdAt});

  @override
  final int id;
  @override
  final UserSummary sender;
  @override
  final NotificationType type;
  @override
  final FollowStatusType outgoingFollowStatus;
  @override
  final FollowStatusType incomingFollowStatus;
  @override
  final int? followRequestId;
  @override
  final bool isRead;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'NotificationModel(id: $id, sender: $sender, type: $type, outgoingFollowStatus: $outgoingFollowStatus, incomingFollowStatus: $incomingFollowStatus, followRequestId: $followRequestId, isRead: $isRead, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.outgoingFollowStatus, outgoingFollowStatus) ||
                other.outgoingFollowStatus == outgoingFollowStatus) &&
            (identical(other.incomingFollowStatus, incomingFollowStatus) ||
                other.incomingFollowStatus == incomingFollowStatus) &&
            (identical(other.followRequestId, followRequestId) ||
                other.followRequestId == followRequestId) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      sender,
      type,
      outgoingFollowStatus,
      incomingFollowStatus,
      followRequestId,
      isRead,
      createdAt);

  /// Create a copy of NotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationModelImplCopyWith<_$NotificationModelImpl> get copyWith =>
      __$$NotificationModelImplCopyWithImpl<_$NotificationModelImpl>(
          this, _$identity);
}

abstract class _NotificationModel implements NotificationModel {
  const factory _NotificationModel(
      {required final int id,
      required final UserSummary sender,
      required final NotificationType type,
      required final FollowStatusType outgoingFollowStatus,
      required final FollowStatusType incomingFollowStatus,
      required final int? followRequestId,
      required final bool isRead,
      required final DateTime createdAt}) = _$NotificationModelImpl;

  @override
  int get id;
  @override
  UserSummary get sender;
  @override
  NotificationType get type;
  @override
  FollowStatusType get outgoingFollowStatus;
  @override
  FollowStatusType get incomingFollowStatus;
  @override
  int? get followRequestId;
  @override
  bool get isRead;
  @override
  DateTime get createdAt;

  /// Create a copy of NotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationModelImplCopyWith<_$NotificationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
