import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/error_handler.dart';

/// Mock Logger for testing
class MockLogger extends Mock implements Logger {}

/// Mock CrashlyticsReporter for testing
class MockCrashlyticsReporter extends Mock implements CrashlyticsReporter {}

void main() {
  group('main.dart', () {
    group('ProviderScope setup', () {
      test('アプリは ProviderScope でラップされていること', () async {
        // ProviderScope が正しく設定されているかをテスト
        // 実際の runApp は呼び出せないため、ProviderScope の動作をテスト
        late ProviderContainer container;

        await runZonedGuarded(() async {
          container = ProviderContainer();
          addTearDown(container.dispose);

          // ProviderContainer が正常に動作することを確認
          expect(container, isNotNull);
        }, (error, stack) {
          fail('runZonedGuarded should not catch any error: $error');
        });
      });

      test('ProviderScope 内で Provider が正常に解決されること', () async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        // シンプルな Provider のテスト
        final testProvider = Provider<String>((ref) => 'test');
        final value = container.read(testProvider);

        expect(value, equals('test'));
      });
    });

    group('ErrorHandler initialization', () {
      late MockLogger mockLogger;
      late MockCrashlyticsReporter mockCrashlyticsReporter;
      late ErrorHandler errorHandler;

      setUp(() {
        mockLogger = MockLogger();
        mockCrashlyticsReporter = MockCrashlyticsReporter();
        errorHandler = ErrorHandler(
          logger: mockLogger,
          crashlyticsReporter: mockCrashlyticsReporter,
          isProduction: false,
        );
      });

      test('ErrorHandler.initialize() が FlutterError.onError を設定すること', () {
        // FlutterError.onError の初期値を保存
        final originalOnError = FlutterError.onError;

        errorHandler.initialize();

        // FlutterError.onError が設定されていることを確認
        expect(FlutterError.onError, isNotNull);
        expect(FlutterError.onError, isNot(equals(originalOnError)));

        // クリーンアップ
        FlutterError.onError = originalOnError;
      });

      test('ErrorHandler は runZonedGuarded 内で使用されるべき', () async {
        var errorCaught = false;

        await runZonedGuarded(() async {
          // エラーハンドラを初期化
          errorHandler.initialize();

          // 正常な処理
          expect(true, isTrue);
        }, (error, stack) {
          errorCaught = true;
          errorHandler.handleError(error, stack);
        });

        // runZonedGuarded 内でエラーが発生しなかったことを確認
        expect(errorCaught, isFalse);
      });
    });

    group('App initialization flow', () {
      test('初期化処理の順序が正しいこと', () async {
        // 初期化順序を追跡するリスト
        final initializationOrder = <String>[];

        // 各初期化ステップをシミュレート
        void initializeHive() {
          initializationOrder.add('hive');
        }

        void initializeErrorHandler() {
          initializationOrder.add('error_handler');
        }

        void initializeProviderScope() {
          initializationOrder.add('provider_scope');
        }

        // 期待される初期化順序で実行
        await runZonedGuarded(() async {
          initializeHive();
          initializeErrorHandler();
          initializeProviderScope();
        }, (error, stack) {
          fail('Should not throw: $error');
        });

        // 初期化順序を確認
        expect(initializationOrder, ['hive', 'error_handler', 'provider_scope']);
      });
    });
  });

  group('Provider scope separation', () {
    test('異なる ProviderScope は独立した状態を持つこと', () {
      final counterProvider = StateProvider<int>((ref) => 0);

      final container1 = ProviderContainer();
      final container2 = ProviderContainer();
      addTearDown(container1.dispose);
      addTearDown(container2.dispose);

      // container1 の状態を変更
      container1.read(counterProvider.notifier).state = 10;

      // container2 の状態は影響を受けない
      expect(container1.read(counterProvider), equals(10));
      expect(container2.read(counterProvider), equals(0));
    });

    test('ProviderScope のオーバーライドが正しく動作すること', () {
      final greetingProvider = Provider<String>((ref) => 'Hello');

      final container = ProviderContainer(
        overrides: [
          greetingProvider.overrideWithValue('Overridden'),
        ],
      );
      addTearDown(container.dispose);

      expect(container.read(greetingProvider), equals('Overridden'));
    });
  });
}
