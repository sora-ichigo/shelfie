import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/login/application/login_form_state.dart';
import 'package:shelfie/features/login/presentation/widgets/login_submit_button.dart';

void main() {
  group('LoginSubmitButton', () {
    testWidgets('ボタンが表示される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: Scaffold(
              body: LoginSubmitButton(onPressed: () {}),
            ),
          ),
        ),
      );

      expect(find.text('ログイン'), findsOneWidget);
      expect(find.byType(FilledButton), findsOneWidget);
    });

    testWidgets('フォームが無効な場合、ボタンは無効化される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: Scaffold(
              body: LoginSubmitButton(onPressed: () {}),
            ),
          ),
        ),
      );

      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('フォームが有効な場合、ボタンは有効化される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            loginFormStateProvider.overrideWith(
              () => _ValidLoginFormState(),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: Scaffold(
              body: LoginSubmitButton(onPressed: () {}),
            ),
          ),
        ),
      );

      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNotNull);
    });

    testWidgets('onPressed が null の場合、ボタンは無効化される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            loginFormStateProvider.overrideWith(
              () => _ValidLoginFormState(),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const Scaffold(
              body: LoginSubmitButton(onPressed: null),
            ),
          ),
        ),
      );

      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNull);
    });
  });
}

class _ValidLoginFormState extends LoginFormState {
  @override
  LoginFormData build() {
    return const LoginFormData(
      email: 'test@example.com',
      password: 'password123',
    );
  }

  @override
  bool get isValid => true;
}
