import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_radius.dart';

void main() {
  group('AppRadius', () {
    group('定数値', () {
      test('none は 0 である', () {
        expect(AppRadius.none, equals(0.0));
      });

      test('sm は 4 である', () {
        expect(AppRadius.sm, equals(4.0));
      });

      test('md は 8 である', () {
        expect(AppRadius.md, equals(8.0));
      });

      test('lg は 12 である', () {
        expect(AppRadius.lg, equals(12.0));
      });

      test('full は円形を表す大きな値 (9999) である', () {
        expect(AppRadius.full, equals(9999.0));
      });
    });

    group('BorderRadius ヘルパー', () {
      test('circular で均一な BorderRadius を生成できる', () {
        final radius = AppRadius.circular(AppRadius.md);
        expect(radius.topLeft.x, equals(AppRadius.md));
        expect(radius.topRight.x, equals(AppRadius.md));
        expect(radius.bottomLeft.x, equals(AppRadius.md));
        expect(radius.bottomRight.x, equals(AppRadius.md));
      });
    });
  });
}
