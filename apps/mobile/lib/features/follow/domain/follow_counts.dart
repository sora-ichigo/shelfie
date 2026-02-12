import 'package:freezed_annotation/freezed_annotation.dart';

part 'follow_counts.freezed.dart';

@freezed
class FollowCounts with _$FollowCounts {
  const factory FollowCounts({
    required int followingCount,
    required int followerCount,
  }) = _FollowCounts;
}
