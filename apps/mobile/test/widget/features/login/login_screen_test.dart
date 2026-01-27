import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/login/presentation/login_screen.dart';
import 'package:shelfie/features/login/presentation/widgets/login_background.dart';
import 'package:shelfie/features/login/presentation/widgets/login_form.dart';
import 'package:shelfie/features/login/presentation/widgets/login_header.dart';
import 'package:shelfie/features/login/presentation/widgets/login_submit_button.dart';

void main() {
  group('LoginScreen', () {
    testWidgets('SafeArea が適用されている', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const LoginScreen(),
          ),
        ),
      );

      expect(find.byType(SafeArea), findsOneWidget);
    });

    testWidgets('背景が表示される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const LoginScreen(),
          ),
        ),
      );

      expect(find.byType(LoginBackground), findsOneWidget);
    });

    testWidgets('ヘッダーが表示される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const LoginScreen(),
          ),
        ),
      );

      expect(find.byType(LoginHeader), findsOneWidget);
      expect(find.text('おかえりなさい'), findsOneWidget);
    });

    testWidgets('フォームが表示される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const LoginScreen(),
          ),
        ),
      );

      expect(find.byType(LoginForm), findsOneWidget);
    });

    testWidgets('送信ボタンが表示される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const LoginScreen(),
          ),
        ),
      );

      expect(find.byType(LoginSubmitButton), findsOneWidget);
      expect(find.text('ログイン'), findsNWidgets(2));
    });

    testWidgets('全要素が正しいレイアウトで配置される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const LoginScreen(),
          ),
        ),
      );

      expect(find.text('メールアドレス'), findsOneWidget);
      expect(find.text('パスワード'), findsOneWidget);
      expect(find.text('おかえりなさい'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);
      expect(find.text('パスワードを忘れた方'), findsOneWidget);
    });
  });
}
