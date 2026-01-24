import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/account/presentation/widgets/account_header.dart';

void main() {
  group('AccountHeader', () {
    testWidgets('アカウントタイトルが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: AccountHeader(onClose: () {}),
          ),
        ),
      );

      expect(find.text('アカウント'), findsOneWidget);
    });

    testWidgets('閉じるボタン（x）が表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: AccountHeader(onClose: () {}),
          ),
        ),
      );

      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('閉じるボタンをタップするとコールバックが呼ばれる', (tester) async {
      var callbackCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: AccountHeader(
              onClose: () => callbackCalled = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.close));
      expect(callbackCalled, isTrue);
    });
  });
}
