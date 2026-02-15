import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_colors.dart';

void main() {
  group('AppColors', () {
    group('ThemeExtension', () {
      test('AppColors は ThemeExtension を継承している', () {
        const colors = AppColors.dark;
        expect(colors, isA<ThemeExtension<AppColors>>());
      });
    });

    group('dark', () {
      test('ダークモード用のカラーが定義されている', () {
        const colors = AppColors.dark;

        expect(colors.successLegacy, isA<Color>());
        expect(colors.warningLegacy, isA<Color>());
        expect(colors.infoLegacy, isA<Color>());
      });

      group('Semantic colors', () {
        test('primary はティール色 (#2B9E8F) で定義されている', () {
          const colors = AppColors.dark;
          expect(colors.primaryLegacy, equals(const Color(0xFF2B9E8F)));
        });

        test('primaryPressed はティール色 (#238275) で定義されている', () {
          const colors = AppColors.dark;
          expect(colors.primaryPressedLegacy, equals(const Color(0xFF238275)));
        });

        test('star はゴールド色 (#FFD60A) で定義されている', () {
          const colors = AppColors.dark;
          expect(colors.starLegacy, equals(const Color(0xFFFFD60A)));
        });

        test('background はダーク色 (#121212) で定義されている', () {
          const colors = AppColors.dark;
          expect(colors.backgroundLegacy, equals(const Color(0xFF121212)));
        });
      });

      group('Surface colors', () {
        test('surface は定義されている', () {
          const colors = AppColors.dark;
          expect(colors.surfaceLegacy, equals(const Color(0xFF1E1E1E)));
        });

        test('surfaceElevated は定義されている', () {
          const colors = AppColors.dark;
          expect(
            colors.surfaceElevatedLegacy,
            equals(const Color(0xFF2A2A2A)),
          );
        });
      });

      group('Utility colors', () {
        test('border は定義されている', () {
          const colors = AppColors.dark;
          expect(colors.borderLegacy, equals(const Color(0xFF333333)));
        });

        test('inactive は定義されている', () {
          const colors = AppColors.dark;
          expect(colors.inactiveLegacy, equals(const Color(0xFF666666)));
        });
      });

      group('Text colors', () {
        test('textPrimary は白色で定義されている', () {
          const colors = AppColors.dark;
          expect(colors.textPrimaryLegacy, equals(const Color(0xFFFFFFFF)));
        });

        test('textSecondary はグレー色で定義されている', () {
          const colors = AppColors.dark;
          expect(colors.textSecondaryLegacy, equals(const Color(0xFFB0B0B0)));
        });
      });

      group('Feedback colors', () {
        test('destructive は赤系で定義されている', () {
          const colors = AppColors.dark;
          expect(colors.destructiveLegacy, equals(const Color(0xFFCF4F4A)));
        });

        test('ダークモードの success カラーは緑系', () {
          const colors = AppColors.dark;
          expect(
            colors.successLegacy.green,
            greaterThan(colors.successLegacy.red),
          );
          expect(
            colors.successLegacy.green,
            greaterThan(colors.successLegacy.blue),
          );
        });

        test('ダークモードの warning カラーは黄系', () {
          const colors = AppColors.dark;
          expect(
            colors.warningLegacy.red,
            greaterThan(colors.warningLegacy.blue),
          );
        });

        test('ダークモードの info カラーは青系', () {
          const colors = AppColors.dark;
          expect(colors.infoLegacy.blue, greaterThan(colors.infoLegacy.red));
          expect(colors.infoLegacy.blue, greaterThan(colors.infoLegacy.green));
        });
      });
    });

    group('light', () {
      group('MD3 Core: Primary', () {
        test('primary は #3D8A5A で定義されている', () {
          const colors = AppColors.light;
          expect(colors.primary, equals(const Color(0xFF3D8A5A)));
        });

        test('onPrimary は #FFFFFF で定義されている', () {
          const colors = AppColors.light;
          expect(colors.onPrimary, equals(const Color(0xFFFFFFFF)));
        });

        test('primaryContainer は #EDF5F0 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.primaryContainer, equals(const Color(0xFFEDF5F0)));
        });

        test('onPrimaryContainer は #1A3D2A で定義されている', () {
          const colors = AppColors.light;
          expect(colors.onPrimaryContainer, equals(const Color(0xFF1A3D2A)));
        });
      });

      group('MD3 Core: Secondary', () {
        test('secondary は #8B9F7B で定義されている', () {
          const colors = AppColors.light;
          expect(colors.secondary, equals(const Color(0xFF8B9F7B)));
        });

        test('onSecondary は #FFFFFF で定義されている', () {
          const colors = AppColors.light;
          expect(colors.onSecondary, equals(const Color(0xFFFFFFFF)));
        });

        test('secondaryContainer は #E0EDE5 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.secondaryContainer, equals(const Color(0xFFE0EDE5)));
        });

        test('onSecondaryContainer は #2B4C3F で定義されている', () {
          const colors = AppColors.light;
          expect(colors.onSecondaryContainer, equals(const Color(0xFF2B4C3F)));
        });
      });

      group('MD3 Core: Tertiary', () {
        test('tertiary は #D89575 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.tertiary, equals(const Color(0xFFD89575)));
        });

        test('onTertiary は #FFFFFF で定義されている', () {
          const colors = AppColors.light;
          expect(colors.onTertiary, equals(const Color(0xFFFFFFFF)));
        });

        test('tertiaryContainer は #FDF4EC で定義されている', () {
          const colors = AppColors.light;
          expect(colors.tertiaryContainer, equals(const Color(0xFFFDF4EC)));
        });

        test('onTertiaryContainer は #5A3A2A で定義されている', () {
          const colors = AppColors.light;
          expect(colors.onTertiaryContainer, equals(const Color(0xFF5A3A2A)));
        });
      });

      group('MD3 Core: Error', () {
        test('error は #E57373 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.error, equals(const Color(0xFFE57373)));
        });

        test('onError は #FFFFFF で定義されている', () {
          const colors = AppColors.light;
          expect(colors.onError, equals(const Color(0xFFFFFFFF)));
        });

        test('errorContainer は #FFF0F0 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.errorContainer, equals(const Color(0xFFFFF0F0)));
        });

        test('onErrorContainer は #C84A5A で定義されている', () {
          const colors = AppColors.light;
          expect(colors.onErrorContainer, equals(const Color(0xFFC84A5A)));
        });
      });

      group('MD3 Core: Surface', () {
        test('surface は #FAFAF8 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.surface, equals(const Color(0xFFFAFAF8)));
        });

        test('onSurface は #1A1918 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.onSurface, equals(const Color(0xFF1A1918)));
        });

        test('surfaceContainerLowest は #FFFFFF で定義されている', () {
          const colors = AppColors.light;
          expect(
            colors.surfaceContainerLowest,
            equals(const Color(0xFFFFFFFF)),
          );
        });

        test('surfaceContainerLow は #F5F4F1 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.surfaceContainerLow, equals(const Color(0xFFF5F4F1)));
        });

        test('surfaceContainer は #EDECEA で定義されている', () {
          const colors = AppColors.light;
          expect(colors.surfaceContainer, equals(const Color(0xFFEDECEA)));
        });

        test('surfaceContainerHigh は #E5E4E1 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.surfaceContainerHigh, equals(const Color(0xFFE5E4E1)));
        });

        test('surfaceContainerHighest は #D1D0CD で定義されている', () {
          const colors = AppColors.light;
          expect(
            colors.surfaceContainerHighest,
            equals(const Color(0xFFD1D0CD)),
          );
        });

        test('surfaceTint は #3D8A5A で定義されている', () {
          const colors = AppColors.light;
          expect(colors.surfaceTint, equals(const Color(0xFF3D8A5A)));
        });

        test('onSurfaceVariant は #6D6C6A で定義されている', () {
          const colors = AppColors.light;
          expect(colors.onSurfaceVariant, equals(const Color(0xFF6D6C6A)));
        });

        test('inverseSurface は #1C1917 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.inverseSurface, equals(const Color(0xFF1C1917)));
        });

        test('inverseOnSurface は #FAFAF8 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.inverseOnSurface, equals(const Color(0xFFFAFAF8)));
        });
      });

      group('MD3 Core: Outline / Scrim', () {
        test('outline は #9C9B99 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.outline, equals(const Color(0xFF9C9B99)));
        });

        test('outlineVariant は #E5E4E1 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.outlineVariant, equals(const Color(0xFFE5E4E1)));
        });

        test('scrim は #00000040 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.scrim, equals(const Color(0x40000000)));
        });
      });

      group('Semantic: Border', () {
        test('borderSubtle は #E5E4E1 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.borderSubtle, equals(const Color(0xFFE5E4E1)));
        });

        test('borderStrong は #D1D0CD で定義されている', () {
          const colors = AppColors.light;
          expect(colors.borderStrong, equals(const Color(0xFFD1D0CD)));
        });
      });

      group('Semantic: Text', () {
        test('textPrimary は #1A1918 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.textPrimary, equals(const Color(0xFF1A1918)));
        });

        test('textSecondary は #6D6C6A で定義されている', () {
          const colors = AppColors.light;
          expect(colors.textSecondary, equals(const Color(0xFF6D6C6A)));
        });

        test('textTertiary は #9C9B99 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.textTertiary, equals(const Color(0xFF9C9B99)));
        });
      });

      group('Semantic: Background', () {
        test('bgPrimary は #F5F4F1 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.bgPrimary, equals(const Color(0xFFF5F4F1)));
        });

        test('bgSurface は #FFFFFF で定義されている', () {
          const colors = AppColors.light;
          expect(colors.bgSurface, equals(const Color(0xFFFFFFFF)));
        });

        test('bgMuted は #EDECEA で定義されている', () {
          const colors = AppColors.light;
          expect(colors.bgMuted, equals(const Color(0xFFEDECEA)));
        });

        test('bgHero は #1C1917 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.bgHero, equals(const Color(0xFF1C1917)));
        });

        test('bgHeroGrad は #292524 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.bgHeroGrad, equals(const Color(0xFF292524)));
        });
      });

      group('Semantic: Accent', () {
        test('accentPrimary は #3D8A5A で定義されている', () {
          const colors = AppColors.light;
          expect(colors.accentPrimary, equals(const Color(0xFF3D8A5A)));
        });

        test('accentLink は #8B9F7B で定義されている', () {
          const colors = AppColors.light;
          expect(colors.accentLink, equals(const Color(0xFF8B9F7B)));
        });

        test('accentWarm は #D89575 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.accentWarm, equals(const Color(0xFFD89575)));
        });
      });

      group('Semantic: Tab', () {
        test('tabInactive は #A8A7A5 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.tabInactive, equals(const Color(0xFFA8A7A5)));
        });
      });

      group('Semantic: Tag', () {
        test('tagAmber は #FFF8E1 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.tagAmber, equals(const Color(0xFFFFF8E1)));
        });

        test('tagAmberText は #8B6914 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.tagAmberText, equals(const Color(0xFF8B6914)));
        });

        test('tagBlue は #EDF4FF で定義されている', () {
          const colors = AppColors.light;
          expect(colors.tagBlue, equals(const Color(0xFFEDF4FF)));
        });

        test('tagBlueText は #4A7AC8 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.tagBlueText, equals(const Color(0xFF4A7AC8)));
        });

        test('tagPurple は #F0EDFF で定義されている', () {
          const colors = AppColors.light;
          expect(colors.tagPurple, equals(const Color(0xFFF0EDFF)));
        });

        test('tagPurpleText は #6B4AC8 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.tagPurpleText, equals(const Color(0xFF6B4AC8)));
        });

        test('tagRose は #F5E6E0 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.tagRose, equals(const Color(0xFFF5E6E0)));
        });

        test('tagRoseText は #A0614A で定義されている', () {
          const colors = AppColors.light;
          expect(colors.tagRoseText, equals(const Color(0xFFA0614A)));
        });

        test('tagTeal は #E8F0EC で定義されている', () {
          const colors = AppColors.light;
          expect(colors.tagTeal, equals(const Color(0xFFE8F0EC)));
        });

        test('tagTealText は #3D7A5A で定義されている', () {
          const colors = AppColors.light;
          expect(colors.tagTealText, equals(const Color(0xFF3D7A5A)));
        });
      });

      group('Semantic: Status', () {
        test('statusComplete は #A8D5BA で定義されている', () {
          const colors = AppColors.light;
          expect(colors.statusComplete, equals(const Color(0xFFA8D5BA)));
        });

        test('statusReading は #D89575 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.statusReading, equals(const Color(0xFFD89575)));
        });
      });

      group('Semantic: Star', () {
        test('starColor は #4CAF50 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.starColor, equals(const Color(0xFF4CAF50)));
        });

        test('starRating は #4CAF50 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.starRating, equals(const Color(0xFF4CAF50)));
        });
      });

      group('Semantic: Match Badge', () {
        test('matchBadge は #C8854A で定義されている', () {
          const colors = AppColors.light;
          expect(colors.matchBadge, equals(const Color(0xFFC8854A)));
        });

        test('matchBadgeBg は #FFF8F0 で定義されている', () {
          const colors = AppColors.light;
          expect(colors.matchBadgeBg, equals(const Color(0xFFFFF8F0)));
        });
      });

      group('Legacy プロパティの互換性', () {
        test('light 定数に Legacy プロパティが含まれている', () {
          const colors = AppColors.light;
          expect(colors.primaryLegacy, isA<Color>());
          expect(colors.backgroundLegacy, isA<Color>());
          expect(colors.surfaceLegacy, isA<Color>());
          expect(colors.textPrimaryLegacy, isA<Color>());
        });

        test('light 定数の Legacy プロパティはダーク値を保持している', () {
          const lightColors = AppColors.light;
          const darkColors = AppColors.dark;
          expect(lightColors.primaryLegacy, equals(darkColors.primaryLegacy));
          expect(
            lightColors.backgroundLegacy,
            equals(darkColors.backgroundLegacy),
          );
          expect(lightColors.surfaceLegacy, equals(darkColors.surfaceLegacy));
        });
      });

      group('新トークンの総数', () {
        test('light 定数は 60 個の新カラートークンを持つ', () {
          const colors = AppColors.light;

          final newTokens = <Color>[
            // MD3 Core: Primary (4)
            colors.primary,
            colors.onPrimary,
            colors.primaryContainer,
            colors.onPrimaryContainer,
            // MD3 Core: Secondary (4)
            colors.secondary,
            colors.onSecondary,
            colors.secondaryContainer,
            colors.onSecondaryContainer,
            // MD3 Core: Tertiary (4)
            colors.tertiary,
            colors.onTertiary,
            colors.tertiaryContainer,
            colors.onTertiaryContainer,
            // MD3 Core: Error (4)
            colors.error,
            colors.onError,
            colors.errorContainer,
            colors.onErrorContainer,
            // MD3 Core: Surface (11)
            colors.surface,
            colors.onSurface,
            colors.surfaceContainerLowest,
            colors.surfaceContainerLow,
            colors.surfaceContainer,
            colors.surfaceContainerHigh,
            colors.surfaceContainerHighest,
            colors.surfaceTint,
            colors.onSurfaceVariant,
            colors.inverseSurface,
            colors.inverseOnSurface,
            // MD3 Core: Outline / Scrim (3)
            colors.outline,
            colors.outlineVariant,
            colors.scrim,
            // Semantic: Border (2)
            colors.borderSubtle,
            colors.borderStrong,
            // Semantic: Text (3)
            colors.textPrimary,
            colors.textSecondary,
            colors.textTertiary,
            // Semantic: Background (5)
            colors.bgPrimary,
            colors.bgSurface,
            colors.bgMuted,
            colors.bgHero,
            colors.bgHeroGrad,
            // Semantic: Accent (3)
            colors.accentPrimary,
            colors.accentLink,
            colors.accentWarm,
            // Semantic: Tab (1)
            colors.tabInactive,
            // Semantic: Tag (10)
            colors.tagAmber,
            colors.tagAmberText,
            colors.tagBlue,
            colors.tagBlueText,
            colors.tagPurple,
            colors.tagPurpleText,
            colors.tagRose,
            colors.tagRoseText,
            colors.tagTeal,
            colors.tagTealText,
            // Semantic: Status (2)
            colors.statusComplete,
            colors.statusReading,
            // Semantic: Star (2)
            colors.starColor,
            colors.starRating,
            // Semantic: Match Badge (2)
            colors.matchBadge,
            colors.matchBadgeBg,
          ];

          expect(newTokens.length, equals(60));
          for (final token in newTokens) {
            expect(token, isA<Color>());
          }
        });
      });
    });

    group('copyWith (新トークン)', () {
      test('copyWith で新トークンを個別に変更できる', () {
        const colors = AppColors.light;
        const newPrimary = Color(0xFF000000);

        final copied = colors.copyWith(primary: newPrimary);

        expect(copied.primary, equals(newPrimary));
        expect(copied.onPrimary, equals(colors.onPrimary));
        expect(copied.surface, equals(colors.surface));
      });

      test('copyWith で引数を省略すると新トークンの元の値が保持される', () {
        const colors = AppColors.light;
        final copied = colors.copyWith();

        expect(copied.primary, equals(colors.primary));
        expect(copied.secondary, equals(colors.secondary));
        expect(copied.surface, equals(colors.surface));
        expect(copied.borderSubtle, equals(colors.borderSubtle));
        expect(copied.tagAmber, equals(colors.tagAmber));
        expect(copied.matchBadge, equals(colors.matchBadge));
      });

      test('copyWith で全グループのトークンを同時に変更できる', () {
        const colors = AppColors.light;
        const testColor = Color(0xFF112233);

        final copied = colors.copyWith(
          primary: testColor,
          secondary: testColor,
          tertiary: testColor,
          error: testColor,
          surface: testColor,
          outline: testColor,
          borderSubtle: testColor,
          textPrimary: testColor,
          bgPrimary: testColor,
          accentPrimary: testColor,
          tabInactive: testColor,
          tagAmber: testColor,
          statusComplete: testColor,
          starColor: testColor,
          matchBadge: testColor,
        );

        expect(copied.primary, equals(testColor));
        expect(copied.secondary, equals(testColor));
        expect(copied.tertiary, equals(testColor));
        expect(copied.error, equals(testColor));
        expect(copied.surface, equals(testColor));
        expect(copied.outline, equals(testColor));
        expect(copied.borderSubtle, equals(testColor));
        expect(copied.textPrimary, equals(testColor));
        expect(copied.bgPrimary, equals(testColor));
        expect(copied.accentPrimary, equals(testColor));
        expect(copied.tabInactive, equals(testColor));
        expect(copied.tagAmber, equals(testColor));
        expect(copied.statusComplete, equals(testColor));
        expect(copied.starColor, equals(testColor));
        expect(copied.matchBadge, equals(testColor));
      });
    });

    group('lerp (新トークン)', () {
      test('lerp で新トークンが補間される', () {
        const base = AppColors.light;
        final target = base.copyWith(
          primary: const Color(0xFF000000),
          surface: const Color(0xFF000000),
        );

        final interpolated = base.lerp(target, 0.5);

        expect(interpolated.primary, isNot(equals(base.primary)));
        expect(interpolated.primary, isNot(equals(target.primary)));
        expect(interpolated.surface, isNot(equals(base.surface)));
        expect(interpolated.surface, isNot(equals(target.surface)));
      });

      test('lerp(0.0) で新トークンが元のカラーを返す', () {
        const base = AppColors.light;
        final target = base.copyWith(
          primary: const Color(0xFF000000),
          tagAmber: const Color(0xFF000000),
          matchBadge: const Color(0xFF000000),
        );

        final interpolated = base.lerp(target, 0.0);

        expect(interpolated.primary, equals(base.primary));
        expect(interpolated.tagAmber, equals(base.tagAmber));
        expect(interpolated.matchBadge, equals(base.matchBadge));
      });

      test('lerp(1.0) で新トークンが対象のカラーを返す', () {
        const base = AppColors.light;
        final target = base.copyWith(
          primary: const Color(0xFF000000),
          tagAmber: const Color(0xFF000000),
          matchBadge: const Color(0xFF000000),
        );

        final interpolated = base.lerp(target, 1.0);

        expect(interpolated.primary, equals(target.primary));
        expect(interpolated.tagAmber, equals(target.tagAmber));
        expect(interpolated.matchBadge, equals(target.matchBadge));
      });
    });

    group('copyWith', () {
      test('copyWith で一部のカラーのみ変更できる', () {
        const colors = AppColors.dark;
        const newSuccess = Color(0xFF00FF00);

        final copied = colors.copyWith(successLegacy: newSuccess);

        expect(copied.successLegacy, equals(newSuccess));
        expect(copied.warningLegacy, equals(colors.warningLegacy));
        expect(copied.infoLegacy, equals(colors.infoLegacy));
      });

      test('copyWith で全てのカラーを変更できる', () {
        const colors = AppColors.dark;
        const newSuccess = Color(0xFF00FF00);
        const newWarning = Color(0xFFFF0000);
        const newInfo = Color(0xFF0000FF);

        final copied = colors.copyWith(
          successLegacy: newSuccess,
          warningLegacy: newWarning,
          infoLegacy: newInfo,
        );

        expect(copied.successLegacy, equals(newSuccess));
        expect(copied.warningLegacy, equals(newWarning));
        expect(copied.infoLegacy, equals(newInfo));
      });

      test('copyWith で引数を省略すると元の値が保持される', () {
        const colors = AppColors.dark;
        final copied = colors.copyWith();

        expect(copied.successLegacy, equals(colors.successLegacy));
        expect(copied.warningLegacy, equals(colors.warningLegacy));
        expect(copied.infoLegacy, equals(colors.infoLegacy));
      });
    });

    group('lerp', () {
      test('lerp で2つのカラースキーム間を補間できる', () {
        const base = AppColors.dark;
        final target = base.copyWith(
          successLegacy: const Color(0xFF00FF00),
          warningLegacy: const Color(0xFFFF0000),
          infoLegacy: const Color(0xFF0000FF),
        );

        final interpolated = base.lerp(target, 0.5);

        expect(interpolated, isA<AppColors>());
        expect(interpolated.successLegacy, isNot(equals(base.successLegacy)));
        expect(
          interpolated.successLegacy,
          isNot(equals(target.successLegacy)),
        );
      });

      test('lerp(0.0) は元のカラーを返す', () {
        const base = AppColors.dark;
        final target = base.copyWith(
          successLegacy: const Color(0xFF00FF00),
          warningLegacy: const Color(0xFFFF0000),
          infoLegacy: const Color(0xFF0000FF),
        );

        final interpolated = base.lerp(target, 0.0);

        expect(interpolated.successLegacy, equals(base.successLegacy));
        expect(interpolated.warningLegacy, equals(base.warningLegacy));
        expect(interpolated.infoLegacy, equals(base.infoLegacy));
      });

      test('lerp(1.0) は対象のカラーを返す', () {
        const base = AppColors.dark;
        final target = base.copyWith(
          successLegacy: const Color(0xFF00FF00),
          warningLegacy: const Color(0xFFFF0000),
          infoLegacy: const Color(0xFF0000FF),
        );

        final interpolated = base.lerp(target, 1.0);

        expect(interpolated.successLegacy, equals(target.successLegacy));
        expect(interpolated.warningLegacy, equals(target.warningLegacy));
        expect(interpolated.infoLegacy, equals(target.infoLegacy));
      });

      test('lerp に null が渡された場合は元のカラーを返す', () {
        const colors = AppColors.dark;

        final interpolated = colors.lerp(null, 0.5);

        expect(interpolated, equals(colors));
      });
    });

    group('ThemeData integration', () {
      testWidgets('ThemeData から AppColors にアクセスできる', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              extensions: const [AppColors.dark],
            ),
            home: Builder(
              builder: (context) {
                final colors = Theme.of(context).extension<AppColors>();
                expect(colors, isNotNull);
                expect(colors, equals(AppColors.dark));
                return const SizedBox();
              },
            ),
          ),
        );
      });

      testWidgets('ThemeData から AppColors.light にアクセスできる',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              extensions: const [AppColors.light],
            ),
            home: Builder(
              builder: (context) {
                final colors = Theme.of(context).extension<AppColors>();
                expect(colors, isNotNull);
                expect(colors!.primary, equals(const Color(0xFF3D8A5A)));
                expect(colors.surface, equals(const Color(0xFFFAFAF8)));
                return const SizedBox();
              },
            ),
          ),
        );
      });
    });
  });
}
