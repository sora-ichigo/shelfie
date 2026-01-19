import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/welcome/presentation/widgets/legal_links.dart';

void main() {
  group('LegalLinks', () {
    testWidgets('LegalLinks ウィジェットが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: LegalLinks(
              onTermsPressed: () {},
              onPrivacyPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(LegalLinks), findsOneWidget);
      expect(find.byType(RichText), findsOneWidget);
    });

    testWidgets('同意テキストに利用規約とプライバシーポリシーが含まれる', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: LegalLinks(
              onTermsPressed: () {},
              onPrivacyPressed: () {},
            ),
          ),
        ),
      );

      final richTextFinder = find.byType(RichText);
      expect(richTextFinder, findsOneWidget);

      final richText = tester.widget<RichText>(richTextFinder);
      final textSpan = richText.text as TextSpan;

      expect(textSpan.toPlainText(), contains('利用規約'));
      expect(textSpan.toPlainText(), contains('プライバシーポリシー'));
      expect(textSpan.toPlainText(), contains('続けることで'));
    });

    testWidgets('利用規約タップでコールバックが呼ばれる', (tester) async {
      var termsPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: LegalLinks(
              onTermsPressed: () => termsPressed = true,
              onPrivacyPressed: () {},
            ),
          ),
        ),
      );

      final richTextFinder = find.byType(RichText);
      final richText = tester.widget<RichText>(richTextFinder);
      final textSpan = richText.text as TextSpan;

      final termsSpan = textSpan.children!
          .whereType<TextSpan>()
          .firstWhere((span) => span.text == '利用規約');
      (termsSpan.recognizer! as TapGestureRecognizer).onTap?.call();

      expect(termsPressed, isTrue);
    });

    testWidgets('プライバシーポリシータップでコールバックが呼ばれる', (tester) async {
      var privacyPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: LegalLinks(
              onTermsPressed: () {},
              onPrivacyPressed: () => privacyPressed = true,
            ),
          ),
        ),
      );

      final richTextFinder = find.byType(RichText);
      final richText = tester.widget<RichText>(richTextFinder);
      final textSpan = richText.text as TextSpan;

      final privacySpan = textSpan.children!
          .whereType<TextSpan>()
          .firstWhere((span) => span.text == 'プライバシーポリシー');
      (privacySpan.recognizer! as TapGestureRecognizer).onTap?.call();

      expect(privacyPressed, isTrue);
    });
  });
}
