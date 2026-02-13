// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserProfileModel {
  UserSummary get user => throw _privateConstructorUsedError;
  FollowStatusType get outgoingFollowStatus =>
      throw _privateConstructorUsedError;
  FollowStatusType get incomingFollowStatus =>
      throw _privateConstructorUsedError;
  FollowCounts get followCounts => throw _privateConstructorUsedError;
  bool get isOwnProfile => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get instagramHandle => throw _privateConstructorUsedError;
  int? get bookCount => throw _privateConstructorUsedError;

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileModelCopyWith<UserProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileModelCopyWith<$Res> {
  factory $UserProfileModelCopyWith(
          UserProfileModel value, $Res Function(UserProfileModel) then) =
      _$UserProfileModelCopyWithImpl<$Res, UserProfileModel>;
  @useResult
  $Res call(
      {UserSummary user,
      FollowStatusType outgoingFollowStatus,
      FollowStatusType incomingFollowStatus,
      FollowCounts followCounts,
      bool isOwnProfile,
      String? bio,
      String? instagramHandle,
      int? bookCount});

  $UserSummaryCopyWith<$Res> get user;
  $FollowCountsCopyWith<$Res> get followCounts;
}

/// @nodoc
class _$UserProfileModelCopyWithImpl<$Res, $Val extends UserProfileModel>
    implements $UserProfileModelCopyWith<$Res> {
  _$UserProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? outgoingFollowStatus = null,
    Object? incomingFollowStatus = null,
    Object? followCounts = null,
    Object? isOwnProfile = null,
    Object? bio = freezed,
    Object? instagramHandle = freezed,
    Object? bookCount = freezed,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserSummary,
      outgoingFollowStatus: null == outgoingFollowStatus
          ? _value.outgoingFollowStatus
          : outgoingFollowStatus // ignore: cast_nullable_to_non_nullable
              as FollowStatusType,
      incomingFollowStatus: null == incomingFollowStatus
          ? _value.incomingFollowStatus
          : incomingFollowStatus // ignore: cast_nullable_to_non_nullable
              as FollowStatusType,
      followCounts: null == followCounts
          ? _value.followCounts
          : followCounts // ignore: cast_nullable_to_non_nullable
              as FollowCounts,
      isOwnProfile: null == isOwnProfile
          ? _value.isOwnProfile
          : isOwnProfile // ignore: cast_nullable_to_non_nullable
              as bool,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      instagramHandle: freezed == instagramHandle
          ? _value.instagramHandle
          : instagramHandle // ignore: cast_nullable_to_non_nullable
              as String?,
      bookCount: freezed == bookCount
          ? _value.bookCount
          : bookCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSummaryCopyWith<$Res> get user {
    return $UserSummaryCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FollowCountsCopyWith<$Res> get followCounts {
    return $FollowCountsCopyWith<$Res>(_value.followCounts, (value) {
      return _then(_value.copyWith(followCounts: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserProfileModelImplCopyWith<$Res>
    implements $UserProfileModelCopyWith<$Res> {
  factory _$$UserProfileModelImplCopyWith(_$UserProfileModelImpl value,
          $Res Function(_$UserProfileModelImpl) then) =
      __$$UserProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UserSummary user,
      FollowStatusType outgoingFollowStatus,
      FollowStatusType incomingFollowStatus,
      FollowCounts followCounts,
      bool isOwnProfile,
      String? bio,
      String? instagramHandle,
      int? bookCount});

  @override
  $UserSummaryCopyWith<$Res> get user;
  @override
  $FollowCountsCopyWith<$Res> get followCounts;
}

/// @nodoc
class __$$UserProfileModelImplCopyWithImpl<$Res>
    extends _$UserProfileModelCopyWithImpl<$Res, _$UserProfileModelImpl>
    implements _$$UserProfileModelImplCopyWith<$Res> {
  __$$UserProfileModelImplCopyWithImpl(_$UserProfileModelImpl _value,
      $Res Function(_$UserProfileModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? outgoingFollowStatus = null,
    Object? incomingFollowStatus = null,
    Object? followCounts = null,
    Object? isOwnProfile = null,
    Object? bio = freezed,
    Object? instagramHandle = freezed,
    Object? bookCount = freezed,
  }) {
    return _then(_$UserProfileModelImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserSummary,
      outgoingFollowStatus: null == outgoingFollowStatus
          ? _value.outgoingFollowStatus
          : outgoingFollowStatus // ignore: cast_nullable_to_non_nullable
              as FollowStatusType,
      incomingFollowStatus: null == incomingFollowStatus
          ? _value.incomingFollowStatus
          : incomingFollowStatus // ignore: cast_nullable_to_non_nullable
              as FollowStatusType,
      followCounts: null == followCounts
          ? _value.followCounts
          : followCounts // ignore: cast_nullable_to_non_nullable
              as FollowCounts,
      isOwnProfile: null == isOwnProfile
          ? _value.isOwnProfile
          : isOwnProfile // ignore: cast_nullable_to_non_nullable
              as bool,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      instagramHandle: freezed == instagramHandle
          ? _value.instagramHandle
          : instagramHandle // ignore: cast_nullable_to_non_nullable
              as String?,
      bookCount: freezed == bookCount
          ? _value.bookCount
          : bookCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$UserProfileModelImpl implements _UserProfileModel {
  const _$UserProfileModelImpl(
      {required this.user,
      required this.outgoingFollowStatus,
      required this.incomingFollowStatus,
      required this.followCounts,
      required this.isOwnProfile,
      this.bio,
      this.instagramHandle,
      this.bookCount});

  @override
  final UserSummary user;
  @override
  final FollowStatusType outgoingFollowStatus;
  @override
  final FollowStatusType incomingFollowStatus;
  @override
  final FollowCounts followCounts;
  @override
  final bool isOwnProfile;
  @override
  final String? bio;
  @override
  final String? instagramHandle;
  @override
  final int? bookCount;

  @override
  String toString() {
    return 'UserProfileModel(user: $user, outgoingFollowStatus: $outgoingFollowStatus, incomingFollowStatus: $incomingFollowStatus, followCounts: $followCounts, isOwnProfile: $isOwnProfile, bio: $bio, instagramHandle: $instagramHandle, bookCount: $bookCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileModelImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.outgoingFollowStatus, outgoingFollowStatus) ||
                other.outgoingFollowStatus == outgoingFollowStatus) &&
            (identical(other.incomingFollowStatus, incomingFollowStatus) ||
                other.incomingFollowStatus == incomingFollowStatus) &&
            (identical(other.followCounts, followCounts) ||
                other.followCounts == followCounts) &&
            (identical(other.isOwnProfile, isOwnProfile) ||
                other.isOwnProfile == isOwnProfile) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.instagramHandle, instagramHandle) ||
                other.instagramHandle == instagramHandle) &&
            (identical(other.bookCount, bookCount) ||
                other.bookCount == bookCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      user,
      outgoingFollowStatus,
      incomingFollowStatus,
      followCounts,
      isOwnProfile,
      bio,
      instagramHandle,
      bookCount);

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileModelImplCopyWith<_$UserProfileModelImpl> get copyWith =>
      __$$UserProfileModelImplCopyWithImpl<_$UserProfileModelImpl>(
          this, _$identity);
}

abstract class _UserProfileModel implements UserProfileModel {
  const factory _UserProfileModel(
      {required final UserSummary user,
      required final FollowStatusType outgoingFollowStatus,
      required final FollowStatusType incomingFollowStatus,
      required final FollowCounts followCounts,
      required final bool isOwnProfile,
      final String? bio,
      final String? instagramHandle,
      final int? bookCount}) = _$UserProfileModelImpl;

  @override
  UserSummary get user;
  @override
  FollowStatusType get outgoingFollowStatus;
  @override
  FollowStatusType get incomingFollowStatus;
  @override
  FollowCounts get followCounts;
  @override
  bool get isOwnProfile;
  @override
  String? get bio;
  @override
  String? get instagramHandle;
  @override
  int? get bookCount;

  /// Create a copy of UserProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileModelImplCopyWith<_$UserProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
