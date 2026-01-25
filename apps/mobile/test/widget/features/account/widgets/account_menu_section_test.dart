import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/account/presentation/widgets/account_menu_section.dart';

void main() {
  group('AccountMenuSection', () {
    testWidgets('セクションタイトルが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: AccountMenuSection(
              title: 'アカウント',
              items: const [],
            ),
          ),
        ),
      );

      expect(find.text('アカウント'), findsOneWidget);
    });

    testWidgets('メニュー項目が表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: AccountMenuSection(
              title: 'アカウント',
              items: [
                AccountMenuItem(
                  title: 'プロフィール編集',
                  onTap: () {},
                ),
                AccountMenuItem(
                  title: 'プレミアムプラン',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('プロフィール編集'), findsOneWidget);
      expect(find.text('プレミアムプラン'), findsOneWidget);
    });

    testWidgets('各メニュー項目に右矢印アイコン（>）が表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: AccountMenuSection(
              title: 'アカウント',
              items: [
                AccountMenuItem(
                  title: 'プロフィール編集',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('バッジが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: AccountMenuSection(
              title: 'アカウント',
              items: [
                AccountMenuItem(
                  title: 'プレミアムプラン',
                  badge: 'PRO',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('PRO'), findsOneWidget);
    });

    testWidgets('テーマ設定にバッジを表示できる', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: AccountMenuSection(
              title: '設定',
              items: [
                AccountMenuItem(
                  title: 'テーマ',
                  badge: 'ダーク',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('ダーク'), findsOneWidget);
    });

    testWidgets('メニュー項目をタップするとコールバックが呼ばれる', (tester) async {
      var callbackCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: AccountMenuSection(
              title: 'アカウント',
              items: [
                AccountMenuItem(
                  title: 'プロフィール編集',
                  onTap: () => callbackCalled = true,
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.text('プロフィール編集'));
      expect(callbackCalled, isTrue);
    });

    testWidgets('アイコン付きメニュー項目が表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: AccountMenuSection(
              title: 'アカウント',
              items: [
                AccountMenuItem(
                  title: 'プロフィール編集',
                  icon: Icons.person_outline,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.person_outline), findsOneWidget);
    });
  });
}
