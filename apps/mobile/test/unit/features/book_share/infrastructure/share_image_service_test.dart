import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/book_share/infrastructure/share_image_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ShareImageService service;

  setUp(() {
    service = ShareImageService();
  });

  group('ShareImageService', () {
    group('captureAsBytes', () {
      test('boundaryKey にコンテキストがない場合 Left を返す', () async {
        final key = GlobalKey();

        final result = await service.captureAsBytes(boundaryKey: key);

        expect(result.isLeft(), isTrue);
      });

      test('RenderObject が RepaintBoundary でない場合 Left を返す', () async {
        final key = GlobalKey();

        final result = await service.captureAsBytes(boundaryKey: key);

        result.fold(
          (failure) => expect(failure.message, contains('画像の生成に失敗しました')),
          (_) => fail('Expected Left but got Right'),
        );
      });
    });
  });
}
