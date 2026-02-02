import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/core/widgets/screen_header.dart';
import 'package:shelfie/core/widgets/user_avatar.dart';

void main() {
  group('ゲストモード UI 制限', () {
    group('ScreenHeader', () {
      testWidgets('showAvatar: false でアバターアイコンが非表示', (tester) async {
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
        expect(find.text('テスト'), findsOneWidget);
      });

      testWidgets('showAvatar: true (デフォルト) でアバターアイコンが表示', (tester) async {
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

      testWidgets('onProfileTap が null でも正常にレンダリングできる', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.dark(),
            home: Scaffold(
              body: ScreenHeader(
                title: 'テスト',
                showAvatar: true,
              ),
            ),
          ),
        );

        expect(find.text('テスト'), findsOneWidget);
        expect(find.byType(UserAvatar), findsOneWidget);
      });
    });
  });
}
