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
  });
}
