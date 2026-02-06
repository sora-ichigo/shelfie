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

        expect(colors.success, isA<Color>());
        expect(colors.warning, isA<Color>());
        expect(colors.info, isA<Color>());
      });

      group('Semantic colors', () {
        test('primary はティール色 (#2B9E8F) で定義されている', () {
          const colors = AppColors.dark;
          expect(colors.primary, equals(const Color(0xFF2B9E8F)));
        });

        test('primaryPressed はティール色 (#238275) で定義されている', () {
          const colors = AppColors.dark;
          expect(colors.primaryPressed, equals(const Color(0xFF238275)));
        });

        test('star はゴールド色 (#FFD60A) で定義されている', () {
          const colors = AppColors.dark;
          expect(colors.star, equals(const Color(0xFFFFD60A)));
        });

        test('background はダーク色 (#121212) で定義されている', () {
          const colors = AppColors.dark;
          expect(colors.background, equals(const Color(0xFF121212)));
        });
      });

      group('Surface colors', () {
        test('surface は定義されている', () {
          const colors = AppColors.dark;
          expect(colors.surface, equals(const Color(0xFF1E1E1E)));
        });

        test('surfaceElevated は定義されている', () {
          const colors = AppColors.dark;
          expect(colors.surfaceElevated, equals(const Color(0xFF2A2A2A)));
        });
      });

      group('Utility colors', () {
        test('border は定義されている', () {
          const colors = AppColors.dark;
          expect(colors.border, equals(const Color(0xFF333333)));
        });

        test('inactive は定義されている', () {
          const colors = AppColors.dark;
          expect(colors.inactive, equals(const Color(0xFF666666)));
        });
      });

      group('Text colors', () {
        test('textPrimary は白色で定義されている', () {
          const colors = AppColors.dark;
          expect(colors.textPrimary, equals(const Color(0xFFFFFFFF)));
        });

        test('textSecondary はグレー色で定義されている', () {
          const colors = AppColors.dark;
          expect(colors.textSecondary, equals(const Color(0xFFB0B0B0)));
        });
      });

      group('Feedback colors', () {
        test('destructive は赤系で定義されている', () {
          const colors = AppColors.dark;
          expect(colors.destructive, equals(const Color(0xFFCF4F4A)));
        });

        test('ダークモードの success カラーは緑系', () {
          const colors = AppColors.dark;
          expect(colors.success.green, greaterThan(colors.success.red));
          expect(colors.success.green, greaterThan(colors.success.blue));
        });

        test('ダークモードの warning カラーは黄系', () {
          const colors = AppColors.dark;
          expect(colors.warning.red, greaterThan(colors.warning.blue));
        });

        test('ダークモードの info カラーは青系', () {
          const colors = AppColors.dark;
          expect(colors.info.blue, greaterThan(colors.info.red));
          expect(colors.info.blue, greaterThan(colors.info.green));
        });
      });
    });

    group('copyWith', () {
      test('copyWith で一部のカラーのみ変更できる', () {
        const colors = AppColors.dark;
        const newSuccess = Color(0xFF00FF00);

        final copied = colors.copyWith(success: newSuccess);

        expect(copied.success, equals(newSuccess));
        expect(copied.warning, equals(colors.warning));
        expect(copied.info, equals(colors.info));
      });

      test('copyWith で全てのカラーを変更できる', () {
        const colors = AppColors.dark;
        const newSuccess = Color(0xFF00FF00);
        const newWarning = Color(0xFFFF0000);
        const newInfo = Color(0xFF0000FF);

        final copied = colors.copyWith(
          success: newSuccess,
          warning: newWarning,
          info: newInfo,
        );

        expect(copied.success, equals(newSuccess));
        expect(copied.warning, equals(newWarning));
        expect(copied.info, equals(newInfo));
      });

      test('copyWith で引数を省略すると元の値が保持される', () {
        const colors = AppColors.dark;
        final copied = colors.copyWith();

        expect(copied.success, equals(colors.success));
        expect(copied.warning, equals(colors.warning));
        expect(copied.info, equals(colors.info));
      });
    });

    group('lerp', () {
      test('lerp で2つのカラースキーム間を補間できる', () {
        const base = AppColors.dark;
        final target = base.copyWith(
          success: const Color(0xFF00FF00),
          warning: const Color(0xFFFF0000),
          info: const Color(0xFF0000FF),
        );

        final interpolated = base.lerp(target, 0.5);

        expect(interpolated, isA<AppColors>());
        expect(interpolated.success, isNot(equals(base.success)));
        expect(interpolated.success, isNot(equals(target.success)));
      });

      test('lerp(0.0) は元のカラーを返す', () {
        const base = AppColors.dark;
        final target = base.copyWith(
          success: const Color(0xFF00FF00),
          warning: const Color(0xFFFF0000),
          info: const Color(0xFF0000FF),
        );

        final interpolated = base.lerp(target, 0.0);

        expect(interpolated.success, equals(base.success));
        expect(interpolated.warning, equals(base.warning));
        expect(interpolated.info, equals(base.info));
      });

      test('lerp(1.0) は対象のカラーを返す', () {
        const base = AppColors.dark;
        final target = base.copyWith(
          success: const Color(0xFF00FF00),
          warning: const Color(0xFFFF0000),
          info: const Color(0xFF0000FF),
        );

        final interpolated = base.lerp(target, 1.0);

        expect(interpolated.success, equals(target.success));
        expect(interpolated.warning, equals(target.warning));
        expect(interpolated.info, equals(target.info));
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
