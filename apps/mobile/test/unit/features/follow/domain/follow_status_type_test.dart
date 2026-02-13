import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/follow/domain/follow_status_type.dart';

void main() {
  group('FollowStatusType', () {
    test('3つの値を持つ', () {
      expect(FollowStatusType.values.length, equals(3));
    });

    test('none, pending, following の値が定義されている', () {
      expect(FollowStatusType.values, contains(FollowStatusType.none));
      expect(FollowStatusType.values, contains(FollowStatusType.pending));
      expect(FollowStatusType.values, contains(FollowStatusType.following));
    });
  });
}
