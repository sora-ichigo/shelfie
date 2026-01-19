import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_typography.dart';

void main() {
  group('AppTypography', () {
    group('定数定義', () {
      test('ディスプレイスタイルが定義されている', () {
        expect(AppTypography.displayLarge, isA<TextStyle>());
        expect(AppTypography.displayMedium, isA<TextStyle>());
        expect(AppTypography.displaySmall, isA<TextStyle>());
      });

      test('ヘッドラインスタイルが定義されている', () {
        expect(AppTypography.headlineLarge, isA<TextStyle>());
        expect(AppTypography.headlineMedium, isA<TextStyle>());
        expect(AppTypography.headlineSmall, isA<TextStyle>());
      });

      test('タイトルスタイルが定義されている', () {
        expect(AppTypography.titleLarge, isA<TextStyle>());
        expect(AppTypography.titleMedium, isA<TextStyle>());
        expect(AppTypography.titleSmall, isA<TextStyle>());
      });

      test('ボディスタイルが定義されている', () {
        expect(AppTypography.bodyLarge, isA<TextStyle>());
        expect(AppTypography.bodyMedium, isA<TextStyle>());
        expect(AppTypography.bodySmall, isA<TextStyle>());
      });

      test('ラベルスタイルが定義されている', () {
        expect(AppTypography.labelLarge, isA<TextStyle>());
        expect(AppTypography.labelMedium, isA<TextStyle>());
        expect(AppTypography.labelSmall, isA<TextStyle>());
      });
    });

    group('フォントサイズ階層', () {
      test('ディスプレイはヘッドラインより大きい', () {
        expect(
          AppTypography.displayLarge.fontSize,
          greaterThan(AppTypography.headlineLarge.fontSize!),
        );
      });

      test('ヘッドラインはタイトルより大きい', () {
        expect(
          AppTypography.headlineLarge.fontSize,
          greaterThan(AppTypography.titleLarge.fontSize!),
        );
      });

      test('タイトルはボディより大きい', () {
        expect(
          AppTypography.titleLarge.fontSize,
          greaterThan(AppTypography.bodyLarge.fontSize!),
        );
      });

      test('同カテゴリ内でサイズが階層化されている', () {
        expect(
          AppTypography.bodyLarge.fontSize,
          greaterThan(AppTypography.bodyMedium.fontSize!),
        );
        expect(
          AppTypography.bodyMedium.fontSize,
          greaterThan(AppTypography.bodySmall.fontSize!),
        );
      });
    });

    group('textTheme', () {
      test('Material 3 TextTheme を返す', () {
        final textTheme = AppTypography.textTheme;

        expect(textTheme, isA<TextTheme>());
        expect(textTheme.displayLarge, isNotNull);
        expect(textTheme.bodyMedium, isNotNull);
        expect(textTheme.labelSmall, isNotNull);
      });

      test('textTheme の各スタイルが定数と一致する', () {
        final textTheme = AppTypography.textTheme;

        expect(textTheme.displayLarge, equals(AppTypography.displayLarge));
        expect(textTheme.bodyMedium, equals(AppTypography.bodyMedium));
        expect(textTheme.labelSmall, equals(AppTypography.labelSmall));
      });
    });
  });
}
