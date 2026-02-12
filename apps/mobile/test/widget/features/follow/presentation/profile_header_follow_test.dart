import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_header.dart';

import '../../../../helpers/test_helpers.dart';

void main() {
  setUpAll(registerTestFallbackValues);

  Widget buildSubject({
    String? name = 'TestUser',
    String? handle = 'testuser',
    int bookCount = 10,
    int followingCount = 0,
    int followerCount = 0,
    Widget? actionButtons,
    List<Override> overrides = const [],
  }) {
    return ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        theme: AppTheme.theme,
        home: Scaffold(
          body: ProfileHeader(
            name: name,
            handle: handle,
            bookCount: bookCount,
            followingCount: followingCount,
            followerCount: followerCount,
            onFollowingTap: () {},
            onFollowersTap: () {},
            actionButtons: actionButtons,
          ),
        ),
      ),
    );
  }

  group('ProfileHeader フォロー数統合', () {
    testWidgets('フォロー数が表示される', (tester) async {
      await tester.pumpWidget(buildSubject(
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
      await tester.pumpWidget(buildSubject(bookCount: 25));
      await tester.pump();

      expect(find.text('25 '), findsOneWidget);
      expect(find.text('冊登録'), findsOneWidget);
    });

    testWidgets('actionButtons が表示される', (tester) async {
      await tester.pumpWidget(buildSubject(
        actionButtons: const Text('カスタムボタン'),
      ));
      await tester.pump();

      expect(find.text('カスタムボタン'), findsOneWidget);
    });
  });
}
