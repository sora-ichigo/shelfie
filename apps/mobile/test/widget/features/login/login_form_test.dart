import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/login/presentation/widgets/login_form.dart';

void main() {
  group('LoginForm', () {
    testWidgets('メールアドレス入力フィールドが表示される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: Scaffold(
              body: SingleChildScrollView(
                child: LoginForm(onForgotPasswordPressed: () {}),
              ),
            ),
          ),
        ),
      );

      expect(find.text('メールアドレス'), findsOneWidget);
      expect(find.text('example@email.com'), findsOneWidget);
    });

    testWidgets('パスワード入力フィールドが表示される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: Scaffold(
              body: SingleChildScrollView(
                child: LoginForm(onForgotPasswordPressed: () {}),
              ),
            ),
          ),
        ),
      );

      expect(find.text('パスワード'), findsOneWidget);
      expect(find.text('パスワードを入力'), findsOneWidget);
    });

    testWidgets('パスワード表示切り替えアイコンが表示される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: Scaffold(
              body: SingleChildScrollView(
                child: LoginForm(onForgotPasswordPressed: () {}),
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('パスワード表示切り替えアイコンをタップすると表示状態が切り替わる',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: Scaffold(
              body: SingleChildScrollView(
                child: LoginForm(onForgotPasswordPressed: () {}),
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.visibility_off), findsOneWidget);

      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();

      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('パスワードを忘れた方リンクが表示される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: Scaffold(
              body: SingleChildScrollView(
                child: LoginForm(onForgotPasswordPressed: () {}),
              ),
            ),
          ),
        ),
      );

      expect(find.text('パスワードを忘れた方'), findsOneWidget);
    });

    testWidgets('パスワードを忘れた方リンクをタップするとコールバックが呼ばれる',
        (tester) async {
      var callbackCalled = false;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: Scaffold(
              body: SingleChildScrollView(
                child: LoginForm(
                  onForgotPasswordPressed: () => callbackCalled = true,
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('パスワードを忘れた方'));
      expect(callbackCalled, isTrue);
    });
  });
}
