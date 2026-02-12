import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:shelfie/features/follow/domain/user_summary.dart';
import 'package:shelfie/features/notification/domain/notification_type.dart';

part 'notification_model.freezed.dart';

@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required int id,
    required UserSummary sender,
    required NotificationType type,
    required bool isRead,
    required DateTime createdAt,
  }) = _NotificationModel;
}
