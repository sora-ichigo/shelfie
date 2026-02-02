import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/welcome/presentation/widgets/welcome_buttons.dart';

void main() {
  group('WelcomeButtons', () {
    testWidgets('ログインボタンが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: WelcomeButtons(
              onLoginPressed: () {},
              onRegisterPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('ログイン'), findsOneWidget);
    });

    testWidgets('新規登録ボタンが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: WelcomeButtons(
              onLoginPressed: () {},
              onRegisterPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('新規登録'), findsOneWidget);
    });

    testWidgets('ログインボタンタップで onLoginPressed が呼ばれる', (tester) async {
      var loginPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: WelcomeButtons(
              onLoginPressed: () => loginPressed = true,
              onRegisterPressed: () {},
            ),
          ),
        ),
      );

      await tester.tap(find.text('ログイン'));
      await tester.pumpAndSettle();

      expect(loginPressed, isTrue);
    });

    testWidgets('新規登録ボタンタップで onRegisterPressed が呼ばれる', (tester) async {
      var registerPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: WelcomeButtons(
              onLoginPressed: () {},
              onRegisterPressed: () => registerPressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('新規登録'));
      await tester.pumpAndSettle();

      expect(registerPressed, isTrue);
    });

    testWidgets('「アカウントなしで利用」リンクが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: WelcomeButtons(
              onLoginPressed: () {},
              onRegisterPressed: () {},
              onGuestModePressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('アカウントなしで利用'), findsOneWidget);
    });

    testWidgets('「アカウントなしで利用」タップで onGuestModePressed が呼ばれる',
        (tester) async {
      var guestModePressed = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: WelcomeButtons(
              onLoginPressed: () {},
              onRegisterPressed: () {},
              onGuestModePressed: () => guestModePressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('アカウントなしで利用'));
      await tester.pumpAndSettle();

      expect(guestModePressed, isTrue);
    });

    testWidgets('「アカウントなしで利用」はボタンよりも控えめなテキストリンクスタイル',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: WelcomeButtons(
              onLoginPressed: () {},
              onRegisterPressed: () {},
              onGuestModePressed: () {},
            ),
          ),
        ),
      );

      final textButton = tester.widget<TextButton>(
        find.ancestor(
          of: find.text('アカウントなしで利用'),
          matching: find.byType(TextButton),
        ),
      );
      expect(textButton, isNotNull);
    });
  });
}
