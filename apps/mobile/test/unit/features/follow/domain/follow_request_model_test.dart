import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/follow/domain/follow_request_model.dart';
import 'package:shelfie/features/follow/domain/follow_request_status.dart';
import 'package:shelfie/features/follow/domain/user_summary.dart';

void main() {
  group('FollowRequestModel', () {
    final sender = UserSummary(
      id: 1,
      name: '送信者',
      avatarUrl: 'https://example.com/sender.jpg',
      handle: 'sender',
    );
    final receiver = UserSummary(
      id: 2,
      name: '受信者',
      avatarUrl: 'https://example.com/receiver.jpg',
      handle: 'receiver',
    );
    final createdAt = DateTime(2024, 6, 1, 12, 0);

    test('すべてのフィールドを持つインスタンスを作成できる', () {
      final request = FollowRequestModel(
        id: 1,
        sender: sender,
        receiver: receiver,
        status: FollowRequestStatus.pending,
        createdAt: createdAt,
      );

      expect(request.id, equals(1));
      expect(request.sender, equals(sender));
      expect(request.receiver, equals(receiver));
      expect(request.status, equals(FollowRequestStatus.pending));
      expect(request.createdAt, equals(createdAt));
    });

    test('copyWith で status を変更できる', () {
      final original = FollowRequestModel(
        id: 1,
        sender: sender,
        receiver: receiver,
        status: FollowRequestStatus.pending,
        createdAt: createdAt,
      );

      final updated = original.copyWith(status: FollowRequestStatus.approved);

      expect(updated.id, equals(original.id));
      expect(updated.sender, equals(original.sender));
      expect(updated.receiver, equals(original.receiver));
      expect(updated.status, equals(FollowRequestStatus.approved));
      expect(updated.createdAt, equals(original.createdAt));
    });

    test('同じ値を持つインスタンスは等価である', () {
      final request1 = FollowRequestModel(
        id: 1,
        sender: sender,
        receiver: receiver,
        status: FollowRequestStatus.pending,
        createdAt: createdAt,
      );
      final request2 = FollowRequestModel(
        id: 1,
        sender: sender,
        receiver: receiver,
        status: FollowRequestStatus.pending,
        createdAt: createdAt,
      );

      expect(request1, equals(request2));
      expect(request1.hashCode, equals(request2.hashCode));
    });
  });
}
