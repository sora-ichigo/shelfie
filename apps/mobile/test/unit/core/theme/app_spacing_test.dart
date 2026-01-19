import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

void main() {
  group('AppSpacing', () {
    group('定数定義', () {
      test('スペーシング定数が定義されている', () {
        expect(AppSpacing.xxs, isA<double>());
        expect(AppSpacing.xs, isA<double>());
        expect(AppSpacing.sm, isA<double>());
        expect(AppSpacing.md, isA<double>());
        expect(AppSpacing.lg, isA<double>());
        expect(AppSpacing.xl, isA<double>());
        expect(AppSpacing.xxl, isA<double>());
      });

      test('ゼロスペーシングが定義されている', () {
        expect(AppSpacing.zero, equals(0.0));
      });
    });

    group('スペーシング階層', () {
      test('スペーシングが昇順で定義されている', () {
        expect(AppSpacing.xxs, lessThan(AppSpacing.xs));
        expect(AppSpacing.xs, lessThan(AppSpacing.sm));
        expect(AppSpacing.sm, lessThan(AppSpacing.md));
        expect(AppSpacing.md, lessThan(AppSpacing.lg));
        expect(AppSpacing.lg, lessThan(AppSpacing.xl));
        expect(AppSpacing.xl, lessThan(AppSpacing.xxl));
      });

      test('全ての値が正の数である', () {
        expect(AppSpacing.xxs, greaterThan(0));
        expect(AppSpacing.xs, greaterThan(0));
        expect(AppSpacing.sm, greaterThan(0));
        expect(AppSpacing.md, greaterThan(0));
        expect(AppSpacing.lg, greaterThan(0));
        expect(AppSpacing.xl, greaterThan(0));
        expect(AppSpacing.xxl, greaterThan(0));
      });
    });

    group('4pt グリッドシステム', () {
      test('スペーシングは4の倍数である', () {
        expect(AppSpacing.xxs % 4, equals(0));
        expect(AppSpacing.xs % 4, equals(0));
        expect(AppSpacing.sm % 4, equals(0));
        expect(AppSpacing.md % 4, equals(0));
        expect(AppSpacing.lg % 4, equals(0));
        expect(AppSpacing.xl % 4, equals(0));
        expect(AppSpacing.xxl % 4, equals(0));
      });
    });

    group('ヘルパーメソッド', () {
      test('horizontal で水平方向のパディングが取得できる', () {
        final padding = AppSpacing.horizontal(AppSpacing.md);

        expect(padding.left, equals(AppSpacing.md));
        expect(padding.right, equals(AppSpacing.md));
        expect(padding.top, equals(0));
        expect(padding.bottom, equals(0));
      });

      test('vertical で垂直方向のパディングが取得できる', () {
        final padding = AppSpacing.vertical(AppSpacing.md);

        expect(padding.top, equals(AppSpacing.md));
        expect(padding.bottom, equals(AppSpacing.md));
        expect(padding.left, equals(0));
        expect(padding.right, equals(0));
      });

      test('all で全方向のパディングが取得できる', () {
        final padding = AppSpacing.all(AppSpacing.md);

        expect(padding.left, equals(AppSpacing.md));
        expect(padding.right, equals(AppSpacing.md));
        expect(padding.top, equals(AppSpacing.md));
        expect(padding.bottom, equals(AppSpacing.md));
      });
    });
  });
}
