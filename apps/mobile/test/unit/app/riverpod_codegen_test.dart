import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/app/providers.dart';

void main() {
  group('Riverpod code generation patterns', () {
    group('Provider types', () {
      test('Provider アノテーションで生成された Provider が動作すること', () {
        // loggerProvider は riverpod_annotation で定義される
        final container = ProviderContainer();
        addTearDown(container.dispose);

        // Provider が解決可能であることを確認
        final logger = container.read(loggerProvider);
        expect(logger, isNotNull);
      });

      test('依存関係のある Provider が正しく解決されること', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        // errorHandlerProvider は loggerProvider と
        // crashlyticsReporterProvider に依存
        final errorHandler = container.read(errorHandlerProvider);
        expect(errorHandler, isNotNull);
      });
    });

    group('StateNotifier vs AsyncNotifier guidelines', () {
      test('同期的な状態には StateNotifier パターンを使用', () {
        // 同期的な状態管理の例
        final counterProvider = StateNotifierProvider<CounterNotifier, int>(
          (ref) => CounterNotifier(),
        );

        final container = ProviderContainer();
        addTearDown(container.dispose);

        // 初期値の確認
        expect(container.read(counterProvider), equals(0));

        // 状態の更新
        container.read(counterProvider.notifier).increment();
        expect(container.read(counterProvider), equals(1));
      });

      test('非同期データ取得には AsyncNotifier パターンを使用', () async {
        // 非同期データの取得例
        final asyncDataProvider =
            AsyncNotifierProvider<AsyncDataNotifier, String>(
          AsyncDataNotifier.new,
        );

        final container = ProviderContainer();
        addTearDown(container.dispose);

        // 初期状態は loading
        final initialState = container.read(asyncDataProvider);
        expect(initialState, isA<AsyncLoading<String>>());

        // データ取得後の状態を待機
        await container.read(asyncDataProvider.future);

        // データが取得されていることを確認
        final finalState = container.read(asyncDataProvider);
        expect(finalState, isA<AsyncData<String>>());
        expect(finalState.value, equals('loaded data'));
      });
    });

    group('Provider annotations', () {
      test('@riverpod アノテーションの keepAlive オプション', () {
        // keepAlive: true の場合、Provider は自動的に破棄されない
        // keepAlive: false (デフォルト) の場合、参照がなくなると破棄される
        // このテストはパターンの確認用

        final container = ProviderContainer();
        addTearDown(container.dispose);

        // loggerProvider は keepAlive: true で定義されるべき
        // (アプリ全体で使用されるため)
        final logger = container.read(loggerProvider);
        expect(logger, isNotNull);
      });
    });

    group('ref.watch vs ref.read patterns', () {
      test('ref.watch はリアクティブな依存関係を作成する', () {
        final sourceProvider = StateProvider<int>((ref) => 0);
        final derivedProvider = Provider<String>((ref) {
          final value = ref.watch(sourceProvider);
          return 'Value: $value';
        });

        final container = ProviderContainer();
        addTearDown(container.dispose);

        // 初期値
        expect(container.read(derivedProvider), equals('Value: 0'));

        // source を更新すると derived も更新される
        container.read(sourceProvider.notifier).state = 5;
        expect(container.read(derivedProvider), equals('Value: 5'));
      });

      test('ref.read は一度だけ値を読み取る', () {
        var callCount = 0;
        final sourceProvider = Provider<int>((ref) {
          callCount++;
          return 42;
        });

        final container = ProviderContainer();
        addTearDown(container.dispose);

        // 最初の read
        container.read(sourceProvider);
        expect(callCount, equals(1));

        // 2回目の read (キャッシュから)
        container.read(sourceProvider);
        expect(callCount, equals(1));
      });
    });
  });
}

/// テスト用の StateNotifier
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() {
    state++;
  }
}

/// テスト用の AsyncNotifier
class AsyncDataNotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    // 非同期でデータを取得するシミュレーション
    await Future<void>.delayed(const Duration(milliseconds: 10));
    return 'loaded data';
  }
}
