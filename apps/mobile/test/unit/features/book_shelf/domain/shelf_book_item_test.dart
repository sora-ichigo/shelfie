import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';

void main() {
  group('ShelfBookItem', () {
    final now = DateTime(2024, 1, 15, 10, 30);

    group('factory', () {
      test('should create with required fields', () {
        final item = ShelfBookItem(
          userBookId: 1,
          externalId: 'external-123',
          title: 'Test Book',
          authors: ['Author One'],
          readingStatus: ReadingStatus.backlog,
          addedAt: now,
        );

        expect(item.userBookId, 1);
        expect(item.externalId, 'external-123');
        expect(item.title, 'Test Book');
        expect(item.authors, ['Author One']);
        expect(item.readingStatus, ReadingStatus.backlog);
        expect(item.addedAt, now);
        expect(item.coverImageUrl, isNull);
        expect(item.rating, isNull);
        expect(item.completedAt, isNull);
      });

      test('should create with all optional fields', () {
        final completedAt = DateTime(2024, 1, 20);
        final item = ShelfBookItem(
          userBookId: 2,
          externalId: 'external-456',
          title: 'Complete Book',
          authors: ['Author A', 'Author B'],
          readingStatus: ReadingStatus.completed,
          addedAt: now,
          coverImageUrl: 'https://example.com/cover.jpg',
          rating: 5,
          completedAt: completedAt,
        );

        expect(item.userBookId, 2);
        expect(item.coverImageUrl, 'https://example.com/cover.jpg');
        expect(item.rating, 5);
        expect(item.completedAt, completedAt);
        expect(item.authors, ['Author A', 'Author B']);
      });
    });

    group('primaryAuthor', () {
      test('should return first author when authors exist', () {
        final item = ShelfBookItem(
          userBookId: 1,
          externalId: 'id',
          title: 'Title',
          authors: ['First Author', 'Second Author'],
          readingStatus: ReadingStatus.backlog,
          addedAt: now,
        );

        expect(item.primaryAuthor, 'First Author');
      });

      test('should return empty string when authors is empty', () {
        final item = ShelfBookItem(
          userBookId: 1,
          externalId: 'id',
          title: 'Title',
          authors: [],
          readingStatus: ReadingStatus.backlog,
          addedAt: now,
        );

        expect(item.primaryAuthor, '');
      });
    });

    group('authorsDisplay', () {
      test('should return single author', () {
        final item = ShelfBookItem(
          userBookId: 1,
          externalId: 'id',
          title: 'Title',
          authors: ['Single Author'],
          readingStatus: ReadingStatus.backlog,
          addedAt: now,
        );

        expect(item.authorsDisplay, 'Single Author');
      });

      test('should return comma-separated authors', () {
        final item = ShelfBookItem(
          userBookId: 1,
          externalId: 'id',
          title: 'Title',
          authors: ['Author A', 'Author B', 'Author C'],
          readingStatus: ReadingStatus.backlog,
          addedAt: now,
        );

        expect(item.authorsDisplay, 'Author A, Author B, Author C');
      });

      test('should return empty string when authors is empty', () {
        final item = ShelfBookItem(
          userBookId: 1,
          externalId: 'id',
          title: 'Title',
          authors: [],
          readingStatus: ReadingStatus.backlog,
          addedAt: now,
        );

        expect(item.authorsDisplay, '');
      });
    });

    group('hasRating', () {
      test('should return true when rating is not null', () {
        final item = ShelfBookItem(
          userBookId: 1,
          externalId: 'id',
          title: 'Title',
          authors: ['Author'],
          readingStatus: ReadingStatus.completed,
          addedAt: now,
          rating: 4,
        );

        expect(item.hasRating, isTrue);
      });

      test('should return false when rating is null', () {
        final item = ShelfBookItem(
          userBookId: 1,
          externalId: 'id',
          title: 'Title',
          authors: ['Author'],
          readingStatus: ReadingStatus.backlog,
          addedAt: now,
        );

        expect(item.hasRating, isFalse);
      });
    });

    group('hasCoverImage', () {
      test('should return true when coverImageUrl is not null', () {
        final item = ShelfBookItem(
          userBookId: 1,
          externalId: 'id',
          title: 'Title',
          authors: ['Author'],
          readingStatus: ReadingStatus.backlog,
          addedAt: now,
          coverImageUrl: 'https://example.com/cover.jpg',
        );

        expect(item.hasCoverImage, isTrue);
      });

      test('should return false when coverImageUrl is null', () {
        final item = ShelfBookItem(
          userBookId: 1,
          externalId: 'id',
          title: 'Title',
          authors: ['Author'],
          readingStatus: ReadingStatus.backlog,
          addedAt: now,
        );

        expect(item.hasCoverImage, isFalse);
      });

      test('should return false when coverImageUrl is empty', () {
        final item = ShelfBookItem(
          userBookId: 1,
          externalId: 'id',
          title: 'Title',
          authors: ['Author'],
          readingStatus: ReadingStatus.backlog,
          addedAt: now,
          coverImageUrl: '',
        );

        expect(item.hasCoverImage, isFalse);
      });
    });

    group('copyWith', () {
      test('should create a copy with updated fields', () {
        final original = ShelfBookItem(
          userBookId: 1,
          externalId: 'id',
          title: 'Original Title',
          authors: ['Author'],
          readingStatus: ReadingStatus.backlog,
          addedAt: now,
        );

        final copy = original.copyWith(
          title: 'Updated Title',
          readingStatus: ReadingStatus.reading,
        );

        expect(copy.userBookId, 1);
        expect(copy.title, 'Updated Title');
        expect(copy.readingStatus, ReadingStatus.reading);
        expect(copy.authors, ['Author']);
      });
    });

    group('equality', () {
      test('should be equal when all fields match', () {
        final item1 = ShelfBookItem(
          userBookId: 1,
          externalId: 'id',
          title: 'Title',
          authors: ['Author'],
          readingStatus: ReadingStatus.backlog,
          addedAt: now,
        );
        final item2 = ShelfBookItem(
          userBookId: 1,
          externalId: 'id',
          title: 'Title',
          authors: ['Author'],
          readingStatus: ReadingStatus.backlog,
          addedAt: now,
        );

        expect(item1, equals(item2));
        expect(item1.hashCode, equals(item2.hashCode));
      });

      test('should not be equal when fields differ', () {
        final item1 = ShelfBookItem(
          userBookId: 1,
          externalId: 'id',
          title: 'Title',
          authors: ['Author'],
          readingStatus: ReadingStatus.backlog,
          addedAt: now,
        );
        final item2 = ShelfBookItem(
          userBookId: 2,
          externalId: 'id',
          title: 'Title',
          authors: ['Author'],
          readingStatus: ReadingStatus.backlog,
          addedAt: now,
        );

        expect(item1, isNot(equals(item2)));
      });
    });
  });
}
