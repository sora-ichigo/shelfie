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
          expect(colors.surfaceElevatedLegacy, equals(const Color(0xFF2A2A2A)));
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
          expect(colors.successLegacy.green, greaterThan(colors.successLegacy.red));
          expect(colors.successLegacy.green, greaterThan(colors.successLegacy.blue));
        });

        test('ダークモードの warning カラーは黄系', () {
          const colors = AppColors.dark;
          expect(colors.warningLegacy.red, greaterThan(colors.warningLegacy.blue));
        });

        test('ダークモードの info カラーは青系', () {
          const colors = AppColors.dark;
          expect(colors.infoLegacy.blue, greaterThan(colors.infoLegacy.red));
          expect(colors.infoLegacy.blue, greaterThan(colors.infoLegacy.green));
        });
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
        expect(interpolated.successLegacy, isNot(equals(target.successLegacy)));
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
    });
  });
}
