import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_detail/domain/user_book.dart';

void main() {
  group('UserBook', () {
    group('creation', () {
      test('should create with required fields only', () {
        final addedAt = DateTime(2024, 1, 15);
        final userBook = UserBook(
          id: 1,
          readingStatus: ReadingStatus.backlog,
          addedAt: addedAt,
        );

        expect(userBook.id, equals(1));
        expect(userBook.readingStatus, equals(ReadingStatus.backlog));
        expect(userBook.addedAt, equals(addedAt));
        expect(userBook.completedAt, isNull);
        expect(userBook.note, isNull);
        expect(userBook.noteUpdatedAt, isNull);
      });

      test('should create with all optional fields', () {
        final addedAt = DateTime(2024, 1, 15);
        final completedAt = DateTime(2024, 2, 20);
        final noteUpdatedAt = DateTime(2024, 2, 25);

        final userBook = UserBook(
          id: 1,
          readingStatus: ReadingStatus.completed,
          addedAt: addedAt,
          completedAt: completedAt,
          note: 'Great book about Flutter!',
          noteUpdatedAt: noteUpdatedAt,
        );

        expect(userBook.id, equals(1));
        expect(userBook.readingStatus, equals(ReadingStatus.completed));
        expect(userBook.addedAt, equals(addedAt));
        expect(userBook.completedAt, equals(completedAt));
        expect(userBook.note, equals('Great book about Flutter!'));
        expect(userBook.noteUpdatedAt, equals(noteUpdatedAt));
      });

      test('should allow empty note', () {
        final userBook = UserBook(
          id: 1,
          readingStatus: ReadingStatus.reading,
          addedAt: DateTime(2024, 1, 15),
          note: '',
          noteUpdatedAt: DateTime(2024, 1, 20),
        );

        expect(userBook.note, equals(''));
      });
    });

    group('equality', () {
      test('should be equal when same values', () {
        final addedAt = DateTime(2024, 1, 15);

        final userBook1 = UserBook(
          id: 1,
          readingStatus: ReadingStatus.reading,
          addedAt: addedAt,
        );

        final userBook2 = UserBook(
          id: 1,
          readingStatus: ReadingStatus.reading,
          addedAt: addedAt,
        );

        expect(userBook1, equals(userBook2));
        expect(userBook1.hashCode, equals(userBook2.hashCode));
      });

      test('should not be equal when different id', () {
        final addedAt = DateTime(2024, 1, 15);

        final userBook1 = UserBook(
          id: 1,
          readingStatus: ReadingStatus.reading,
          addedAt: addedAt,
        );

        final userBook2 = UserBook(
          id: 2,
          readingStatus: ReadingStatus.reading,
          addedAt: addedAt,
        );

        expect(userBook1, isNot(equals(userBook2)));
      });

      test('should not be equal when different readingStatus', () {
        final addedAt = DateTime(2024, 1, 15);

        final userBook1 = UserBook(
          id: 1,
          readingStatus: ReadingStatus.reading,
          addedAt: addedAt,
        );

        final userBook2 = UserBook(
          id: 1,
          readingStatus: ReadingStatus.completed,
          addedAt: addedAt,
        );

        expect(userBook1, isNot(equals(userBook2)));
      });
    });

    group('copyWith', () {
      test('should copy with new readingStatus', () {
        final addedAt = DateTime(2024, 1, 15);
        final original = UserBook(
          id: 1,
          readingStatus: ReadingStatus.reading,
          addedAt: addedAt,
        );

        final copied = original.copyWith(
          readingStatus: ReadingStatus.completed,
        );

        expect(copied.id, equals(1));
        expect(copied.readingStatus, equals(ReadingStatus.completed));
        expect(copied.addedAt, equals(addedAt));
      });

      test('should copy with completedAt', () {
        final addedAt = DateTime(2024, 1, 15);
        final completedAt = DateTime(2024, 2, 20);

        final original = UserBook(
          id: 1,
          readingStatus: ReadingStatus.reading,
          addedAt: addedAt,
        );

        final copied = original.copyWith(completedAt: completedAt);

        expect(copied.completedAt, equals(completedAt));
      });

      test('should copy with note and noteUpdatedAt', () {
        final addedAt = DateTime(2024, 1, 15);
        final noteUpdatedAt = DateTime(2024, 2, 25);

        final original = UserBook(
          id: 1,
          readingStatus: ReadingStatus.reading,
          addedAt: addedAt,
        );

        final copied = original.copyWith(
          note: 'New note',
          noteUpdatedAt: noteUpdatedAt,
        );

        expect(copied.note, equals('New note'));
        expect(copied.noteUpdatedAt, equals(noteUpdatedAt));
      });
    });

    group('hasNote', () {
      test('should return true when note is not null and not empty', () {
        final userBook = UserBook(
          id: 1,
          readingStatus: ReadingStatus.reading,
          addedAt: DateTime(2024, 1, 15),
          note: 'A note',
        );

        expect(userBook.hasNote, isTrue);
      });

      test('should return false when note is null', () {
        final userBook = UserBook(
          id: 1,
          readingStatus: ReadingStatus.reading,
          addedAt: DateTime(2024, 1, 15),
        );

        expect(userBook.hasNote, isFalse);
      });

      test('should return false when note is empty', () {
        final userBook = UserBook(
          id: 1,
          readingStatus: ReadingStatus.reading,
          addedAt: DateTime(2024, 1, 15),
          note: '',
        );

        expect(userBook.hasNote, isFalse);
      });

      test('should return false when note is whitespace only', () {
        final userBook = UserBook(
          id: 1,
          readingStatus: ReadingStatus.reading,
          addedAt: DateTime(2024, 1, 15),
          note: '   ',
        );

        expect(userBook.hasNote, isFalse);
      });
    });

    group('hasThoughts', () {
      test('should return true when thoughts is not null and not empty', () {
        final userBook = UserBook(
          id: 1,
          readingStatus: ReadingStatus.reading,
          addedAt: DateTime(2024, 1, 15),
          thoughts: 'Great book!',
        );

        expect(userBook.hasThoughts, isTrue);
      });

      test('should return false when thoughts is null', () {
        final userBook = UserBook(
          id: 1,
          readingStatus: ReadingStatus.reading,
          addedAt: DateTime(2024, 1, 15),
        );

        expect(userBook.hasThoughts, isFalse);
      });

      test('should return false when thoughts is empty', () {
        final userBook = UserBook(
          id: 1,
          readingStatus: ReadingStatus.reading,
          addedAt: DateTime(2024, 1, 15),
          thoughts: '',
        );

        expect(userBook.hasThoughts, isFalse);
      });

      test('should return false when thoughts is whitespace only', () {
        final userBook = UserBook(
          id: 1,
          readingStatus: ReadingStatus.reading,
          addedAt: DateTime(2024, 1, 15),
          thoughts: '   ',
        );

        expect(userBook.hasThoughts, isFalse);
      });
    });

    group('isCompleted', () {
      test('should return true when readingStatus is completed', () {
        final userBook = UserBook(
          id: 1,
          readingStatus: ReadingStatus.completed,
          addedAt: DateTime(2024, 1, 15),
        );

        expect(userBook.isCompleted, isTrue);
      });

      test('should return false when readingStatus is not completed', () {
        final statuses = [
          ReadingStatus.backlog,
          ReadingStatus.reading,
          ReadingStatus.interested,
        ];

        for (final status in statuses) {
          final userBook = UserBook(
            id: 1,
            readingStatus: status,
            addedAt: DateTime(2024, 1, 15),
          );

          expect(userBook.isCompleted, isFalse);
        }
      });
    });
  });
}
