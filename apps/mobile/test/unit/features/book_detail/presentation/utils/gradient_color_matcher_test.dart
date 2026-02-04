import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/book_detail/presentation/utils/gradient_color_matcher.dart';

void main() {
  group('gradientColorPresets', () {
    test('8色定義されている', () {
      expect(gradientColorPresets.length, 8);
    });

    test('全てのプリセット色が不透明である', () {
      for (final color in gradientColorPresets) {
        expect(color.alpha, 255);
      }
    });
  });

  group('defaultGradientColor', () {
    test('Blue (#017BC8) がデフォルトである', () {
      expect(defaultGradientColor, const Color(0xFF017BC8));
    });
  });

  group('matchGradientColor', () {
    test('Blue に完全一致する色を渡すと Blue が返る', () {
      const blue = Color(0xFF017BC8);
      expect(matchGradientColor(blue), blue);
    });

    test('Red に完全一致する色を渡すと Red が返る', () {
      const red = Color(0xFFC62828);
      expect(matchGradientColor(red), red);
    });

    test('プリセットの色に完全一致する場合はそのまま返る', () {
      for (final preset in gradientColorPresets) {
        expect(matchGradientColor(preset), preset);
      }
    });

    test('赤っぽい色は Red プリセットにマッチする', () {
      const reddish = Color(0xFFFF0000);
      expect(matchGradientColor(reddish), const Color(0xFFC62828));
    });

    test('緑っぽい色は Green プリセットにマッチする', () {
      const greenish = Color(0xFF00FF00);
      expect(matchGradientColor(greenish), const Color(0xFF2E7D32));
    });

    test('紫っぽい色は Purple プリセットにマッチする', () {
      const purplish = Color(0xFF9900CC);
      expect(matchGradientColor(purplish), const Color(0xFF7B1FA2));
    });

    test('ピンクっぽい色は Pink プリセットにマッチする', () {
      const pinkish = Color(0xFFFF1493);
      expect(matchGradientColor(pinkish), const Color(0xFFAD1457));
    });

    test('オレンジっぽい色は Orange プリセットにマッチする', () {
      const orangeish = Color(0xFFFF8C00);
      expect(matchGradientColor(orangeish), const Color(0xFFE65100));
    });

    test('濃い青は Indigo プリセットにマッチする', () {
      const darkBlue = Color(0xFF1A237E);
      expect(matchGradientColor(darkBlue), const Color(0xFF283593));
    });

    test('ティール系の色は Teal プリセットにマッチする', () {
      const tealish = Color(0xFF009688);
      expect(matchGradientColor(tealish), const Color(0xFF00897B));
    });

    test('白を渡してもクラッシュしない', () {
      const white = Color(0xFFFFFFFF);
      final result = matchGradientColor(white);
      expect(gradientColorPresets.contains(result), isTrue);
    });

    test('黒を渡してもクラッシュしない', () {
      const black = Color(0xFF000000);
      final result = matchGradientColor(black);
      expect(gradientColorPresets.contains(result), isTrue);
    });
  });

  group('extractGradientColor キャッシュ', () {
    setUp(() {
      clearGradientColorCache();
    });

    test('null URL はデフォルト色を返しキャッシュしない', () async {
      final result = await extractGradientColor(null);
      expect(result, defaultGradientColor);
      expect(gradientColorCacheSize, 0);
    });

    test('空文字 URL はデフォルト色を返しキャッシュしない', () async {
      final result = await extractGradientColor('');
      expect(result, defaultGradientColor);
      expect(gradientColorCacheSize, 0);
    });

    test('clearGradientColorCache でキャッシュがクリアされる', () {
      seedGradientColorCache('https://example.com/img.jpg', const Color(0xFFC62828));
      expect(gradientColorCacheSize, 1);
      clearGradientColorCache();
      expect(gradientColorCacheSize, 0);
    });

    test('キャッシュにヒットした場合はキャッシュ値を返す', () async {
      const url = 'https://example.com/cached.jpg';
      const cachedColor = Color(0xFF2E7D32);
      seedGradientColorCache(url, cachedColor);

      final result = await extractGradientColor(url);
      expect(result, cachedColor);
    });
  });

  group('getCachedGradientColor', () {
    setUp(() {
      clearGradientColorCache();
    });

    test('null URL は null を返す', () {
      expect(getCachedGradientColor(null), isNull);
    });

    test('空文字 URL は null を返す', () {
      expect(getCachedGradientColor(''), isNull);
    });

    test('キャッシュにない URL は null を返す', () {
      expect(getCachedGradientColor('https://example.com/unknown.jpg'), isNull);
    });

    test('キャッシュにある URL はキャッシュ値を返す', () {
      const url = 'https://example.com/img.jpg';
      const color = Color(0xFF2E7D32);
      seedGradientColorCache(url, color);
      expect(getCachedGradientColor(url), color);
    });
  });
}
