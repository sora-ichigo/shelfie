import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';

void main() {
  group('ReadingStatus', () {
    group('values', () {
      test('should have all expected values', () {
        expect(ReadingStatus.values, hasLength(4));
        expect(ReadingStatus.values, contains(ReadingStatus.backlog));
        expect(ReadingStatus.values, contains(ReadingStatus.reading));
        expect(ReadingStatus.values, contains(ReadingStatus.completed));
        expect(ReadingStatus.values, contains(ReadingStatus.interested));
      });
    });

    group('displayName', () {
      test('should return Japanese display name for backlog', () {
        expect(ReadingStatus.backlog.displayName, equals('積読'));
      });

      test('should return Japanese display name for reading', () {
        expect(ReadingStatus.reading.displayName, equals('読書中'));
      });

      test('should return Japanese display name for completed', () {
        expect(ReadingStatus.completed.displayName, equals('読了'));
      });

      test('should return Japanese display name for interested', () {
        expect(ReadingStatus.interested.displayName, equals('気になる'));
      });
    });

    group('name', () {
      test('backlog should have correct name', () {
        expect(ReadingStatus.backlog.name, equals('backlog'));
      });

      test('reading should have correct name', () {
        expect(ReadingStatus.reading.name, equals('reading'));
      });

      test('completed should have correct name', () {
        expect(ReadingStatus.completed.name, equals('completed'));
      });

      test('interested should have correct name', () {
        expect(ReadingStatus.interested.name, equals('interested'));
      });
    });

    group('fromString', () {
      test('should convert backlog string', () {
        expect(ReadingStatus.fromString('backlog'), equals(ReadingStatus.backlog));
        expect(ReadingStatus.fromString('BACKLOG'), equals(ReadingStatus.backlog));
      });

      test('should convert reading string', () {
        expect(ReadingStatus.fromString('reading'), equals(ReadingStatus.reading));
        expect(ReadingStatus.fromString('READING'), equals(ReadingStatus.reading));
      });

      test('should convert completed string', () {
        expect(ReadingStatus.fromString('completed'), equals(ReadingStatus.completed));
        expect(ReadingStatus.fromString('COMPLETED'), equals(ReadingStatus.completed));
      });

      test('should convert interested string', () {
        expect(ReadingStatus.fromString('interested'), equals(ReadingStatus.interested));
        expect(ReadingStatus.fromString('INTERESTED'), equals(ReadingStatus.interested));
      });

      test('should throw for invalid string', () {
        expect(
          () => ReadingStatus.fromString('invalid'),
          throwsA(isA<ArgumentError>()),
        );
      });
    });
  });
}
