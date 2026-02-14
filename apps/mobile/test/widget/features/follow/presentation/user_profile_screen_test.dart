import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/state/follow_state_notifier.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_tab_bar.dart';
import 'package:shelfie/features/follow/application/follow_counts_notifier.dart';
import 'package:shelfie/features/follow/application/user_profile_book_lists_notifier.dart';
import 'package:shelfie/features/follow/application/user_profile_books_notifier.dart';
import 'package:shelfie/features/follow/domain/follow_counts.dart';
import 'package:shelfie/features/follow/domain/follow_status_type.dart';
import 'package:shelfie/features/follow/domain/user_profile_model.dart';
import 'package:shelfie/features/follow/domain/user_summary.dart';
import 'package:shelfie/features/follow/presentation/user_profile_screen.dart';

import '../../../../helpers/test_helpers.dart';

class FakeFollowStateNotifier extends FollowState {
  bool sendFollowRequestCalled = false;
  bool cancelFollowRequestCalled = false;
  bool unfollowCalled = false;
  int? lastUserId;

  @override
  Map<int, FollowDirectionalStatus> build() => {};

  @override
  Future<void> sendFollowRequest({required int userId}) async {
    sendFollowRequestCalled = true;
    lastUserId = userId;
  }

  @override
  Future<void> cancelFollowRequest({required int userId}) async {
    cancelFollowRequestCalled = true;
    lastUserId = userId;
  }

  @override
  Future<void> unfollow({required int userId}) async {
    unfollowCalled = true;
    lastUserId = userId;
  }
}

class FakeUserProfileBooksNotifier extends UserProfileBooksNotifier {
  @override
  UserProfileBooksState build(int userId) {
    return const UserProfileBooksState();
  }
}

class FakeUserProfileBookListsNotifier extends UserProfileBookListsNotifier {
  @override
  UserProfileBookListsState build(int userId) {
    return const UserProfileBookListsState();
  }

  @override
  Future<void> loadLists() async {}
}

class FakeFollowCountsNotifier extends FollowCountsNotifier {
  FakeFollowCountsNotifier(this._counts);

  final FollowCounts _counts;

  @override
  Future<FollowCounts> build(int userId) async => _counts;
}

UserProfileModel _createProfile({
  int userId = 10,
  String name = 'TestUser',
  String handle = 'testuser',
  FollowStatusType outgoingFollowStatus = FollowStatusType.none,
  FollowStatusType incomingFollowStatus = FollowStatusType.none,
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
    outgoingFollowStatus: outgoingFollowStatus,
    incomingFollowStatus: incomingFollowStatus,
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

  late FakeFollowStateNotifier fakeNotifier;

  setUp(() {
    fakeNotifier = FakeFollowStateNotifier();
  });

  Widget buildSubject({
    required UserProfileModel profile,
    FollowCounts? overrideCounts,
  }) {
    final counts = overrideCounts ?? profile.followCounts;
    return ProviderScope(
      overrides: [
        followStateProvider.overrideWith(() => fakeNotifier),
        followCountsNotifierProvider(profile.user.id)
            .overrideWith(() => FakeFollowCountsNotifier(counts)),
        userProfileBooksNotifierProvider(profile.user.id)
            .overrideWith(() => FakeUserProfileBooksNotifier()),
        userProfileBookListsNotifierProvider(profile.user.id)
            .overrideWith(() => FakeUserProfileBookListsNotifier()),
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

    group('outgoing=NONE, incoming=NONE', () {
      testWidgets('プロフィール情報が表示される', (tester) async {
        final profile = _createProfile(
          outgoingFollowStatus: FollowStatusType.none,
          incomingFollowStatus: FollowStatusType.none,
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

      testWidgets('フォローボタンが表示される', (tester) async {
        final profile = _createProfile(
          outgoingFollowStatus: FollowStatusType.none,
          incomingFollowStatus: FollowStatusType.none,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        expect(find.text('フォロー'), findsOneWidget);
      });

      testWidgets('フォローボタンタップで sendFollowRequest が呼ばれる',
          (tester) async {
        final profile = _createProfile(
          outgoingFollowStatus: FollowStatusType.none,
          incomingFollowStatus: FollowStatusType.none,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        await tester.tap(find.text('フォロー'));
        await tester.pump();

        expect(fakeNotifier.sendFollowRequestCalled, isTrue);
      });
    });

    group('outgoing=NONE, incoming=FOLLOWING (フォローバック)', () {
      testWidgets('フォローバックするボタンが表示される', (tester) async {
        fakeNotifier = FakeFollowStateNotifier();
        final profile = _createProfile(
          outgoingFollowStatus: FollowStatusType.none,
          incomingFollowStatus: FollowStatusType.following,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        fakeNotifier.state = {
          profile.user.id: (
            outgoing: FollowStatusType.none,
            incoming: FollowStatusType.following,
          ),
        };
        await tester.pump();

        expect(find.text('フォローバック'), findsOneWidget);
      });

      testWidgets('フォローバックボタンタップで sendFollowRequest が呼ばれる',
          (tester) async {
        fakeNotifier = FakeFollowStateNotifier();
        final profile = _createProfile(
          outgoingFollowStatus: FollowStatusType.none,
          incomingFollowStatus: FollowStatusType.following,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        fakeNotifier.state = {
          profile.user.id: (
            outgoing: FollowStatusType.none,
            incoming: FollowStatusType.following,
          ),
        };
        await tester.pump();

        await tester.tap(find.text('フォローバック'));
        await tester.pump();

        expect(fakeNotifier.sendFollowRequestCalled, isTrue);
      });

      testWidgets('フォローバック状態でもコンテンツは制限付き表示', (tester) async {
        fakeNotifier = FakeFollowStateNotifier();
        final profile = _createProfile(
          outgoingFollowStatus: FollowStatusType.none,
          incomingFollowStatus: FollowStatusType.following,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        fakeNotifier.state = {
          profile.user.id: (
            outgoing: FollowStatusType.none,
            incoming: FollowStatusType.following,
          ),
        };
        await tester.pump();

        expect(find.text('フォローすると見られます'), findsOneWidget);
      });
    });

    group('outgoing=PENDING (リクエスト送信済み)', () {
      testWidgets('リクエスト送信済み状態が表示される', (tester) async {
        fakeNotifier = FakeFollowStateNotifier();
        final profile = _createProfile(
          outgoingFollowStatus: FollowStatusType.pendingSent,
          incomingFollowStatus: FollowStatusType.none,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        fakeNotifier.state = {
          profile.user.id: (
            outgoing: FollowStatusType.pendingSent,
            incoming: FollowStatusType.none,
          ),
        };
        await tester.pump();

        expect(find.text('リクエスト送信済み'), findsOneWidget);
      });

      testWidgets('リクエスト送信済みボタンタップで cancelFollowRequest が呼ばれる', (tester) async {
        fakeNotifier = FakeFollowStateNotifier();
        final profile = _createProfile(
          outgoingFollowStatus: FollowStatusType.pendingSent,
          incomingFollowStatus: FollowStatusType.none,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        fakeNotifier.state = {
          profile.user.id: (
            outgoing: FollowStatusType.pendingSent,
            incoming: FollowStatusType.none,
          ),
        };
        await tester.pump();

        await tester.tap(find.text('リクエスト送信済み'));
        await tester.pump();

        expect(fakeNotifier.cancelFollowRequestCalled, isTrue);
      });
    });

    group('outgoing=FOLLOWING (フォロー中)', () {
      testWidgets('フルプロフィールが表示される', (tester) async {
        fakeNotifier = FakeFollowStateNotifier();
        final profile = _createProfile(
          outgoingFollowStatus: FollowStatusType.following,
          incomingFollowStatus: FollowStatusType.none,
          bio: 'I love reading!',
          bookCount: 42,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        fakeNotifier.state = {
          profile.user.id: (
            outgoing: FollowStatusType.following,
            incoming: FollowStatusType.none,
          ),
        };
        await tester.pump();

        expect(find.text('TestUser'), findsOneWidget);
        expect(find.text('I love reading!'), findsOneWidget);
        expect(find.text('5 '), findsOneWidget);
        expect(find.text('3 '), findsOneWidget);
      });

      testWidgets('フォロー解除ボタンが表示される', (tester) async {
        fakeNotifier = FakeFollowStateNotifier();
        final profile = _createProfile(
          outgoingFollowStatus: FollowStatusType.following,
          incomingFollowStatus: FollowStatusType.none,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        fakeNotifier.state = {
          profile.user.id: (
            outgoing: FollowStatusType.following,
            incoming: FollowStatusType.none,
          ),
        };
        await tester.pump();

        expect(find.text('フォロー解除'), findsOneWidget);
      });

      testWidgets('フォロー解除ボタンタップで unfollow が呼ばれる', (tester) async {
        fakeNotifier = FakeFollowStateNotifier();
        final profile = _createProfile(
          outgoingFollowStatus: FollowStatusType.following,
          incomingFollowStatus: FollowStatusType.none,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        fakeNotifier.state = {
          profile.user.id: (
            outgoing: FollowStatusType.following,
            incoming: FollowStatusType.none,
          ),
        };
        await tester.pump();

        await tester.tap(find.text('フォロー解除'));
        await tester.pump();

        expect(fakeNotifier.unfollowCalled, isTrue);
      });

      testWidgets('フォロー中の場合はフォロー誘導メッセージが表示されない',
          (tester) async {
        fakeNotifier = FakeFollowStateNotifier();
        final profile = _createProfile(
          outgoingFollowStatus: FollowStatusType.following,
          incomingFollowStatus: FollowStatusType.none,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        fakeNotifier.state = {
          profile.user.id: (
            outgoing: FollowStatusType.following,
            incoming: FollowStatusType.none,
          ),
        };
        await tester.pump();

        expect(find.text('フォローすると見られます'), findsNothing);
      });
    });

    group('フォローカウントのリアクティブ更新', () {
      testWidgets('followCountsNotifierProvider の値が表示に反映される',
          (tester) async {
        final profile = _createProfile(
          followingCount: 5,
          followerCount: 3,
        );
        final overrideCounts = const FollowCounts(
          followingCount: 10,
          followerCount: 8,
        );
        await tester.pumpWidget(
          buildSubject(profile: profile, overrideCounts: overrideCounts),
        );
        await tester.pump();

        expect(find.text('10 '), findsOneWidget);
        expect(find.text('8 '), findsOneWidget);
        expect(find.text('5 '), findsNothing);
        expect(find.text('3 '), findsNothing);
      });
    });

    group('自分のプロフィール', () {
      testWidgets('フォロー操作ボタンが非表示', (tester) async {
        final profile = _createProfile(
          isOwnProfile: true,
          outgoingFollowStatus: FollowStatusType.following,
          incomingFollowStatus: FollowStatusType.following,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        expect(find.text('フォロー'), findsNothing);
        expect(find.text('フォロー解除'), findsNothing);
        expect(find.text('リクエスト送信済み'), findsNothing);
        expect(find.text('フォローバック'), findsNothing);
      });
    });

    group('タブバー', () {
      testWidgets('本棚とブックリストのタブが表示される', (tester) async {
        final profile = _createProfile(
          outgoingFollowStatus: FollowStatusType.none,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        expect(find.byType(ProfileTabBar), findsOneWidget);
        expect(find.text('本棚'), findsOneWidget);
        expect(find.text('ブックリスト'), findsOneWidget);
      });

      testWidgets('フォロー中でもタブバーが表示される', (tester) async {
        fakeNotifier = FakeFollowStateNotifier();
        final profile = _createProfile(
          outgoingFollowStatus: FollowStatusType.following,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        fakeNotifier.state = {
          profile.user.id: (
            outgoing: FollowStatusType.following,
            incoming: FollowStatusType.none,
          ),
        };
        await tester.pump();

        expect(find.byType(ProfileTabBar), findsOneWidget);
        expect(find.text('本棚'), findsOneWidget);
        expect(find.text('ブックリスト'), findsOneWidget);
      });

      testWidgets('フォローしていない場合、本棚タブにフォロー誘導メッセージが表示される',
          (tester) async {
        final profile = _createProfile(
          outgoingFollowStatus: FollowStatusType.none,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        expect(find.text('フォローすると見られます'), findsOneWidget);
      });

      testWidgets('リクエスト送信済みの場合もフォロー誘導メッセージが表示される',
          (tester) async {
        fakeNotifier = FakeFollowStateNotifier();
        final profile = _createProfile(
          outgoingFollowStatus: FollowStatusType.pendingSent,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        fakeNotifier.state = {
          profile.user.id: (
            outgoing: FollowStatusType.pendingSent,
            incoming: FollowStatusType.none,
          ),
        };
        await tester.pump();

        expect(find.text('フォローすると見られます'), findsOneWidget);
      });

      testWidgets('ブックリストタブに切り替えるとフォロー誘導メッセージが表示される',
          (tester) async {
        final profile = _createProfile(
          outgoingFollowStatus: FollowStatusType.none,
        );
        await tester.pumpWidget(buildSubject(profile: profile));
        await tester.pump();

        await tester.tap(find.text('ブックリスト'));
        await tester.pump();

        expect(find.text('フォローすると見られます'), findsOneWidget);
      });
    });
  });
}
