import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/registration/presentation/widgets/registration_legal_links.dart';

void main() {
  group('RegistrationLegalLinks', () {
    testWidgets('テキストが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: RegistrationLegalLinks(
              onTermsPressed: () {},
              onPrivacyPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(RichText), findsOneWidget);

      final richText = tester.widget<RichText>(find.byType(RichText));
      final text = richText.text.toPlainText();
      expect(text, contains('続けることで'));
      expect(text, contains('利用規約'));
      expect(text, contains('プライバシーポリシー'));
      expect(text, contains('同意したものとみなされます'));
    });

    testWidgets('利用規約リンクをタップするとコールバックが呼ばれる', (tester) async {
      var callbackCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: RegistrationLegalLinks(
              onTermsPressed: () => callbackCalled = true,
              onPrivacyPressed: () {},
            ),
          ),
        ),
      );

      final richText = tester.widget<RichText>(find.byType(RichText));
      final textSpan = richText.text as TextSpan;

      for (final child in textSpan.children!) {
        if (child is TextSpan && child.text == '利用規約') {
          final recognizer = child.recognizer;
          if (recognizer is TapGestureRecognizer) {
            recognizer.onTap?.call();
          }
          break;
        }
      }

      expect(callbackCalled, isTrue);
    });

    testWidgets('プライバシーポリシーリンクをタップするとコールバックが呼ばれる', (tester) async {
      var callbackCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: RegistrationLegalLinks(
              onTermsPressed: () {},
              onPrivacyPressed: () => callbackCalled = true,
            ),
          ),
        ),
      );

      final richText = tester.widget<RichText>(find.byType(RichText));
      final textSpan = richText.text as TextSpan;

      for (final child in textSpan.children!) {
        if (child is TextSpan && child.text == 'プライバシーポリシー') {
          final recognizer = child.recognizer;
          if (recognizer is TapGestureRecognizer) {
            recognizer.onTap?.call();
          }
          break;
        }
      }

      expect(callbackCalled, isTrue);
    });
  });
}
