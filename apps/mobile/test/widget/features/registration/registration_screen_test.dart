import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/registration/presentation/registration_screen.dart';
import 'package:shelfie/features/registration/presentation/widgets/registration_background.dart';
import 'package:shelfie/features/registration/presentation/widgets/registration_form.dart';
import 'package:shelfie/features/registration/presentation/widgets/registration_header.dart';
import 'package:shelfie/features/registration/presentation/widgets/registration_legal_links.dart';
import 'package:shelfie/features/registration/presentation/widgets/registration_submit_button.dart';

void main() {
  group('RegistrationScreen', () {
    testWidgets('SafeArea が適用されている', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const RegistrationScreen(),
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
            home: const RegistrationScreen(),
          ),
        ),
      );

      expect(find.byType(RegistrationBackground), findsOneWidget);
    });

    testWidgets('ヘッダーが表示される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const RegistrationScreen(),
          ),
        ),
      );

      expect(find.byType(RegistrationHeader), findsOneWidget);
      expect(find.text('新規登録'), findsOneWidget);
    });

    testWidgets('フォームが表示される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const RegistrationScreen(),
          ),
        ),
      );

      expect(find.byType(RegistrationForm), findsOneWidget);
    });

    testWidgets('送信ボタンが表示される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const RegistrationScreen(),
          ),
        ),
      );

      expect(find.byType(RegistrationSubmitButton), findsOneWidget);
      expect(find.text('アカウントを作成'), findsOneWidget);
    });

    testWidgets('利用規約リンクが表示される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const RegistrationScreen(),
          ),
        ),
      );

      expect(find.byType(RegistrationLegalLinks), findsOneWidget);
    });

    testWidgets('全要素が正しいレイアウトで配置される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const RegistrationScreen(),
          ),
        ),
      );

      expect(find.text('メールアドレス'), findsOneWidget);
      expect(find.text('パスワード'), findsOneWidget);
      expect(find.text('パスワード（確認）'), findsOneWidget);
      expect(find.text('アカウントを作成して始めましょう'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);
    });
  });
}
