import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/follow/domain/follow_counts.dart';

void main() {
  group('FollowCounts', () {
    test('すべてのフィールドを持つインスタンスを作成できる', () {
      final counts = FollowCounts(followingCount: 10, followerCount: 20);

      expect(counts.followingCount, equals(10));
      expect(counts.followerCount, equals(20));
    });

    test('copyWith で一部のフィールドを変更できる', () {
      final original = FollowCounts(followingCount: 10, followerCount: 20);

      final updated = original.copyWith(followingCount: 15);

      expect(updated.followingCount, equals(15));
      expect(updated.followerCount, equals(original.followerCount));
    });

    test('同じ値を持つインスタンスは等価である', () {
      final counts1 = FollowCounts(followingCount: 10, followerCount: 20);
      final counts2 = FollowCounts(followingCount: 10, followerCount: 20);

      expect(counts1, equals(counts2));
      expect(counts1.hashCode, equals(counts2.hashCode));
    });

    test('異なる値を持つインスタンスは等価でない', () {
      final counts1 = FollowCounts(followingCount: 10, followerCount: 20);
      final counts2 = FollowCounts(followingCount: 5, followerCount: 30);

      expect(counts1, isNot(equals(counts2)));
    });
  });
}
