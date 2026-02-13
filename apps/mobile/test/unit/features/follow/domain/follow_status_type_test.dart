import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/follow/domain/follow_status_type.dart';

void main() {
  group('FollowStatusType', () {
    test('5つの値を持つ', () {
      expect(FollowStatusType.values.length, equals(5));
    });

    test('すべての値が定義されている', () {
      expect(FollowStatusType.values, contains(FollowStatusType.none));
      expect(FollowStatusType.values, contains(FollowStatusType.pendingSent));
      expect(
          FollowStatusType.values, contains(FollowStatusType.pendingReceived));
      expect(FollowStatusType.values, contains(FollowStatusType.following));
      expect(FollowStatusType.values, contains(FollowStatusType.followedBy));
    });
  });
}
