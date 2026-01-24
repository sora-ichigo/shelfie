import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/error/failure.dart';

void main() {
  group('Failure', () {
    group('NetworkFailure', () {
      test('should create with required message', () {
        const failure = NetworkFailure(message: 'No internet connection');

        expect(failure.message, equals('No internet connection'));
      });

      test('should provide user-friendly message', () {
        const failure = NetworkFailure(message: 'Connection timeout');

        expect(
          failure.userMessage,
          equals('ネットワーク接続を確認してください'),
        );
      });
    });

    group('ServerFailure', () {
      test('should create with message and code', () {
        const failure = ServerFailure(
          message: 'Internal server error',
          code: 'INTERNAL_ERROR',
        );

        expect(failure.message, equals('Internal server error'));
        expect(failure.code, equals('INTERNAL_ERROR'));
        expect(failure.statusCode, isNull);
      });

      test('should create with optional statusCode', () {
        const failure = ServerFailure(
          message: 'Not found',
          code: 'NOT_FOUND',
          statusCode: 404,
        );

        expect(failure.statusCode, equals(404));
      });

      test('should provide user-friendly message', () {
        const failure = ServerFailure(
          message: 'Database error',
          code: 'DB_ERROR',
        );

        expect(failure.userMessage, equals('サーバーエラーが発生しました'));
      });
    });

    group('AuthFailure', () {
      test('should create with required message', () {
        const failure = AuthFailure(message: 'Token expired');

        expect(failure.message, equals('Token expired'));
      });

      test('should provide user-friendly message', () {
        const failure = AuthFailure(message: 'Invalid credentials');

        expect(failure.userMessage, equals('再度ログインしてください'));
      });
    });

    group('ValidationFailure', () {
      test('should create with message only', () {
        const failure = ValidationFailure(message: 'Invalid input');

        expect(failure.message, equals('Invalid input'));
        expect(failure.fieldErrors, isNull);
      });

      test('should create with fieldErrors', () {
        const failure = ValidationFailure(
          message: 'Validation failed',
          fieldErrors: {'email': 'Invalid email format'},
        );

        expect(failure.fieldErrors, isNotNull);
        expect(failure.fieldErrors!['email'], equals('Invalid email format'));
      });

      test('should return message as userMessage', () {
        const failure = ValidationFailure(message: 'メールアドレスが無効です');

        expect(failure.userMessage, equals('メールアドレスが無効です'));
      });
    });

    group('UnexpectedFailure', () {
      test('should create with message only', () {
        const failure = UnexpectedFailure(message: 'Unknown error occurred');

        expect(failure.message, equals('Unknown error occurred'));
        expect(failure.stackTrace, isNull);
      });

      test('should create with stackTrace', () {
        final stackTrace = StackTrace.current;
        final failure = UnexpectedFailure(
          message: 'Unexpected error',
          stackTrace: stackTrace,
        );

        expect(failure.stackTrace, equals(stackTrace));
      });

      test('should provide user-friendly message', () {
        const failure = UnexpectedFailure(message: 'Something went wrong');

        expect(failure.userMessage, equals('予期しないエラーが発生しました'));
      });
    });

    group('pattern matching', () {
      test('should support exhaustive when matching', () {
        const failures = <Failure>[
          NetworkFailure(message: 'network'),
          ServerFailure(message: 'server', code: 'ERR'),
          AuthFailure(message: 'auth'),
          ValidationFailure(message: 'validation'),
          UnexpectedFailure(message: 'unexpected'),
          NotFoundFailure(message: 'notFound'),
          ForbiddenFailure(message: 'forbidden'),
          DuplicateBookFailure(message: 'duplicate'),
        ];

        for (final failure in failures) {
          final result = failure.when(
            network: (msg) => 'network: $msg',
            server: (msg, code, statusCode) => 'server: $code',
            auth: (msg) => 'auth: $msg',
            validation: (msg, fieldErrors) => 'validation: $msg',
            unexpected: (msg, stackTrace) => 'unexpected: $msg',
            notFound: (msg) => 'notFound: $msg',
            forbidden: (msg) => 'forbidden: $msg',
            duplicateBook: (msg) => 'duplicate: $msg',
          );

          expect(result, isNotEmpty);
        }
      });

      test('should support maybeWhen matching', () {
        const failure = NetworkFailure(message: 'test');

        final result = failure.maybeWhen(
          network: (msg) => 'matched',
          orElse: () => 'not matched',
        );

        expect(result, equals('matched'));
      });

      test('should support map matching', () {
        const failure = ServerFailure(message: 'test', code: 'ERR');

        final result = failure.map(
          network: (_) => 'network',
          server: (_) => 'server',
          auth: (_) => 'auth',
          validation: (_) => 'validation',
          unexpected: (_) => 'unexpected',
          notFound: (_) => 'notFound',
          forbidden: (_) => 'forbidden',
          duplicateBook: (_) => 'duplicate',
        );

        expect(result, equals('server'));
      });
    });

    group('equality', () {
      test('should be equal when same type and values', () {
        const failure1 = NetworkFailure(message: 'error');
        const failure2 = NetworkFailure(message: 'error');

        expect(failure1, equals(failure2));
        expect(failure1.hashCode, equals(failure2.hashCode));
      });

      test('should not be equal when different values', () {
        const failure1 = NetworkFailure(message: 'error1');
        const failure2 = NetworkFailure(message: 'error2');

        expect(failure1, isNot(equals(failure2)));
      });

      test('should not be equal when different types', () {
        const failure1 = NetworkFailure(message: 'error');
        const failure2 = AuthFailure(message: 'error');

        expect(failure1, isNot(equals(failure2)));
      });
    });

    group('copyWith', () {
      test('should copy NetworkFailure with new values', () {
        const original = NetworkFailure(message: 'original');
        final copied = original.copyWith(message: 'copied');

        expect(copied.message, equals('copied'));
        expect(original.message, equals('original'));
      });

      test('should copy ServerFailure with partial values', () {
        const original = ServerFailure(
          message: 'original',
          code: 'ERR',
          statusCode: 500,
        );
        final copied = original.copyWith(statusCode: 404);

        expect(copied.message, equals('original'));
        expect(copied.code, equals('ERR'));
        expect(copied.statusCode, equals(404));
      });
    });
  });
}
