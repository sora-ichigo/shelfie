import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/book_search/domain/recent_book_entry.dart';

void main() {
  group('RecentBookEntry', () {
    final now = DateTime(2026, 1, 24, 12, 0, 0);

    test('should create with required fields only', () {
      final entry = RecentBookEntry(
        bookId: 'book-123',
        title: 'Flutter in Action',
        authors: ['Eric Windmill'],
        viewedAt: now,
      );

      expect(entry.bookId, 'book-123');
      expect(entry.title, 'Flutter in Action');
      expect(entry.authors, ['Eric Windmill']);
      expect(entry.coverImageUrl, isNull);
      expect(entry.viewedAt, now);
    });

    test('should create with all fields including coverImageUrl', () {
      final entry = RecentBookEntry(
        bookId: 'book-456',
        title: 'Dart Programming',
        authors: ['Author 1', 'Author 2'],
        coverImageUrl: 'https://example.com/cover.jpg',
        viewedAt: now,
      );

      expect(entry.bookId, 'book-456');
      expect(entry.title, 'Dart Programming');
      expect(entry.authors, ['Author 1', 'Author 2']);
      expect(entry.coverImageUrl, 'https://example.com/cover.jpg');
      expect(entry.viewedAt, now);
    });

    test('should support empty authors list', () {
      final entry = RecentBookEntry(
        bookId: 'book-789',
        title: 'Unknown Author Book',
        authors: [],
        viewedAt: now,
      );

      expect(entry.authors, isEmpty);
    });

    test('copyWith creates a new instance with updated values', () {
      final entry = RecentBookEntry(
        bookId: 'book-123',
        title: 'Flutter in Action',
        authors: ['Eric Windmill'],
        viewedAt: now,
      );

      final newTime = DateTime(2026, 1, 25, 12, 0, 0);
      final updated = entry.copyWith(
        title: 'Flutter in Action 2nd Edition',
        coverImageUrl: 'https://example.com/cover2.jpg',
        viewedAt: newTime,
      );

      expect(updated.bookId, 'book-123');
      expect(updated.title, 'Flutter in Action 2nd Edition');
      expect(updated.authors, ['Eric Windmill']);
      expect(updated.coverImageUrl, 'https://example.com/cover2.jpg');
      expect(updated.viewedAt, newTime);
    });

    test('copyWith preserves original values when not specified', () {
      final entry = RecentBookEntry(
        bookId: 'book-123',
        title: 'Flutter in Action',
        authors: ['Eric Windmill'],
        coverImageUrl: 'https://example.com/cover.jpg',
        viewedAt: now,
      );

      final updated = entry.copyWith(title: 'New Title');

      expect(updated.bookId, 'book-123');
      expect(updated.title, 'New Title');
      expect(updated.authors, ['Eric Windmill']);
      expect(updated.coverImageUrl, 'https://example.com/cover.jpg');
      expect(updated.viewedAt, now);
    });

    test('equality compares all fields', () {
      final entry1 = RecentBookEntry(
        bookId: 'book-123',
        title: 'Flutter in Action',
        authors: ['Eric Windmill'],
        coverImageUrl: 'https://example.com/cover.jpg',
        viewedAt: now,
      );

      final entry2 = RecentBookEntry(
        bookId: 'book-123',
        title: 'Flutter in Action',
        authors: ['Eric Windmill'],
        coverImageUrl: 'https://example.com/cover.jpg',
        viewedAt: now,
      );

      expect(entry1, equals(entry2));
    });

    test('inequality when bookId differs', () {
      final entry1 = RecentBookEntry(
        bookId: 'book-123',
        title: 'Flutter in Action',
        authors: ['Eric Windmill'],
        viewedAt: now,
      );

      final entry2 = RecentBookEntry(
        bookId: 'book-456',
        title: 'Flutter in Action',
        authors: ['Eric Windmill'],
        viewedAt: now,
      );

      expect(entry1, isNot(equals(entry2)));
    });

    test('inequality when title differs', () {
      final entry1 = RecentBookEntry(
        bookId: 'book-123',
        title: 'Flutter in Action',
        authors: ['Eric Windmill'],
        viewedAt: now,
      );

      final entry2 = RecentBookEntry(
        bookId: 'book-123',
        title: 'Dart in Action',
        authors: ['Eric Windmill'],
        viewedAt: now,
      );

      expect(entry1, isNot(equals(entry2)));
    });

    test('inequality when authors differ', () {
      final entry1 = RecentBookEntry(
        bookId: 'book-123',
        title: 'Flutter in Action',
        authors: ['Author 1'],
        viewedAt: now,
      );

      final entry2 = RecentBookEntry(
        bookId: 'book-123',
        title: 'Flutter in Action',
        authors: ['Author 2'],
        viewedAt: now,
      );

      expect(entry1, isNot(equals(entry2)));
    });

    test('inequality when coverImageUrl differs', () {
      final entry1 = RecentBookEntry(
        bookId: 'book-123',
        title: 'Flutter in Action',
        authors: ['Eric Windmill'],
        coverImageUrl: 'https://example.com/cover1.jpg',
        viewedAt: now,
      );

      final entry2 = RecentBookEntry(
        bookId: 'book-123',
        title: 'Flutter in Action',
        authors: ['Eric Windmill'],
        coverImageUrl: 'https://example.com/cover2.jpg',
        viewedAt: now,
      );

      expect(entry1, isNot(equals(entry2)));
    });

    test('inequality when viewedAt differs', () {
      final entry1 = RecentBookEntry(
        bookId: 'book-123',
        title: 'Flutter in Action',
        authors: ['Eric Windmill'],
        viewedAt: now,
      );

      final entry2 = RecentBookEntry(
        bookId: 'book-123',
        title: 'Flutter in Action',
        authors: ['Eric Windmill'],
        viewedAt: DateTime(2026, 1, 25, 12, 0, 0),
      );

      expect(entry1, isNot(equals(entry2)));
    });

    group('JSON serialization', () {
      test('toJson converts to JSON map with all fields', () {
        final entry = RecentBookEntry(
          bookId: 'book-123',
          title: 'Flutter in Action',
          authors: ['Eric Windmill', 'Other Author'],
          coverImageUrl: 'https://example.com/cover.jpg',
          viewedAt: now,
        );

        final json = entry.toJson();

        expect(json['bookId'], 'book-123');
        expect(json['title'], 'Flutter in Action');
        expect(json['authors'], ['Eric Windmill', 'Other Author']);
        expect(json['coverImageUrl'], 'https://example.com/cover.jpg');
        expect(json['viewedAt'], now.toIso8601String());
      });

      test('toJson converts to JSON map with nullable coverImageUrl', () {
        final entry = RecentBookEntry(
          bookId: 'book-123',
          title: 'Flutter in Action',
          authors: ['Eric Windmill'],
          viewedAt: now,
        );

        final json = entry.toJson();

        expect(json['bookId'], 'book-123');
        expect(json['coverImageUrl'], isNull);
      });

      test('fromJson creates instance from JSON map with all fields', () {
        final json = {
          'bookId': 'book-123',
          'title': 'Flutter in Action',
          'authors': ['Eric Windmill', 'Other Author'],
          'coverImageUrl': 'https://example.com/cover.jpg',
          'viewedAt': now.toIso8601String(),
        };

        final entry = RecentBookEntry.fromJson(json);

        expect(entry.bookId, 'book-123');
        expect(entry.title, 'Flutter in Action');
        expect(entry.authors, ['Eric Windmill', 'Other Author']);
        expect(entry.coverImageUrl, 'https://example.com/cover.jpg');
        expect(entry.viewedAt, now);
      });

      test('fromJson creates instance from JSON map with null coverImageUrl',
          () {
        final json = {
          'bookId': 'book-123',
          'title': 'Flutter in Action',
          'authors': ['Eric Windmill'],
          'coverImageUrl': null,
          'viewedAt': now.toIso8601String(),
        };

        final entry = RecentBookEntry.fromJson(json);

        expect(entry.bookId, 'book-123');
        expect(entry.coverImageUrl, isNull);
      });

      test('fromJson creates instance from JSON map without coverImageUrl key',
          () {
        final json = {
          'bookId': 'book-123',
          'title': 'Flutter in Action',
          'authors': ['Eric Windmill'],
          'viewedAt': now.toIso8601String(),
        };

        final entry = RecentBookEntry.fromJson(json);

        expect(entry.bookId, 'book-123');
        expect(entry.coverImageUrl, isNull);
      });

      test('round-trip serialization preserves data with all fields', () {
        final original = RecentBookEntry(
          bookId: 'book-123',
          title: 'Flutter Programming Guide',
          authors: ['Author 1', 'Author 2'],
          coverImageUrl: 'https://example.com/cover.jpg',
          viewedAt: now,
        );

        final json = original.toJson();
        final restored = RecentBookEntry.fromJson(json);

        expect(restored, equals(original));
      });

      test('round-trip serialization preserves data with null coverImageUrl',
          () {
        final original = RecentBookEntry(
          bookId: 'book-123',
          title: 'Flutter Programming Guide',
          authors: ['Author 1'],
          viewedAt: now,
        );

        final json = original.toJson();
        final restored = RecentBookEntry.fromJson(json);

        expect(restored, equals(original));
      });

      test('round-trip serialization preserves data with empty authors list',
          () {
        final original = RecentBookEntry(
          bookId: 'book-123',
          title: 'Unknown Author Book',
          authors: [],
          viewedAt: now,
        );

        final json = original.toJson();
        final restored = RecentBookEntry.fromJson(json);

        expect(restored, equals(original));
      });
    });

    test('toString includes all fields', () {
      final entry = RecentBookEntry(
        bookId: 'book-123',
        title: 'Flutter in Action',
        authors: ['Eric Windmill'],
        coverImageUrl: 'https://example.com/cover.jpg',
        viewedAt: now,
      );

      final string = entry.toString();

      expect(string, contains('RecentBookEntry'));
      expect(string, contains('book-123'));
      expect(string, contains('Flutter in Action'));
    });

    test('hashCode is consistent for equal objects', () {
      final entry1 = RecentBookEntry(
        bookId: 'book-123',
        title: 'Flutter in Action',
        authors: ['Eric Windmill'],
        coverImageUrl: 'https://example.com/cover.jpg',
        viewedAt: now,
      );

      final entry2 = RecentBookEntry(
        bookId: 'book-123',
        title: 'Flutter in Action',
        authors: ['Eric Windmill'],
        coverImageUrl: 'https://example.com/cover.jpg',
        viewedAt: now,
      );

      expect(entry1.hashCode, equals(entry2.hashCode));
    });
  });
}
