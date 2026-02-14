import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/follow/domain/follow_counts.dart';
import 'package:shelfie/features/follow/domain/follow_status_type.dart';
import 'package:shelfie/features/follow/domain/user_profile_model.dart';
import 'package:shelfie/features/follow/domain/user_summary.dart';

void main() {
  group('UserProfileModel', () {
    final user = UserSummary(
      id: 1,
      name: 'テストユーザー',
      avatarUrl: 'https://example.com/avatar.jpg',
      handle: 'testuser',
    );
    final followCounts = FollowCounts(followingCount: 10, followerCount: 20);

    test('すべてのフィールドを持つインスタンスを作成できる', () {
      final profile = UserProfileModel(
        user: user,
        outgoingFollowStatus: FollowStatusType.following,
        incomingFollowStatus: FollowStatusType.none,
        followCounts: followCounts,
        isOwnProfile: false,
        bio: '自己紹介テキスト',
        instagramHandle: 'test_insta',
        bookCount: 42,
      );

      expect(profile.user, equals(user));
      expect(profile.outgoingFollowStatus, equals(FollowStatusType.following));
      expect(profile.incomingFollowStatus, equals(FollowStatusType.none));
      expect(profile.followCounts, equals(followCounts));
      expect(profile.isOwnProfile, isFalse);
      expect(profile.bio, equals('自己紹介テキスト'));
      expect(profile.instagramHandle, equals('test_insta'));
      expect(profile.bookCount, equals(42));
    });

    test('optional フィールドは null を許容する', () {
      final profile = UserProfileModel(
        user: user,
        outgoingFollowStatus: FollowStatusType.none,
        incomingFollowStatus: FollowStatusType.none,
        followCounts: followCounts,
        isOwnProfile: true,
      );

      expect(profile.bio, isNull);
      expect(profile.instagramHandle, isNull);
      expect(profile.bookCount, isNull);
    });

    test('copyWith で outgoingFollowStatus を変更できる', () {
      final original = UserProfileModel(
        user: user,
        outgoingFollowStatus: FollowStatusType.none,
        incomingFollowStatus: FollowStatusType.none,
        followCounts: followCounts,
        isOwnProfile: false,
      );

      final updated = original.copyWith(
        outgoingFollowStatus: FollowStatusType.pendingSent,
      );

      expect(updated.user, equals(original.user));
      expect(updated.outgoingFollowStatus, equals(FollowStatusType.pendingSent));
      expect(updated.incomingFollowStatus, equals(FollowStatusType.none));
      expect(updated.followCounts, equals(original.followCounts));
      expect(updated.isOwnProfile, equals(original.isOwnProfile));
    });

    test('copyWith で incomingFollowStatus を変更できる', () {
      final original = UserProfileModel(
        user: user,
        outgoingFollowStatus: FollowStatusType.none,
        incomingFollowStatus: FollowStatusType.none,
        followCounts: followCounts,
        isOwnProfile: false,
      );

      final updated = original.copyWith(
        incomingFollowStatus: FollowStatusType.following,
      );

      expect(updated.outgoingFollowStatus, equals(FollowStatusType.none));
      expect(updated.incomingFollowStatus, equals(FollowStatusType.following));
    });

    test('同じ値を持つインスタンスは等価である', () {
      final profile1 = UserProfileModel(
        user: user,
        outgoingFollowStatus: FollowStatusType.following,
        incomingFollowStatus: FollowStatusType.none,
        followCounts: followCounts,
        isOwnProfile: false,
      );
      final profile2 = UserProfileModel(
        user: user,
        outgoingFollowStatus: FollowStatusType.following,
        incomingFollowStatus: FollowStatusType.none,
        followCounts: followCounts,
        isOwnProfile: false,
      );

      expect(profile1, equals(profile2));
      expect(profile1.hashCode, equals(profile2.hashCode));
    });
  });
}
