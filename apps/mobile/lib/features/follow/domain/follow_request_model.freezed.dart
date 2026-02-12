// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'follow_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FollowRequestModel {
  int get id => throw _privateConstructorUsedError;
  UserSummary get sender => throw _privateConstructorUsedError;
  UserSummary get receiver => throw _privateConstructorUsedError;
  FollowRequestStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of FollowRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FollowRequestModelCopyWith<FollowRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FollowRequestModelCopyWith<$Res> {
  factory $FollowRequestModelCopyWith(
          FollowRequestModel value, $Res Function(FollowRequestModel) then) =
      _$FollowRequestModelCopyWithImpl<$Res, FollowRequestModel>;
  @useResult
  $Res call(
      {int id,
      UserSummary sender,
      UserSummary receiver,
      FollowRequestStatus status,
      DateTime createdAt});

  $UserSummaryCopyWith<$Res> get sender;
  $UserSummaryCopyWith<$Res> get receiver;
}

/// @nodoc
class _$FollowRequestModelCopyWithImpl<$Res, $Val extends FollowRequestModel>
    implements $FollowRequestModelCopyWith<$Res> {
  _$FollowRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FollowRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sender = null,
    Object? receiver = null,
    Object? status = null,
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
      receiver: null == receiver
          ? _value.receiver
          : receiver // ignore: cast_nullable_to_non_nullable
              as UserSummary,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FollowRequestStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of FollowRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSummaryCopyWith<$Res> get sender {
    return $UserSummaryCopyWith<$Res>(_value.sender, (value) {
      return _then(_value.copyWith(sender: value) as $Val);
    });
  }

  /// Create a copy of FollowRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSummaryCopyWith<$Res> get receiver {
    return $UserSummaryCopyWith<$Res>(_value.receiver, (value) {
      return _then(_value.copyWith(receiver: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FollowRequestModelImplCopyWith<$Res>
    implements $FollowRequestModelCopyWith<$Res> {
  factory _$$FollowRequestModelImplCopyWith(_$FollowRequestModelImpl value,
          $Res Function(_$FollowRequestModelImpl) then) =
      __$$FollowRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      UserSummary sender,
      UserSummary receiver,
      FollowRequestStatus status,
      DateTime createdAt});

  @override
  $UserSummaryCopyWith<$Res> get sender;
  @override
  $UserSummaryCopyWith<$Res> get receiver;
}

/// @nodoc
class __$$FollowRequestModelImplCopyWithImpl<$Res>
    extends _$FollowRequestModelCopyWithImpl<$Res, _$FollowRequestModelImpl>
    implements _$$FollowRequestModelImplCopyWith<$Res> {
  __$$FollowRequestModelImplCopyWithImpl(_$FollowRequestModelImpl _value,
      $Res Function(_$FollowRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FollowRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sender = null,
    Object? receiver = null,
    Object? status = null,
    Object? createdAt = null,
  }) {
    return _then(_$FollowRequestModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as UserSummary,
      receiver: null == receiver
          ? _value.receiver
          : receiver // ignore: cast_nullable_to_non_nullable
              as UserSummary,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FollowRequestStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$FollowRequestModelImpl implements _FollowRequestModel {
  const _$FollowRequestModelImpl(
      {required this.id,
      required this.sender,
      required this.receiver,
      required this.status,
      required this.createdAt});

  @override
  final int id;
  @override
  final UserSummary sender;
  @override
  final UserSummary receiver;
  @override
  final FollowRequestStatus status;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'FollowRequestModel(id: $id, sender: $sender, receiver: $receiver, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FollowRequestModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.receiver, receiver) ||
                other.receiver == receiver) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, sender, receiver, status, createdAt);

  /// Create a copy of FollowRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FollowRequestModelImplCopyWith<_$FollowRequestModelImpl> get copyWith =>
      __$$FollowRequestModelImplCopyWithImpl<_$FollowRequestModelImpl>(
          this, _$identity);
}

abstract class _FollowRequestModel implements FollowRequestModel {
  const factory _FollowRequestModel(
      {required final int id,
      required final UserSummary sender,
      required final UserSummary receiver,
      required final FollowRequestStatus status,
      required final DateTime createdAt}) = _$FollowRequestModelImpl;

  @override
  int get id;
  @override
  UserSummary get sender;
  @override
  UserSummary get receiver;
  @override
  FollowRequestStatus get status;
  @override
  DateTime get createdAt;

  /// Create a copy of FollowRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FollowRequestModelImplCopyWith<_$FollowRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
