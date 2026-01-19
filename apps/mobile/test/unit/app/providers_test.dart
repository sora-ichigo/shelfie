import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/app/providers.dart';
import 'package:shelfie/core/error/error_handler.dart';

/// Mock Logger for testing
class MockLogger extends Mock implements Logger {}

/// Mock CrashlyticsReporter for testing
class MockCrashlyticsReporter extends Mock implements CrashlyticsReporter {}

void main() {
  group('Root level providers', () {
    group('loggerProvider', () {
      test('loggerProvider が Logger インスタンスを返すこと', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final logger = container.read(loggerProvider);

        expect(logger, isA<Logger>());
      });

      test('loggerProvider はデフォルトで ConsoleLogger を返すこと', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final logger = container.read(loggerProvider);

        expect(logger, isA<ConsoleLogger>());
      });
    });

    group('crashlyticsReporterProvider', () {
      test('crashlyticsReporterProvider が CrashlyticsReporter を返すこと', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final reporter = container.read(crashlyticsReporterProvider);

        expect(reporter, isA<CrashlyticsReporter>());
      });

      test('crashlyticsReporterProvider はデフォルトで NoOp 実装を返すこと', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final reporter = container.read(crashlyticsReporterProvider);

        expect(reporter, isA<NoOpCrashlyticsReporter>());
      });
    });

    group('errorHandlerProvider', () {
      test('errorHandlerProvider が ErrorHandler インスタンスを返すこと', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final errorHandler = container.read(errorHandlerProvider);

        expect(errorHandler, isA<ErrorHandler>());
      });

      test('errorHandlerProvider は logger と crashlyticsReporter を使用すること', () {
        final mockLogger = MockLogger();
        final mockReporter = MockCrashlyticsReporter();

        final container = ProviderContainer(
          overrides: [
            loggerProvider.overrideWithValue(mockLogger),
            crashlyticsReporterProvider.overrideWithValue(mockReporter),
          ],
        );
        addTearDown(container.dispose);

        final errorHandler = container.read(errorHandlerProvider);

        expect(errorHandler, isA<ErrorHandler>());
        expect(errorHandler.logger, same(mockLogger));
        expect(errorHandler.crashlyticsReporter, same(mockReporter));
      });
    });

    group('isProductionProvider', () {
      test('isProductionProvider が bool 値を返すこと', () {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final isProduction = container.read(isProductionProvider);

        expect(isProduction, isA<bool>());
      });

      test('isProductionProvider をオーバーライドできること', () {
        final container = ProviderContainer(
          overrides: [
            isProductionProvider.overrideWithValue(true),
          ],
        );
        addTearDown(container.dispose);

        final isProduction = container.read(isProductionProvider);

        expect(isProduction, isTrue);
      });
    });

    group('Provider dependencies', () {
      test('errorHandlerProvider は isProductionProvider に依存すること', () {
        final container = ProviderContainer(
          overrides: [
            isProductionProvider.overrideWithValue(true),
          ],
        );
        addTearDown(container.dispose);

        final errorHandler = container.read(errorHandlerProvider);

        expect(errorHandler.isProduction, isTrue);
      });

      test(
          'isProductionProvider が false の場合、'
          'errorHandler.isProduction も false であること', () {
        final container = ProviderContainer(
          overrides: [
            isProductionProvider.overrideWithValue(false),
          ],
        );
        addTearDown(container.dispose);

        final errorHandler = container.read(errorHandlerProvider);

        expect(errorHandler.isProduction, isFalse);
      });
    });
  });
}
