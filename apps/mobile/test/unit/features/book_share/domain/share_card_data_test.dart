import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/book_share/domain/share_card_data.dart';

void main() {
  group('ShareCardData', () {
    group('creation', () {
      test('should create with required fields only', () {
        const data = ShareCardData(
          title: 'Flutter in Action',
          authors: ['Eric Windmill'],
        );

        expect(data.title, 'Flutter in Action');
        expect(data.authors, ['Eric Windmill']);
        expect(data.thumbnailUrl, isNull);
        expect(data.userName, isNull);
        expect(data.avatarUrl, isNull);
        expect(data.rating, isNull);
        expect(data.completedAt, isNull);
        expect(data.note, isNull);
      });

      test('should create with all fields', () {
        final completedAt = DateTime(2026, 1, 15);
        final data = ShareCardData(
          title: 'Flutter in Action',
          authors: ['Eric Windmill'],
          thumbnailUrl: 'https://example.com/cover.jpg',
          userName: 'testuser',
          avatarUrl: 'https://example.com/avatar.jpg',
          rating: 5,
          completedAt: completedAt,
          note: 'Great book!',
        );

        expect(data.title, 'Flutter in Action');
        expect(data.authors, ['Eric Windmill']);
        expect(data.thumbnailUrl, 'https://example.com/cover.jpg');
        expect(data.userName, 'testuser');
        expect(data.avatarUrl, 'https://example.com/avatar.jpg');
        expect(data.rating, 5);
        expect(data.completedAt, completedAt);
        expect(data.note, 'Great book!');
      });

      test('should allow empty authors list', () {
        const data = ShareCardData(
          title: 'Anonymous Book',
          authors: [],
        );

        expect(data.authors, isEmpty);
      });

      test('should allow multiple authors', () {
        const data = ShareCardData(
          title: 'Collaborative Work',
          authors: ['Author 1', 'Author 2'],
        );

        expect(data.authors, hasLength(2));
      });
    });

    group('equality', () {
      test('should be equal when same values', () {
        const data1 = ShareCardData(
          title: 'Book',
          authors: ['Author'],
          rating: 4,
        );
        const data2 = ShareCardData(
          title: 'Book',
          authors: ['Author'],
          rating: 4,
        );

        expect(data1, equals(data2));
      });

      test('should not be equal when different values', () {
        const data1 = ShareCardData(
          title: 'Book A',
          authors: ['Author'],
        );
        const data2 = ShareCardData(
          title: 'Book B',
          authors: ['Author'],
        );

        expect(data1, isNot(equals(data2)));
      });
    });

    group('copyWith', () {
      test('should copy with new rating', () {
        const original = ShareCardData(
          title: 'Book',
          authors: ['Author'],
        );

        final copied = original.copyWith(rating: 5);

        expect(copied.title, 'Book');
        expect(copied.authors, ['Author']);
        expect(copied.rating, 5);
      });

      test('should copy with new note', () {
        const original = ShareCardData(
          title: 'Book',
          authors: ['Author'],
        );

        final copied = original.copyWith(note: 'A note');

        expect(copied.note, 'A note');
      });
    });
  });
}
