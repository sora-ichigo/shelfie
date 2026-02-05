import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/book_share/infrastructure/line_share_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late LineShareService service;
  late List<MethodCall> log;

  setUp(() {
    service = LineShareService();
    log = [];
  });

  void setUpChannel({
    bool isAvailable = true,
    bool shareResult = true,
  }) {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('app.shelfie.shelfie/line_share'),
      (call) async {
        log.add(call);
        switch (call.method) {
          case 'isAvailable':
            return isAvailable;
          case 'shareImage':
            return shareResult;
          default:
            return null;
        }
      },
    );
  }

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('app.shelfie.shelfie/line_share'),
      null,
    );
  });

  group('LineShareService', () {
    group('isAvailable', () {
      test('LINE がインストール済みの場合 true を返す', () async {
        setUpChannel(isAvailable: true);

        final result = await service.isAvailable();

        expect(result, isTrue);
        expect(log.single.method, 'isAvailable');
      });

      test('LINE が未インストールの場合 false を返す', () async {
        setUpChannel(isAvailable: false);

        final result = await service.isAvailable();

        expect(result, isFalse);
      });

      test('例外が発生した場合 false を返す', () async {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
          const MethodChannel('app.shelfie.shelfie/line_share'),
          (call) async => throw PlatformException(code: 'ERROR'),
        );

        final result = await service.isAvailable();

        expect(result, isFalse);
      });
    });

    group('shareImage', () {
      test('シェア成功時に true を返す', () async {
        setUpChannel(shareResult: true);

        final result = await service.shareImage(filePath: '/tmp/test.png');

        expect(result, isTrue);
        expect(log.single.method, 'shareImage');
        expect(log.single.arguments, {'filePath': '/tmp/test.png'});
      });

      test('シェア失敗時に false を返す', () async {
        setUpChannel(shareResult: false);

        final result = await service.shareImage(filePath: '/tmp/test.png');

        expect(result, isFalse);
      });

      test('例外が発生した場合 false を返す', () async {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(
          const MethodChannel('app.shelfie.shelfie/line_share'),
          (call) async => throw PlatformException(code: 'ERROR'),
        );

        final result = await service.shareImage(filePath: '/tmp/test.png');

        expect(result, isFalse);
      });
    });
  });
}
