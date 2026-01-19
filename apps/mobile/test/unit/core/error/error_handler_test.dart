import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/error_handler.dart';
import 'package:shelfie/core/error/failure.dart';

class MockLogger extends Mock implements Logger {}

class MockCrashlyticsReporter extends Mock implements CrashlyticsReporter {}

void main() {
  late ErrorHandler errorHandler;
  late MockLogger mockLogger;
  late MockCrashlyticsReporter mockCrashlytics;

  setUpAll(() {
    registerFallbackValue(StackTrace.empty);
    registerFallbackValue(
      FlutterErrorDetails(exception: Exception('fallback')),
    );
  });

  setUp(() {
    mockLogger = MockLogger();
    mockCrashlytics = MockCrashlyticsReporter();

    when(
      () => mockCrashlytics.recordError(any(), any()),
    ).thenAnswer((_) async {});
    when(
      () => mockCrashlytics.recordFlutterError(any()),
    ).thenAnswer((_) async {});

    errorHandler = ErrorHandler(
      logger: mockLogger,
      crashlyticsReporter: mockCrashlytics,
      isProduction: false,
    );
  });

  group('ErrorHandler', () {
    group('initialization', () {
      test('should set up FlutterError.onError', () {
        final originalHandler = FlutterError.onError;

        errorHandler.initialize();

        expect(FlutterError.onError, isNotNull);
        expect(FlutterError.onError, isNot(equals(originalHandler)));
      });

      test('should set up PlatformDispatcher.instance.onError', () {
        final originalHandler = PlatformDispatcher.instance.onError;

        errorHandler.initialize();

        expect(PlatformDispatcher.instance.onError, isNotNull);
        expect(
          PlatformDispatcher.instance.onError,
          isNot(equals(originalHandler)),
        );
      });
    });

    group('handleFailure', () {
      test('should log NetworkFailure as warning', () {
        const failure = NetworkFailure(message: 'No connection');

        errorHandler.handleFailure(failure);

        verify(
          () => mockLogger.warning(
            any(that: contains('Network failure')),
            error: any(named: 'error'),
            stackTrace: any(named: 'stackTrace'),
          ),
        ).called(1);
      });

      test('should log ServerFailure as error', () {
        const failure = ServerFailure(message: 'Internal error', code: 'ERR');

        errorHandler.handleFailure(failure);

        verify(
          () => mockLogger.error(
            any(that: contains('Server failure')),
            error: any(named: 'error'),
            stackTrace: any(named: 'stackTrace'),
          ),
        ).called(1);
      });

      test('should log AuthFailure as warning', () {
        const failure = AuthFailure(message: 'Token expired');

        errorHandler.handleFailure(failure);

        verify(
          () => mockLogger.warning(
            any(that: contains('Auth failure')),
            error: any(named: 'error'),
            stackTrace: any(named: 'stackTrace'),
          ),
        ).called(1);
      });

      test('should log ValidationFailure as info', () {
        const failure = ValidationFailure(message: 'Invalid email');

        errorHandler.handleFailure(failure);

        verify(
          () => mockLogger.info(
            any(that: contains('Validation failure')),
            error: any(named: 'error'),
            stackTrace: any(named: 'stackTrace'),
          ),
        ).called(1);
      });

      test('should log UnexpectedFailure as error and report to Crashlytics',
          () {
        final productionHandler = ErrorHandler(
          logger: mockLogger,
          crashlyticsReporter: mockCrashlytics,
          isProduction: true,
        );
        final stackTrace = StackTrace.current;
        final failure = UnexpectedFailure(
          message: 'Something went wrong',
          stackTrace: stackTrace,
        );

        productionHandler.handleFailure(failure);

        verify(
          () => mockLogger.error(
            any(that: contains('Unexpected failure')),
            error: any(named: 'error'),
            stackTrace: any(named: 'stackTrace'),
          ),
        ).called(1);
        verify(
          () => mockCrashlytics.recordError(
            any(that: contains('Something went wrong')),
            any(),
          ),
        ).called(1);
      });

      test('should not report to Crashlytics in non-production', () {
        final stackTrace = StackTrace.current;
        final failure = UnexpectedFailure(
          message: 'Error',
          stackTrace: stackTrace,
        );

        errorHandler.handleFailure(failure);

        verifyNever(
          () => mockCrashlytics.recordError(any(), any()),
        );
      });
    });

    group('handleError', () {
      test('should log error and stackTrace', () {
        final error = Exception('Test error');
        final stackTrace = StackTrace.current;

        errorHandler.handleError(error, stackTrace);

        verify(
          () => mockLogger.error(
            any(that: contains('Unhandled error')),
            error: error,
            stackTrace: stackTrace,
          ),
        ).called(1);
      });

      test('should report to Crashlytics in production', () {
        final productionHandler = ErrorHandler(
          logger: mockLogger,
          crashlyticsReporter: mockCrashlytics,
          isProduction: true,
        );
        final error = Exception('Test error');
        final stackTrace = StackTrace.current;

        productionHandler.handleError(error, stackTrace);

        verify(
          () => mockCrashlytics.recordError(error, stackTrace),
        ).called(1);
      });

      test('should not report to Crashlytics in non-production', () {
        final error = Exception('Test error');
        final stackTrace = StackTrace.current;

        errorHandler.handleError(error, stackTrace);

        verifyNever(
          () => mockCrashlytics.recordError(any(), any()),
        );
      });
    });

    group('handleFlutterError', () {
      test('should log FlutterErrorDetails', () {
        final details = FlutterErrorDetails(
          exception: Exception('Flutter error'),
          stack: StackTrace.current,
          library: 'test library',
          context: ErrorDescription('test context'),
        );

        errorHandler.handleFlutterError(details);

        verify(
          () => mockLogger.error(
            any(that: contains('Flutter error')),
            error: details.exception,
            stackTrace: details.stack,
          ),
        ).called(1);
      });

      test('should report to Crashlytics in production', () {
        final productionHandler = ErrorHandler(
          logger: mockLogger,
          crashlyticsReporter: mockCrashlytics,
          isProduction: true,
        );
        final details = FlutterErrorDetails(
          exception: Exception('Flutter error'),
          stack: StackTrace.current,
        );

        productionHandler.handleFlutterError(details);

        verify(
          () => mockCrashlytics.recordFlutterError(details),
        ).called(1);
      });
    });

    group('classifyException', () {
      test('should classify SocketException as NetworkFailure', () {
        final exception = SocketExceptionMock();

        final failure = ErrorHandler.classifyException(exception);

        expect(failure, isA<NetworkFailure>());
      });

      test('should classify TimeoutException as NetworkFailure', () {
        final exception = TimeoutExceptionMock();

        final failure = ErrorHandler.classifyException(exception);

        expect(failure, isA<NetworkFailure>());
      });

      test('should classify FormatException as ValidationFailure', () {
        const exception = FormatException('Invalid format');

        final failure = ErrorHandler.classifyException(exception);

        expect(failure, isA<ValidationFailure>());
      });

      test('should classify unknown exceptions as UnexpectedFailure', () {
        final exception = Exception('Unknown');

        final failure = ErrorHandler.classifyException(exception);

        expect(failure, isA<UnexpectedFailure>());
      });
    });
  });
}

class SocketExceptionMock implements Exception {
  @override
  String toString() => 'SocketException: Connection refused';
}

class TimeoutExceptionMock implements Exception {
  @override
  String toString() => 'TimeoutException: Request timed out';
}
