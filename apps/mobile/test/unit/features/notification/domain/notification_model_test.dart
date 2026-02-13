import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/follow/domain/follow_status_type.dart';
import 'package:shelfie/features/follow/domain/user_summary.dart';
import 'package:shelfie/features/notification/domain/notification_model.dart';
import 'package:shelfie/features/notification/domain/notification_type.dart';

void main() {
  group('NotificationModel', () {
    final sender = UserSummary(
      id: 1,
      name: '送信者',
      avatarUrl: 'https://example.com/avatar.jpg',
      handle: 'sender',
    );
    final createdAt = DateTime(2024, 6, 1, 12, 0);

    test('すべてのフィールドを持つインスタンスを作成できる', () {
      final notification = NotificationModel(
        id: 1,
        sender: sender,
        type: NotificationType.followRequestReceived,
        followStatus: FollowStatusType.pendingReceived,
        isRead: false,
        createdAt: createdAt,
      );

      expect(notification.id, equals(1));
      expect(notification.sender, equals(sender));
      expect(notification.type, equals(NotificationType.followRequestReceived));
      expect(notification.isRead, isFalse);
      expect(notification.createdAt, equals(createdAt));
    });

    test('copyWith で isRead を変更できる', () {
      final original = NotificationModel(
        id: 1,
        sender: sender,
        type: NotificationType.followRequestReceived,
        followStatus: FollowStatusType.pendingReceived,
        isRead: false,
        createdAt: createdAt,
      );

      final updated = original.copyWith(isRead: true);

      expect(updated.id, equals(original.id));
      expect(updated.sender, equals(original.sender));
      expect(updated.type, equals(original.type));
      expect(updated.isRead, isTrue);
      expect(updated.createdAt, equals(original.createdAt));
    });

    test('同じ値を持つインスタンスは等価である', () {
      final notification1 = NotificationModel(
        id: 1,
        sender: sender,
        type: NotificationType.followRequestApproved,
        followStatus: FollowStatusType.following,
        isRead: true,
        createdAt: createdAt,
      );
      final notification2 = NotificationModel(
        id: 1,
        sender: sender,
        type: NotificationType.followRequestApproved,
        followStatus: FollowStatusType.following,
        isRead: true,
        createdAt: createdAt,
      );

      expect(notification1, equals(notification2));
      expect(notification1.hashCode, equals(notification2.hashCode));
    });
  });
}
