import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/core/theme/app_typography.dart';

void main() {
  group('AppTheme', () {
    group('dark', () {
      test('ダークモードの ThemeData を返す', () {
        final theme = AppTheme.dark();

        expect(theme, isA<ThemeData>());
        expect(theme.brightness, equals(Brightness.dark));
      });

      test('Material 3 が有効になっている', () {
        final theme = AppTheme.dark();

        expect(theme.useMaterial3, isTrue);
      });

      test('AppColors.dark が拡張として含まれている', () {
        final theme = AppTheme.dark();

        final colors = theme.extension<AppColors>();
        expect(colors, isNotNull);
        expect(colors, equals(AppColors.dark));
      });

      test('AppTypography の textTheme が適用されている', () {
        final theme = AppTheme.dark();

        expect(theme.textTheme.displayLarge?.fontSize,
            equals(AppTypography.displayLarge.fontSize));
        expect(theme.textTheme.bodyMedium?.fontSize,
            equals(AppTypography.bodyMedium.fontSize));
      });

      test('ColorScheme がダークモードで設定されている', () {
        final theme = AppTheme.dark();

        expect(theme.colorScheme.brightness, equals(Brightness.dark));
      });
    });

    group('theme', () {
      test('デフォルトテーマはダークモードを返す', () {
        final theme = AppTheme.theme;

        expect(theme, isA<ThemeData>());
        expect(theme.brightness, equals(Brightness.dark));
      });

      test('theme と dark() は同じ値を返す', () {
        final defaultTheme = AppTheme.theme;
        final darkTheme = AppTheme.dark();

        expect(defaultTheme.brightness, equals(darkTheme.brightness));
        expect(defaultTheme.useMaterial3, equals(darkTheme.useMaterial3));
      });
    });

    group('seedColor', () {
      test('デフォルトのシードカラーが定義されている', () {
        expect(AppTheme.seedColor, isA<Color>());
      });
    });

    group('ThemeData integration', () {
      testWidgets('MaterialApp でダークテーマが正しく適用される', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.dark(),
            home: Builder(
              builder: (context) {
                final theme = Theme.of(context);
                expect(theme.brightness, equals(Brightness.dark));
                expect(theme.extension<AppColors>(), isNotNull);
                return const SizedBox();
              },
            ),
          ),
        );
      });

      testWidgets('MaterialApp で AppTheme.theme が正しく適用される', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.theme,
            home: Builder(
              builder: (context) {
                final theme = Theme.of(context);
                expect(theme.brightness, equals(Brightness.dark));
                expect(theme.extension<AppColors>(), isNotNull);
                return const SizedBox();
              },
            ),
          ),
        );
      });
    });
  });
}
