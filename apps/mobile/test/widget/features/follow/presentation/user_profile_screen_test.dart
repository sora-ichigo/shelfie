import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/follow/application/follow_request_notifier.dart';
import 'package:shelfie/features/follow/domain/follow_counts.dart';
import 'package:shelfie/features/follow/domain/follow_status_type.dart';
import 'package:shelfie/features/follow/domain/user_profile_model.dart';
import 'package:shelfie/features/follow/domain/user_summary.dart';
import 'package:shelfie/features/follow/presentation/user_profile_screen.dart';

import '../../../../helpers/test_helpers.dart';

class FakeFollowRequestNotifier extends FollowRequestNotifier {
  AsyncValue<FollowStatusType> _state =
      const AsyncData(FollowStatusType.none);
  bool sendFollowRequestCalled = false;
  bool cancelFollowRequestCalled = false;
  bool unfollowCalled = false;

  void setState(AsyncValue<FollowStatusType> value) {
    _state = value;
    state = value;
  }

  @override
  AsyncValue<FollowStatusType> build(int targetUserId) {
    return _state;
  }

  @override
  void setStatus(FollowStatusType status) {
    state = AsyncData(status);
  }

  @override
  Future<void> sendFollowRequest() async {
    sendFollowRequestCalled = true;
  }

  @override
  Future<void> cancelFollowRequest() async {
    cancelFollowRequestCalled = true;
  }

  @override
  Future<void> unfollow() async {
    unfollowCalled = true;
  }
}

UserProfileModel _createProfile({
  int userId = 10,
  String name = 'TestUser',
  String handle = 'testuser',
  FollowStatusType followStatus = FollowStatusType.none,
  bool isOwnProfile = false,
  String? bio,
  int? bookCount,
  int followingCount = 5,
  int followerCount = 3,
}) {
  return UserProfileModel(
    user: UserSummary(
      id: userId,
      name: name,
      avatarUrl: null,
      handle: handle,
    ),
    followStatus: followStatus,
    followCounts: FollowCounts(
      followingCount: followingCount,
      followerCount: followerCount,
    ),
    isOwnProfile: isOwnProfile,
    bio: bio,
    bookCount: bookCount,
  );
}

void main() {
  setUpAll(registerTestFallbackValues);

  late FakeFollowRequestNotifier fakeNotifier;

  setUp(() {
    fakeNotifier = FakeFollowRequestNotifier();
  });

  Widget buildSubject({required UserProfileModel profile}) {
    return ProviderScope(
      overrides: [
        followRequestNotifierProvider(profile.user.id)
            .overrideWith(() => fakeNotifier),
      ],
      child: MaterialApp(
        theme: AppTheme.theme,
        home: UserProfileScreen(profile: profile),
      ),
    );
  }

  group('UserProfileScreen', () {
    testWidgets('ユーザー名とハンドルが表示される', (tester) async {
      final profile = _createProfile();
      await tester.pumpWidget(buildSubject(profile: profile));
      await tester.pump();

      expect(find.text('TestUser'), findsOneWidget);
      expect(find.text('@testuser'), findsOneWidget);
    });

    group('フォロー関係なし', () {
      testWidgets('プロフィール情報が表示される', (tester) async {
        final profile = _createProfile(
          followStatus: FollowStatusType.none,
          bio: 'I love reading!',
          bookCount: 42,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        expect(find.text('TestUser'), findsOneWidget);
        expect(find.text('@testuser'), findsOneWidget);
        expect(find.text('I love reading!'), findsOneWidget);
        expect(find.text('42 '), findsOneWidget);
        expect(find.text('5 '), findsOneWidget);
        expect(find.text('3 '), findsOneWidget);
      });

      testWidgets('フォローリクエスト送信ボタンが表示される', (tester) async {
        final profile = _createProfile(
          followStatus: FollowStatusType.none,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        expect(find.text('フォロー'), findsOneWidget);
      });

      testWidgets('フォローリクエスト送信ボタンタップで sendFollowRequest が呼ばれる',
          (tester) async {
        final profile = _createProfile(
          followStatus: FollowStatusType.none,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        await tester.tap(find.text('フォロー'));
        await tester.pump();

        expect(fakeNotifier.sendFollowRequestCalled, isTrue);
      });
    });

    group('リクエスト送信済み', () {
      testWidgets('リクエスト送信済み状態が表示される', (tester) async {
        fakeNotifier = FakeFollowRequestNotifier();
        final profile = _createProfile(
          followStatus: FollowStatusType.pendingSent,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        fakeNotifier.setState(
            const AsyncData(FollowStatusType.pendingSent));
        await tester.pump();

        expect(find.text('リクエスト送信済み'), findsOneWidget);
      });

      testWidgets('リクエスト送信済みボタンタップで cancelFollowRequest が呼ばれる', (tester) async {
        fakeNotifier = FakeFollowRequestNotifier();
        final profile = _createProfile(
          followStatus: FollowStatusType.pendingSent,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        fakeNotifier.setState(
            const AsyncData(FollowStatusType.pendingSent));
        await tester.pump();

        await tester.tap(find.text('リクエスト送信済み'));
        await tester.pump();

        expect(fakeNotifier.cancelFollowRequestCalled, isTrue);
      });
    });

    group('フォロー関係あり', () {
      testWidgets('フルプロフィールが表示される', (tester) async {
        fakeNotifier = FakeFollowRequestNotifier();
        final profile = _createProfile(
          followStatus: FollowStatusType.following,
          bio: 'I love reading!',
          bookCount: 42,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        fakeNotifier.setState(
            const AsyncData(FollowStatusType.following));
        await tester.pump();

        expect(find.text('TestUser'), findsOneWidget);
        expect(find.text('I love reading!'), findsOneWidget);
        expect(find.text('5 '), findsOneWidget);
        expect(find.text('3 '), findsOneWidget);
      });

      testWidgets('フォロー解除ボタンが表示される', (tester) async {
        fakeNotifier = FakeFollowRequestNotifier();
        final profile = _createProfile(
          followStatus: FollowStatusType.following,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        fakeNotifier.setState(
            const AsyncData(FollowStatusType.following));
        await tester.pump();

        expect(find.text('フォロー解除'), findsOneWidget);
      });

      testWidgets('フォロー解除ボタンタップで unfollow が呼ばれる', (tester) async {
        fakeNotifier = FakeFollowRequestNotifier();
        final profile = _createProfile(
          followStatus: FollowStatusType.following,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        fakeNotifier.setState(
            const AsyncData(FollowStatusType.following));
        await tester.pump();

        await tester.tap(find.text('フォロー解除'));
        await tester.pump();

        expect(fakeNotifier.unfollowCalled, isTrue);
      });
    });

    group('自分のプロフィール', () {
      testWidgets('フォロー操作ボタンが非表示', (tester) async {
        final profile = _createProfile(
          isOwnProfile: true,
          followStatus: FollowStatusType.following,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        expect(find.text('フォロー'), findsNothing);
        expect(find.text('フォロー解除'), findsNothing);
        expect(find.text('リクエスト送信済み'), findsNothing);
      });
    });
  });
}
