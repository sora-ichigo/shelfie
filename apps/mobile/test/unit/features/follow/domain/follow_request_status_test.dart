import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/follow/domain/follow_request_status.dart';

void main() {
  group('FollowRequestStatus', () {
    test('3つの値を持つ', () {
      expect(FollowRequestStatus.values.length, equals(3));
    });

    test('pending, approved, rejected の値が定義されている', () {
      expect(FollowRequestStatus.values, contains(FollowRequestStatus.pending));
      expect(
        FollowRequestStatus.values,
        contains(FollowRequestStatus.approved),
      );
      expect(
        FollowRequestStatus.values,
        contains(FollowRequestStatus.rejected),
      );
    });
  });
}
