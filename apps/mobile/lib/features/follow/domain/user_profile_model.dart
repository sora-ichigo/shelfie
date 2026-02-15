import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:shelfie/features/follow/domain/follow_counts.dart';
import 'package:shelfie/features/follow/domain/follow_status_type.dart';
import 'package:shelfie/features/follow/domain/user_summary.dart';

part 'user_profile_model.freezed.dart';

@freezed
class UserProfileModel with _$UserProfileModel {
  const factory UserProfileModel({
    required UserSummary user,
    required FollowStatusType outgoingFollowStatus,
    required FollowStatusType incomingFollowStatus,
    required FollowCounts followCounts,
    required bool isOwnProfile,
    String? bio,
    String? instagramHandle,
    String? shareUrl,
    int? bookCount,
  }) = _UserProfileModel;
}
