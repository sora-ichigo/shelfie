import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_header.dart';

import '../../../../helpers/test_helpers.dart';

UserProfile _createProfile({
  int id = 1,
  String? handle = 'testuser',
  String? name = 'TestUser',
  int bookCount = 10,
}) {
  return UserProfile(
    id: id,
    email: 'test@example.com',
    name: name,
    avatarUrl: null,
    handle: handle,
    bookCount: bookCount,
    bio: null,
    instagramHandle: null,
    readingStartYear: null,
    readingStartMonth: null,
    createdAt: DateTime(2026),
  );
}

void main() {
  setUpAll(registerTestFallbackValues);

  Widget buildSubject({
    required UserProfile profile,
    int followingCount = 0,
    int followerCount = 0,
    List<Override> overrides = const [],
  }) {
    return ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        theme: AppTheme.theme,
        home: Scaffold(
          body: ProfileHeader(
            profile: profile,
            followingCount: followingCount,
            followerCount: followerCount,
            onEditProfile: () {},
            onShareProfile: () {},
            onFollowingTap: () {},
            onFollowersTap: () {},
          ),
        ),
      ),
    );
  }

  group('ProfileHeader フォロー数統合', () {
    testWidgets('フォロー数が表示される', (tester) async {
      await tester.pumpWidget(buildSubject(
        profile: _createProfile(),
        followingCount: 42,
        followerCount: 15,
      ));
      await tester.pump();

      expect(find.text('42 '), findsOneWidget);
      expect(find.text('フォロー中'), findsOneWidget);
      expect(find.text('15 '), findsOneWidget);
      expect(find.text('フォロワー'), findsOneWidget);
    });

    testWidgets('冊数が表示される', (tester) async {
      await tester.pumpWidget(buildSubject(
        profile: _createProfile(bookCount: 25),
      ));
      await tester.pump();

      expect(find.text('25 '), findsOneWidget);
      expect(find.text('冊登録'), findsOneWidget);
    });

    testWidgets('プロフィールをシェアボタンが存在する', (tester) async {
      await tester.pumpWidget(buildSubject(
        profile: _createProfile(),
      ));
      await tester.pump();

      expect(find.text('プロフィールをシェア'), findsOneWidget);
    });
  });
}
