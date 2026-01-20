import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/registration/presentation/widgets/registration_background.dart';

void main() {
  group('RegistrationBackground', () {
    testWidgets('背景が表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: RegistrationBackground(),
          ),
        ),
      );

      expect(find.byType(RegistrationBackground), findsOneWidget);
    });

    testWidgets('SizedBox.expand で全画面に広がる', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: RegistrationBackground(),
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(
        find.descendant(
          of: find.byType(RegistrationBackground),
          matching: find.byType(SizedBox),
        ),
      );
      expect(sizedBox.width, equals(double.infinity));
      expect(sizedBox.height, equals(double.infinity));
    });

    testWidgets('グラデーション背景が適用される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: RegistrationBackground(),
          ),
        ),
      );

      final decoratedBox = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byType(RegistrationBackground),
          matching: find.byType(DecoratedBox),
        ),
      );
      final decoration = decoratedBox.decoration as BoxDecoration;
      expect(decoration.gradient, isA<RadialGradient>());
    });
  });
}
