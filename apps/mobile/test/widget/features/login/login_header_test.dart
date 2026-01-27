import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/login/presentation/widgets/login_header.dart';

void main() {
  group('LoginHeader', () {
    testWidgets('戻るボタンが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: LoginHeader(onBackPressed: () {}),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);
    });

    testWidgets('戻るボタンをタップするとコールバックが呼ばれる', (tester) async {
      var callbackCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: LoginHeader(
              onBackPressed: () => callbackCalled = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
      expect(callbackCalled, isTrue);
    });

    testWidgets('ロックアイコンが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: LoginHeader(onBackPressed: () {}),
          ),
        ),
      );

      expect(find.byIcon(Icons.lock_outline), findsOneWidget);
    });

    testWidgets('ログインタイトルが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: LoginHeader(onBackPressed: () {}),
          ),
        ),
      );

      expect(find.text('ログイン'), findsOneWidget);
    });

    testWidgets('サブタイトル「おかえりなさい」が表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: LoginHeader(onBackPressed: () {}),
          ),
        ),
      );

      expect(find.text('おかえりなさい'), findsOneWidget);
    });

    testWidgets('ロックアイコンが円形背景内に配置される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: LoginHeader(onBackPressed: () {}),
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
