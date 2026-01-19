import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/welcome/presentation/widgets/welcome_background.dart';

void main() {
  group('WelcomeBackground', () {
    testWidgets('背景画像が表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: WelcomeBackground(),
          ),
        ),
      );

      expect(find.byType(WelcomeBackground), findsOneWidget);
    });

    testWidgets('背景画像がフルサイズで表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: WelcomeBackground(),
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(WelcomeBackground),
          matching: find.byType(SizedBox),
        ),
      );

      expect(sizedBox.width, equals(double.infinity));
      expect(sizedBox.height, equals(double.infinity));
    });

    testWidgets('オーバーレイが重なっている', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: WelcomeBackground(),
          ),
        ),
      );

      final coloredBoxes = find.byType(ColoredBox);
      expect(coloredBoxes, findsWidgets);
    });
  });
}
