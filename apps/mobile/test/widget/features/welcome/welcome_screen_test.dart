import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/welcome/presentation/welcome_screen.dart';
import 'package:shelfie/features/welcome/presentation/widgets/legal_links.dart';
import 'package:shelfie/features/welcome/presentation/widgets/welcome_background.dart';
import 'package:shelfie/features/welcome/presentation/widgets/welcome_buttons.dart';
import 'package:shelfie/features/welcome/presentation/widgets/welcome_logo.dart';

void main() {
  group('WelcomeScreen', () {
    testWidgets('SafeArea が適用されている', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const WelcomeScreen(),
        ),
      );

      expect(find.byType(SafeArea), findsOneWidget);
    });

    testWidgets('背景が表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const WelcomeScreen(),
        ),
      );

      expect(find.byType(WelcomeBackground), findsOneWidget);
    });

    testWidgets('ロゴが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const WelcomeScreen(),
        ),
      );

      expect(find.byType(WelcomeLogo), findsOneWidget);
    });

    testWidgets('ボタンが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const WelcomeScreen(),
        ),
      );

      expect(find.byType(WelcomeButtons), findsOneWidget);
    });

    testWidgets('リンクが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const WelcomeScreen(),
        ),
      );

      expect(find.byType(LegalLinks), findsOneWidget);
    });

    testWidgets('ログインボタンと新規登録ボタンが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const WelcomeScreen(),
        ),
      );

      expect(find.text('ログイン'), findsOneWidget);
      expect(find.text('新規登録'), findsOneWidget);
    });

    testWidgets('ゲストモードボタンは表示されない', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const WelcomeScreen(),
        ),
      );

      expect(find.text('アカウントなしで利用'), findsNothing);
    });

    testWidgets('異なる画面サイズでレイアウトが崩れない', (tester) async {
      await tester.binding.setSurfaceSize(const Size(375, 667));

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const WelcomeScreen(),
        ),
      );

      expect(find.byType(WelcomeScreen), findsOneWidget);
      expect(find.byType(WelcomeLogo), findsOneWidget);
      expect(find.byType(WelcomeButtons), findsOneWidget);

      await tester.binding.setSurfaceSize(const Size(428, 926));

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const WelcomeScreen(),
        ),
      );

      expect(find.byType(WelcomeScreen), findsOneWidget);
      expect(find.byType(WelcomeLogo), findsOneWidget);
      expect(find.byType(WelcomeButtons), findsOneWidget);

      addTearDown(() => tester.binding.setSurfaceSize(null));
    });
  });
}
