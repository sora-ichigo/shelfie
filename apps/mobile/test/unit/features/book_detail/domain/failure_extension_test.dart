import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/error/failure.dart';

void main() {
  group('Extended Failure Types', () {
    group('NotFoundFailure', () {
      test('should create with required message', () {
        const failure = NotFoundFailure(message: 'Book not found');

        expect(failure.message, equals('Book not found'));
      });

      test('should provide user-friendly message', () {
        const failure = NotFoundFailure(message: 'Resource not found');

        expect(failure.userMessage, equals('お探しの情報が見つかりませんでした'));
      });

      test('should support pattern matching with when', () {
        const failure = NotFoundFailure(message: 'Not found');

        final result = failure.when(
          network: (msg) => 'network',
          server: (msg, code, statusCode) => 'server',
          auth: (msg) => 'auth',
          validation: (msg, fieldErrors) => 'validation',
          unexpected: (msg, stackTrace) => 'unexpected',
          notFound: (msg) => 'notFound: $msg',
          forbidden: (msg) => 'forbidden',
          duplicateBook: (msg) => 'duplicate',
        );

        expect(result, equals('notFound: Not found'));
      });
    });

    group('ForbiddenFailure', () {
      test('should create with required message', () {
        const failure = ForbiddenFailure(message: 'Access denied');

        expect(failure.message, equals('Access denied'));
      });

      test('should provide user-friendly message', () {
        const failure = ForbiddenFailure(message: 'Not authorized');

        expect(failure.userMessage, equals('この操作は許可されていません'));
      });

      test('should support pattern matching with when', () {
        const failure = ForbiddenFailure(message: 'Forbidden');

        final result = failure.when(
          network: (msg) => 'network',
          server: (msg, code, statusCode) => 'server',
          auth: (msg) => 'auth',
          validation: (msg, fieldErrors) => 'validation',
          unexpected: (msg, stackTrace) => 'unexpected',
          notFound: (msg) => 'notFound',
          forbidden: (msg) => 'forbidden: $msg',
          duplicateBook: (msg) => 'duplicate',
        );

        expect(result, equals('forbidden: Forbidden'));
      });
    });

    group('DuplicateBookFailure', () {
      test('should create with required message', () {
        const failure = DuplicateBookFailure(message: 'Book already in shelf');

        expect(failure.message, equals('Book already in shelf'));
      });

      test('should provide user-friendly message', () {
        const failure = DuplicateBookFailure(message: 'Duplicate');

        expect(failure.userMessage, equals('この書籍は既にマイライブラリに追加されています'));
      });

      test('should support pattern matching with when', () {
        const failure = DuplicateBookFailure(message: 'Already exists');

        final result = failure.when(
          network: (msg) => 'network',
          server: (msg, code, statusCode) => 'server',
          auth: (msg) => 'auth',
          validation: (msg, fieldErrors) => 'validation',
          unexpected: (msg, stackTrace) => 'unexpected',
          notFound: (msg) => 'notFound',
          forbidden: (msg) => 'forbidden',
          duplicateBook: (msg) => 'duplicate: $msg',
        );

        expect(result, equals('duplicate: Already exists'));
      });
    });

    group('equality', () {
      test('NotFoundFailure should be equal when same values', () {
        const failure1 = NotFoundFailure(message: 'error');
        const failure2 = NotFoundFailure(message: 'error');

        expect(failure1, equals(failure2));
        expect(failure1.hashCode, equals(failure2.hashCode));
      });

      test('ForbiddenFailure should be equal when same values', () {
        const failure1 = ForbiddenFailure(message: 'error');
        const failure2 = ForbiddenFailure(message: 'error');

        expect(failure1, equals(failure2));
        expect(failure1.hashCode, equals(failure2.hashCode));
      });

      test('DuplicateBookFailure should be equal when same values', () {
        const failure1 = DuplicateBookFailure(message: 'error');
        const failure2 = DuplicateBookFailure(message: 'error');

        expect(failure1, equals(failure2));
        expect(failure1.hashCode, equals(failure2.hashCode));
      });

      test('different failure types should not be equal', () {
        const notFound = NotFoundFailure(message: 'error');
        const forbidden = ForbiddenFailure(message: 'error');
        const duplicate = DuplicateBookFailure(message: 'error');

        expect(notFound, isNot(equals(forbidden)));
        expect(notFound, isNot(equals(duplicate)));
        expect(forbidden, isNot(equals(duplicate)));
      });
    });

    group('copyWith', () {
      test('NotFoundFailure should copy with new values', () {
        const original = NotFoundFailure(message: 'original');
        final copied = original.copyWith(message: 'copied');

        expect(copied.message, equals('copied'));
        expect(original.message, equals('original'));
      });

      test('ForbiddenFailure should copy with new values', () {
        const original = ForbiddenFailure(message: 'original');
        final copied = original.copyWith(message: 'copied');

        expect(copied.message, equals('copied'));
        expect(original.message, equals('original'));
      });

      test('DuplicateBookFailure should copy with new values', () {
        const original = DuplicateBookFailure(message: 'original');
        final copied = original.copyWith(message: 'copied');

        expect(copied.message, equals('copied'));
        expect(original.message, equals('original'));
      });
    });

    group('exhaustive pattern matching', () {
      test('should cover all failure types', () {
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
            network: (msg) => 'network',
            server: (msg, code, statusCode) => 'server',
            auth: (msg) => 'auth',
            validation: (msg, fieldErrors) => 'validation',
            unexpected: (msg, stackTrace) => 'unexpected',
            notFound: (msg) => 'notFound',
            forbidden: (msg) => 'forbidden',
            duplicateBook: (msg) => 'duplicate',
          );

          expect(result, isNotEmpty);
        }
      });
    });
  });
}
