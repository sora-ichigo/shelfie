import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';

void main() {
  group('ShelfEntry', () {
    final now = DateTime.now();
    final completedAt = DateTime.now().add(const Duration(days: 7));

    test('should create with required fields', () {
      final entry = ShelfEntry(
        userBookId: 1,
        externalId: 'book-123',
        readingStatus: ReadingStatus.backlog,
        addedAt: now,
      );

      expect(entry.userBookId, 1);
      expect(entry.externalId, 'book-123');
      expect(entry.readingStatus, ReadingStatus.backlog);
      expect(entry.addedAt, now);
      expect(entry.completedAt, isNull);
      expect(entry.note, isNull);
      expect(entry.noteUpdatedAt, isNull);
    });

    test('should create with all fields', () {
      final noteUpdatedAt = DateTime.now();
      final entry = ShelfEntry(
        userBookId: 2,
        externalId: 'book-456',
        readingStatus: ReadingStatus.completed,
        addedAt: now,
        completedAt: completedAt,
        note: 'Great book!',
        noteUpdatedAt: noteUpdatedAt,
      );

      expect(entry.userBookId, 2);
      expect(entry.externalId, 'book-456');
      expect(entry.readingStatus, ReadingStatus.completed);
      expect(entry.addedAt, now);
      expect(entry.completedAt, completedAt);
      expect(entry.note, 'Great book!');
      expect(entry.noteUpdatedAt, noteUpdatedAt);
    });

    test('hasNote returns true when note is not empty', () {
      final entry = ShelfEntry(
        userBookId: 1,
        externalId: 'book-123',
        readingStatus: ReadingStatus.reading,
        addedAt: now,
        note: 'Some note',
      );

      expect(entry.hasNote, isTrue);
    });

    test('hasNote returns false when note is null', () {
      final entry = ShelfEntry(
        userBookId: 1,
        externalId: 'book-123',
        readingStatus: ReadingStatus.reading,
        addedAt: now,
      );

      expect(entry.hasNote, isFalse);
    });

    test('hasNote returns false when note is empty', () {
      final entry = ShelfEntry(
        userBookId: 1,
        externalId: 'book-123',
        readingStatus: ReadingStatus.reading,
        addedAt: now,
        note: '',
      );

      expect(entry.hasNote, isFalse);
    });

    test('hasNote returns false when note is only whitespace', () {
      final entry = ShelfEntry(
        userBookId: 1,
        externalId: 'book-123',
        readingStatus: ReadingStatus.reading,
        addedAt: now,
        note: '   ',
      );

      expect(entry.hasNote, isFalse);
    });

    test('isCompleted returns true when status is completed', () {
      final entry = ShelfEntry(
        userBookId: 1,
        externalId: 'book-123',
        readingStatus: ReadingStatus.completed,
        addedAt: now,
      );

      expect(entry.isCompleted, isTrue);
    });

    test('isCompleted returns false when status is not completed', () {
      final statuses = [
        ReadingStatus.backlog,
        ReadingStatus.reading,
        ReadingStatus.dropped,
      ];

      for (final status in statuses) {
        final entry = ShelfEntry(
          userBookId: 1,
          externalId: 'book-123',
          readingStatus: status,
          addedAt: now,
        );

        expect(entry.isCompleted, isFalse, reason: 'Failed for status: $status');
      }
    });

    test('copyWith creates a new instance with updated values', () {
      final entry = ShelfEntry(
        userBookId: 1,
        externalId: 'book-123',
        readingStatus: ReadingStatus.backlog,
        addedAt: now,
      );

      final updated = entry.copyWith(
        readingStatus: ReadingStatus.reading,
        note: 'New note',
      );

      expect(updated.userBookId, 1);
      expect(updated.externalId, 'book-123');
      expect(updated.readingStatus, ReadingStatus.reading);
      expect(updated.note, 'New note');
    });

    test('equality compares all fields', () {
      final entry1 = ShelfEntry(
        userBookId: 1,
        externalId: 'book-123',
        readingStatus: ReadingStatus.backlog,
        addedAt: now,
      );

      final entry2 = ShelfEntry(
        userBookId: 1,
        externalId: 'book-123',
        readingStatus: ReadingStatus.backlog,
        addedAt: now,
      );

      expect(entry1, equals(entry2));
    });
  });
}
