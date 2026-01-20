import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/registration/presentation/widgets/registration_header.dart';

void main() {
  group('RegistrationHeader', () {
    testWidgets('戻るリンクが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: RegistrationHeader(onBackPressed: () {}),
          ),
        ),
      );

      expect(find.text('戻る'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });

    testWidgets('戻るリンクをタップするとコールバックが呼ばれる', (tester) async {
      var callbackCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: RegistrationHeader(
              onBackPressed: () => callbackCalled = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('戻る'));
      expect(callbackCalled, isTrue);
    });

    testWidgets('メールアイコンが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: RegistrationHeader(onBackPressed: () {}),
          ),
        ),
      );

      expect(find.byIcon(Icons.email_outlined), findsOneWidget);
    });

    testWidgets('新規登録タイトルが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: RegistrationHeader(onBackPressed: () {}),
          ),
        ),
      );

      expect(find.text('新規登録'), findsOneWidget);
    });

    testWidgets('サブタイトルが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: RegistrationHeader(onBackPressed: () {}),
          ),
        ),
      );

      expect(find.text('アカウントを作成して始めましょう'), findsOneWidget);
    });

    testWidgets('メールアイコンが円形背景内に配置される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: RegistrationHeader(onBackPressed: () {}),
          ),
        ),
      );

      final circleAvatar = tester.widget<CircleAvatar>(
        find.byType(CircleAvatar),
      );
      expect(circleAvatar, isNotNull);
    });
  });
}
