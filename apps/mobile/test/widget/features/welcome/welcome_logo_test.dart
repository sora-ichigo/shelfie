import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/welcome/presentation/widgets/welcome_logo.dart';

void main() {
  group('WelcomeLogo', () {
    testWidgets('ロゴアイコンが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: Center(child: WelcomeLogo()),
          ),
        ),
      );

      expect(find.byType(WelcomeLogo), findsOneWidget);
    });

    testWidgets('"Shelfie" テキストが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: Center(child: WelcomeLogo()),
          ),
        ),
      );

      expect(find.text('Shelfie'), findsOneWidget);
    });

    testWidgets('キャッチコピーが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: Center(child: WelcomeLogo()),
          ),
        ),
      );

      expect(find.text('読書家のための本棚'), findsOneWidget);
    });
  });
}
