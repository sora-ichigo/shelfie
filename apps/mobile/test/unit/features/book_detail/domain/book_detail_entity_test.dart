import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/book_detail/domain/book_detail.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_detail/domain/user_book.dart';

void main() {
  group('BookDetail', () {
    group('creation', () {
      test('should create with all required fields', () {
        const bookDetail = BookDetail(
          id: 'abc123',
          title: 'Flutter in Action',
          authors: ['Eric Windmill'],
        );

        expect(bookDetail.id, equals('abc123'));
        expect(bookDetail.title, equals('Flutter in Action'));
        expect(bookDetail.authors, equals(['Eric Windmill']));
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
          note: 'Great book!',
          noteUpdatedAt: noteUpdatedAt,
        );

        final bookDetail = BookDetail(
          id: 'abc123',
          title: 'Flutter in Action',
          authors: ['Eric Windmill'],
          publisher: 'Manning',
          publishedDate: '2020-01-15',
          pageCount: 368,
          categories: ['Programming', 'Mobile Development'],
          description: 'A book about Flutter development',
          thumbnailUrl: 'https://example.com/cover.jpg',
          amazonUrl: 'https://amazon.com/dp/12345',
          googleBooksUrl: 'https://books.google.com/books?id=abc123',
          userBook: userBook,
        );

        expect(bookDetail.id, equals('abc123'));
        expect(bookDetail.title, equals('Flutter in Action'));
        expect(bookDetail.authors, equals(['Eric Windmill']));
        expect(bookDetail.publisher, equals('Manning'));
        expect(bookDetail.publishedDate, equals('2020-01-15'));
        expect(bookDetail.pageCount, equals(368));
        expect(bookDetail.categories, equals(['Programming', 'Mobile Development']));
        expect(bookDetail.description, equals('A book about Flutter development'));
        expect(bookDetail.thumbnailUrl, equals('https://example.com/cover.jpg'));
        expect(bookDetail.amazonUrl, equals('https://amazon.com/dp/12345'));
        expect(bookDetail.googleBooksUrl, equals('https://books.google.com/books?id=abc123'));
        expect(bookDetail.userBook, equals(userBook));
      });

      test('should have null optional fields by default', () {
        const bookDetail = BookDetail(
          id: 'abc123',
          title: 'Test Book',
          authors: ['Author'],
        );

        expect(bookDetail.publisher, isNull);
        expect(bookDetail.publishedDate, isNull);
        expect(bookDetail.pageCount, isNull);
        expect(bookDetail.categories, isNull);
        expect(bookDetail.description, isNull);
        expect(bookDetail.thumbnailUrl, isNull);
        expect(bookDetail.amazonUrl, isNull);
        expect(bookDetail.googleBooksUrl, isNull);
        expect(bookDetail.userBook, isNull);
      });

      test('should allow empty authors list', () {
        const bookDetail = BookDetail(
          id: 'abc123',
          title: 'Anonymous Book',
          authors: [],
        );

        expect(bookDetail.authors, isEmpty);
      });

      test('should allow multiple authors', () {
        const bookDetail = BookDetail(
          id: 'abc123',
          title: 'Collaborative Work',
          authors: ['Author 1', 'Author 2', 'Author 3'],
        );

        expect(bookDetail.authors, hasLength(3));
        expect(bookDetail.authors, containsAll(['Author 1', 'Author 2', 'Author 3']));
      });
    });

    group('equality', () {
      test('should be equal when same values', () {
        const bookDetail1 = BookDetail(
          id: 'abc123',
          title: 'Flutter Book',
          authors: ['Author'],
          publisher: 'Publisher',
        );

        const bookDetail2 = BookDetail(
          id: 'abc123',
          title: 'Flutter Book',
          authors: ['Author'],
          publisher: 'Publisher',
        );

        expect(bookDetail1, equals(bookDetail2));
        expect(bookDetail1.hashCode, equals(bookDetail2.hashCode));
      });

      test('should not be equal when different values', () {
        const bookDetail1 = BookDetail(
          id: 'abc123',
          title: 'Flutter Book',
          authors: ['Author'],
        );

        const bookDetail2 = BookDetail(
          id: 'abc456',
          title: 'Flutter Book',
          authors: ['Author'],
        );

        expect(bookDetail1, isNot(equals(bookDetail2)));
      });
    });

    group('copyWith', () {
      test('should copy with new values', () {
        const original = BookDetail(
          id: 'abc123',
          title: 'Original Title',
          authors: ['Author'],
        );

        final copied = original.copyWith(
          title: 'New Title',
          publisher: 'New Publisher',
        );

        expect(copied.id, equals('abc123'));
        expect(copied.title, equals('New Title'));
        expect(copied.authors, equals(['Author']));
        expect(copied.publisher, equals('New Publisher'));
      });

      test('should copy with userBook', () {
        const original = BookDetail(
          id: 'abc123',
          title: 'Test Book',
          authors: ['Author'],
        );

        final userBook = UserBook(
          id: 1,
          readingStatus: ReadingStatus.reading,
          addedAt: DateTime(2024, 1, 15),
        );

        final copied = original.copyWith(userBook: userBook);

        expect(copied.userBook, equals(userBook));
      });
    });

    group('isInShelf', () {
      test('should return true when userBook is present', () {
        final bookDetail = BookDetail(
          id: 'abc123',
          title: 'Test Book',
          authors: ['Author'],
          userBook: UserBook(
            id: 1,
            readingStatus: ReadingStatus.backlog,
            addedAt: DateTime(2024, 1, 15),
          ),
        );

        expect(bookDetail.isInShelf, isTrue);
      });

      test('should return false when userBook is null', () {
        const bookDetail = BookDetail(
          id: 'abc123',
          title: 'Test Book',
          authors: ['Author'],
        );

        expect(bookDetail.isInShelf, isFalse);
      });
    });
  });
}
