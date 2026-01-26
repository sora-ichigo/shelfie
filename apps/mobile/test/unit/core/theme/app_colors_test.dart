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
        test('accent はターコイズ色 (#4FD1C5) で定義されている', () {
          const colors = AppColors.dark;
          expect(colors.accent, equals(const Color(0xFF4FD1C5)));
        });

        test('accentSecondary はゴールド色 (#F6C94A) で定義されている', () {
          const colors = AppColors.dark;
          expect(colors.accentSecondary, equals(const Color(0xFFF6C94A)));
        });

        test('background はダーク色 (#0A0A0A) で定義されている', () {
          const colors = AppColors.dark;
          expect(colors.background, equals(const Color(0xFF0A0A0A)));
        });
      });

      group('Surface colors', () {
        test('surface は定義されている', () {
          const colors = AppColors.dark;
          expect(colors.surface, equals(const Color(0xFF1A1A1A)));
        });

        test('surfaceHigh は定義されている', () {
          const colors = AppColors.dark;
          expect(colors.surfaceHigh, equals(const Color(0xFF2A2A2A)));
        });

        test('overlay は30%不透明度で定義されている', () {
          const colors = AppColors.dark;
          expect(colors.overlay, equals(const Color(0x4D000000)));
        });
      });

      group('Text colors', () {
        test('foreground は白色で定義されている', () {
          const colors = AppColors.dark;
          expect(colors.foreground, equals(const Color(0xFFFFFFFF)));
        });

        test('foregroundMuted はグレー色で定義されている', () {
          const colors = AppColors.dark;
          expect(colors.foregroundMuted, equals(const Color(0xFFA0A0A0)));
        });
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
