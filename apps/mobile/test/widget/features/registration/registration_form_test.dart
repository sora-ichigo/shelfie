import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/registration/presentation/widgets/registration_form.dart';

void main() {
  group('RegistrationForm', () {
    testWidgets('メールアドレス入力フィールドが表示される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const Scaffold(
              body: SingleChildScrollView(
                child: RegistrationForm(),
              ),
            ),
          ),
        ),
      );

      expect(find.text('メールアドレス'), findsOneWidget);
      expect(find.text('example@email.com'), findsOneWidget);
      expect(find.byIcon(Icons.email_outlined), findsWidgets);
    });

    testWidgets('パスワード入力フィールドが表示される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const Scaffold(
              body: SingleChildScrollView(
                child: RegistrationForm(),
              ),
            ),
          ),
        ),
      );

      expect(find.text('パスワード'), findsOneWidget);
      expect(find.text('8文字以上'), findsOneWidget);
    });

    testWidgets('パスワード（確認）入力フィールドが表示される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const Scaffold(
              body: SingleChildScrollView(
                child: RegistrationForm(),
              ),
            ),
          ),
        ),
      );

      expect(find.text('パスワード（確認）'), findsOneWidget);
      expect(find.text('もう一度入力してください'), findsOneWidget);
    });

    testWidgets('パスワード表示切り替えアイコンが表示される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const Scaffold(
              body: SingleChildScrollView(
                child: RegistrationForm(),
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.visibility_off), findsNWidgets(2));
    });

    testWidgets('パスワード表示切り替えアイコンをタップすると表示状態が切り替わる', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const Scaffold(
              body: SingleChildScrollView(
                child: RegistrationForm(),
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.visibility_off), findsNWidgets(2));

      await tester.tap(find.byIcon(Icons.visibility_off).first);
      await tester.pump();

      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });
  });
}
