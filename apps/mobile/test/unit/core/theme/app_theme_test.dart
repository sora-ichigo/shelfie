import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/core/theme/app_typography.dart';

import '../../../helpers/test_helpers.dart';

void main() {
  setUpAll(registerTestFallbackValues);
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

      test('シードカラーはブランドプライマリカラー (#4FD1C5) である', () {
        expect(AppTheme.seedColor, equals(const Color(0xFF4FD1C5)));
      });
    });

    group('Button themes', () {
      test('FilledButton のデフォルトスタイルが定義されている', () {
        final theme = AppTheme.dark();
        final filledButtonTheme = theme.filledButtonTheme;

        expect(filledButtonTheme, isNotNull);
        expect(filledButtonTheme.style, isNotNull);
      });

      test('FilledButton は白背景・黒文字である', () {
        final theme = AppTheme.dark();
        final style = theme.filledButtonTheme.style!;

        final bgColor = style.backgroundColor?.resolve({});
        final fgColor = style.foregroundColor?.resolve({});

        expect(bgColor, equals(Colors.white));
        expect(fgColor, equals(Colors.black));
      });

      test('FilledButton の高さは 56px である', () {
        final theme = AppTheme.dark();
        final style = theme.filledButtonTheme.style!;

        final minSize = style.minimumSize?.resolve({});
        expect(minSize?.height, equals(56.0));
      });

      test('OutlinedButton のデフォルトスタイルが定義されている', () {
        final theme = AppTheme.dark();
        final outlinedButtonTheme = theme.outlinedButtonTheme;

        expect(outlinedButtonTheme, isNotNull);
        expect(outlinedButtonTheme.style, isNotNull);
      });

      test('OutlinedButton は白枠・白文字である', () {
        final theme = AppTheme.dark();
        final style = theme.outlinedButtonTheme.style!;

        final fgColor = style.foregroundColor?.resolve({});
        final side = style.side?.resolve({});

        expect(fgColor, equals(Colors.white));
        expect(side?.color, equals(Colors.white));
      });

      test('OutlinedButton の高さは 56px である', () {
        final theme = AppTheme.dark();
        final style = theme.outlinedButtonTheme.style!;

        final minSize = style.minimumSize?.resolve({});
        expect(minSize?.height, equals(56.0));
      });
    });

    group('scaffoldBackgroundColor', () {
      test('scaffoldBackgroundColor はブランド背景色である', () {
        final theme = AppTheme.dark();
        expect(theme.scaffoldBackgroundColor, equals(AppColors.dark.backgroundLegacy));
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

    group('ThemeExtension access', () {
      testWidgets('context から AppColors にアクセスできること', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                final appColors = Theme.of(context).extension<AppColors>();
                expect(appColors, isNotNull);
                expect(appColors!.successLegacy, isA<Color>());
                expect(appColors.warningLegacy, isA<Color>());
                expect(appColors.infoLegacy, isA<Color>());
                return const SizedBox();
              },
            ),
          ),
        );
      });

      testWidgets('ダークモードで AppColors.dark が使用されること', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                final appColors = Theme.of(context).extension<AppColors>();
                expect(appColors, equals(AppColors.dark));
                return const SizedBox();
              },
            ),
          ),
        );
      });
    });


    group('ThemeExtension animation', () {
      test('AppColors.lerp が正しく動作すること', () {
        const base = AppColors.dark;
        final target = base.copyWith(
          successLegacy: const Color(0xFF00FF00),
          warningLegacy: const Color(0xFFFF0000),
          infoLegacy: const Color(0xFF0000FF),
        );

        final mid = base.lerp(target, 0.5);

        expect(mid, isA<AppColors>());
        expect(mid.successLegacy, isNot(equals(base.successLegacy)));
        expect(mid.successLegacy, isNot(equals(target.successLegacy)));
      });

      test('lerp(0.0) は元の値を返すこと', () {
        const base = AppColors.dark;
        final target = base.copyWith(
          successLegacy: const Color(0xFF00FF00),
          warningLegacy: const Color(0xFFFF0000),
          infoLegacy: const Color(0xFF0000FF),
        );

        final result = base.lerp(target, 0.0);

        expect(result.successLegacy, equals(base.successLegacy));
        expect(result.warningLegacy, equals(base.warningLegacy));
        expect(result.infoLegacy, equals(base.infoLegacy));
      });

      test('lerp(1.0) は対象の値を返すこと', () {
        const base = AppColors.dark;
        final target = base.copyWith(
          successLegacy: const Color(0xFF00FF00),
          warningLegacy: const Color(0xFFFF0000),
          infoLegacy: const Color(0xFF0000FF),
        );

        final result = base.lerp(target, 1.0);

        expect(result.successLegacy, equals(target.successLegacy));
        expect(result.warningLegacy, equals(target.warningLegacy));
        expect(result.infoLegacy, equals(target.infoLegacy));
      });
    });
  });
}
