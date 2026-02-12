import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:shelfie/features/follow/domain/follow_request_status.dart';
import 'package:shelfie/features/follow/domain/user_summary.dart';

part 'follow_request_model.freezed.dart';

@freezed
class FollowRequestModel with _$FollowRequestModel {
  const factory FollowRequestModel({
    required int id,
    required UserSummary sender,
    required UserSummary receiver,
    required FollowRequestStatus status,
    required DateTime createdAt,
  }) = _FollowRequestModel;
}
