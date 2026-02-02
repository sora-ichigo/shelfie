import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/core/widgets/screen_header.dart';
import 'package:shelfie/core/widgets/user_avatar.dart';

void main() {
  group('ScreenHeader', () {
    testWidgets('タイトルが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ScreenHeader(
              title: 'テスト',
              onProfileTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('テスト'), findsOneWidget);
    });

    testWidgets('デフォルトでアバターが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ScreenHeader(
              title: 'テスト',
              onProfileTap: () {},
            ),
          ),
        ),
      );

      expect(find.byType(UserAvatar), findsOneWidget);
    });

    testWidgets('showAvatar: false でアバターが非表示になる', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ScreenHeader(
              title: 'テスト',
              showAvatar: false,
            ),
          ),
        ),
      );

      expect(find.byType(UserAvatar), findsNothing);
    });
  });
}
