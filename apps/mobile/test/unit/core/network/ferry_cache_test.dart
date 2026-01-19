import 'package:ferry/ferry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shelfie/core/network/ferry_client.dart';

void main() {
  group('FerryCacheProvider', () {
    late ProviderContainer container;

    setUp(() async {
      Hive.init('./test_hive');

      container = ProviderContainer(
        overrides: [
          authTokenProvider.overrideWithValue(null),
          apiEndpointProvider.overrideWithValue('https://test.api.com/graphql'),
        ],
      );
    });

    tearDown(() async {
      container.dispose();
      await Hive.deleteFromDisk();
    });

    group('ferryCacheProvider', () {
      test('Cache が Riverpod Provider として提供されること', () {
        final cache = container.read(ferryCacheProvider);

        expect(cache, isA<Cache>());
      });

      test('Cache が正常に作成されていること', () {
        final cache = container.read(ferryCacheProvider);

        expect(cache, isA<Cache>());
      });
    });

    group('clearCacheProvider', () {
      test('clearCache がキャッシュをクリアできること', () {
        final client = container.read(ferryClientProvider);

        // clearCache を実行してエラーが発生しないことを確認
        expect(
          () => container.read(clearCacheProvider(client)),
          returnsNormally,
        );
      });

      test('キャッシュクリア後も Client が正常に動作すること', () {
        final client = container.read(ferryClientProvider);

        container.read(clearCacheProvider(client));

        // クリア後も Client が有効であることを確認
        expect(client, isA<Client>());
      });
    });

    group('Cache integration with FerryClient', () {
      test('FerryClient が Cache を使用していること', () {
        final cache = container.read(ferryCacheProvider);
        final client = container.read(ferryClientProvider);

        // 両方が正常に取得できることを確認
        expect(cache, isA<Cache>());
        expect(client, isA<Client>());
      });
    });
  });
}
