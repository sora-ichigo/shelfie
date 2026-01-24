import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_edit_header.dart';

void main() {
  group('ProfileEditHeader', () {
    testWidgets('プロフィール編集タイトルが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileEditHeader(
              onClose: () {},
              onSave: () {},
              isSaveEnabled: true,
            ),
          ),
        ),
      );

      expect(find.text('プロフィール編集'), findsOneWidget);
    });

    testWidgets('閉じるボタン（x）が表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileEditHeader(
              onClose: () {},
              onSave: () {},
              isSaveEnabled: true,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('保存ボタン（チェックマーク）が表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileEditHeader(
              onClose: () {},
              onSave: () {},
              isSaveEnabled: true,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('閉じるボタンをタップするとコールバックが呼ばれる', (tester) async {
      var callbackCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileEditHeader(
              onClose: () => callbackCalled = true,
              onSave: () {},
              isSaveEnabled: true,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.close));
      expect(callbackCalled, isTrue);
    });

    testWidgets('保存ボタンが有効な時タップするとコールバックが呼ばれる', (tester) async {
      var callbackCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileEditHeader(
              onClose: () {},
              onSave: () => callbackCalled = true,
              isSaveEnabled: true,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.check));
      expect(callbackCalled, isTrue);
    });

    testWidgets('保存ボタンが無効な時タップしてもコールバックは呼ばれない', (tester) async {
      var callbackCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileEditHeader(
              onClose: () {},
              onSave: () => callbackCalled = true,
              isSaveEnabled: false,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.check));
      expect(callbackCalled, isFalse);
    });
  });
}
