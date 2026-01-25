import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/utils/imagekit_url_transformer.dart';

void main() {
  group('ImageKitUrlTransformer', () {
    group('transformUrl', () {
      test('ImageKit URLに変換パラメータを追加する', () {
        const url = 'https://ik.imagekit.io/test/avatar.jpg';

        final result = ImageKitUrlTransformer.transformUrl(url, size: 100);

        expect(result, contains('tr='));
        expect(result, contains('w-100'));
        expect(result, contains('h-100'));
      });

      test('顔検出パラメータが追加される', () {
        const url = 'https://ik.imagekit.io/test/avatar.jpg';

        final result = ImageKitUrlTransformer.transformUrl(url, size: 100);

        expect(result, contains('fo-face'));
      });

      test('非ImageKit URLはそのまま返す', () {
        const url = 'https://example.com/avatar.jpg';

        final result = ImageKitUrlTransformer.transformUrl(url, size: 100);

        expect(result, equals(url));
      });

      test('nullのURLはnullを返す', () {
        final result = ImageKitUrlTransformer.transformUrl(null, size: 100);

        expect(result, isNull);
      });

      test('空のURLは空文字を返す', () {
        final result = ImageKitUrlTransformer.transformUrl('', size: 100);

        expect(result, equals(''));
      });

      test('サイズを指定しない場合はデフォルトサイズが使用される', () {
        const url = 'https://ik.imagekit.io/test/avatar.jpg';

        final result = ImageKitUrlTransformer.transformUrl(url);

        expect(result, contains('w-96'));
        expect(result, contains('h-96'));
      });

      test('カスタムサイズが正しく適用される', () {
        const url = 'https://ik.imagekit.io/test/avatar.jpg';

        final result = ImageKitUrlTransformer.transformUrl(url, size: 200);

        expect(result, contains('w-200'));
        expect(result, contains('h-200'));
      });

      test('既存のクエリパラメータがあるURLも正しく処理される', () {
        const url = 'https://ik.imagekit.io/test/avatar.jpg?v=1';

        final result = ImageKitUrlTransformer.transformUrl(url, size: 100);

        expect(result, contains('tr='));
      });
    });

    group('isImageKitUrl', () {
      test('ImageKit URLの場合はtrueを返す', () {
        const url = 'https://ik.imagekit.io/test/avatar.jpg';

        final result = ImageKitUrlTransformer.isImageKitUrl(url);

        expect(result, isTrue);
      });

      test('非ImageKit URLの場合はfalseを返す', () {
        const url = 'https://example.com/avatar.jpg';

        final result = ImageKitUrlTransformer.isImageKitUrl(url);

        expect(result, isFalse);
      });

      test('nullの場合はfalseを返す', () {
        final result = ImageKitUrlTransformer.isImageKitUrl(null);

        expect(result, isFalse);
      });
    });
  });
}
