import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shelfie/features/book_search/data/recent_books_repository.dart';
import 'package:shelfie/features/book_search/domain/recent_book_entry.dart';

void main() {
  group('RecentBooksRepository', () {
    late Box<Map<dynamic, dynamic>> box;
    late RecentBooksRepository repository;

    setUp(() async {
      Hive.init('test_hive');
      box = await Hive.openBox<Map<dynamic, dynamic>>('test_recent_books');
      await box.clear();
      repository = RecentBooksRepository(box);
    });

    tearDown(() async {
      await box.clear();
      await box.close();
      await Hive.deleteFromDisk();
    });

    group('getAll', () {
      test('returns empty list when no history exists', () async {
        final result = await repository.getAll();

        expect(result, isEmpty);
      });

      test('returns all entries sorted by viewedAt descending', () async {
        final now = DateTime.now();
        final entry1 = RecentBookEntry(
          bookId: 'book1',
          title: 'Flutter Guide',
          authors: ['Author 1'],
          viewedAt: now.subtract(const Duration(hours: 2)),
        );
        final entry2 = RecentBookEntry(
          bookId: 'book2',
          title: 'Dart Basics',
          authors: ['Author 2'],
          viewedAt: now.subtract(const Duration(hours: 1)),
        );
        final entry3 = RecentBookEntry(
          bookId: 'book3',
          title: 'Riverpod Deep Dive',
          authors: ['Author 3'],
          viewedAt: now,
        );

        await repository.add(entry1);
        await repository.add(entry2);
        await repository.add(entry3);

        final result = await repository.getAll();

        expect(result.length, 3);
        expect(result[0].bookId, 'book3');
        expect(result[1].bookId, 'book2');
        expect(result[2].bookId, 'book1');
      });
    });

    group('add', () {
      test('adds a new entry to history', () async {
        final entry = RecentBookEntry(
          bookId: 'book1',
          title: 'Flutter Guide',
          authors: ['Author 1'],
          coverImageUrl: 'https://example.com/cover.jpg',
          viewedAt: DateTime.now(),
        );

        await repository.add(entry);

        final result = await repository.getAll();
        expect(result.length, 1);
        expect(result.first.bookId, 'book1');
        expect(result.first.title, 'Flutter Guide');
        expect(result.first.coverImageUrl, 'https://example.com/cover.jpg');
      });

      test('updates existing entry with same bookId', () async {
        final now = DateTime.now();
        final entry1 = RecentBookEntry(
          bookId: 'book1',
          title: 'Flutter Guide v1',
          authors: ['Author 1'],
          viewedAt: now.subtract(const Duration(hours: 1)),
        );
        final entry2 = RecentBookEntry(
          bookId: 'book1',
          title: 'Flutter Guide v2',
          authors: ['Author 1', 'Author 2'],
          viewedAt: now,
        );

        await repository.add(entry1);
        await repository.add(entry2);

        final result = await repository.getAll();
        expect(result.length, 1);
        expect(result.first.title, 'Flutter Guide v2');
        expect(result.first.viewedAt, now);
      });

      test('enforces maximum 10 entries limit', () async {
        final now = DateTime.now();

        for (var i = 0; i < 15; i++) {
          final entry = RecentBookEntry(
            bookId: 'book_$i',
            title: 'Book $i',
            authors: ['Author $i'],
            viewedAt: now.add(Duration(minutes: i)),
          );
          await repository.add(entry);
        }

        final result = await repository.getAll();
        expect(result.length, 10);
        expect(result.first.bookId, 'book_14');
        expect(result.last.bookId, 'book_5');
      });

      test('removes oldest entry when limit is exceeded', () async {
        final now = DateTime.now();

        for (var i = 0; i < 10; i++) {
          final entry = RecentBookEntry(
            bookId: 'book_$i',
            title: 'Book $i',
            authors: ['Author $i'],
            viewedAt: now.add(Duration(minutes: i)),
          );
          await repository.add(entry);
        }

        final newEntry = RecentBookEntry(
          bookId: 'new_book',
          title: 'New Book',
          authors: ['New Author'],
          viewedAt: now.add(const Duration(minutes: 11)),
        );
        await repository.add(newEntry);

        final result = await repository.getAll();
        expect(result.length, 10);
        expect(result.any((e) => e.bookId == 'book_0'), isFalse);
        expect(result.any((e) => e.bookId == 'new_book'), isTrue);
      });

      test('handles null coverImageUrl', () async {
        final entry = RecentBookEntry(
          bookId: 'book1',
          title: 'Flutter Guide',
          authors: ['Author 1'],
          viewedAt: DateTime.now(),
        );

        await repository.add(entry);

        final result = await repository.getAll();
        expect(result.first.coverImageUrl, isNull);
      });

      test('handles empty authors list', () async {
        final entry = RecentBookEntry(
          bookId: 'book1',
          title: 'Flutter Guide',
          authors: [],
          viewedAt: DateTime.now(),
        );

        await repository.add(entry);

        final result = await repository.getAll();
        expect(result.first.authors, isEmpty);
      });
    });

    group('remove', () {
      test('removes entry with matching bookId', () async {
        final entry1 = RecentBookEntry(
          bookId: 'book1',
          title: 'Flutter Guide',
          authors: ['Author 1'],
          viewedAt: DateTime.now(),
        );
        final entry2 = RecentBookEntry(
          bookId: 'book2',
          title: 'Dart Basics',
          authors: ['Author 2'],
          viewedAt: DateTime.now(),
        );

        await repository.add(entry1);
        await repository.add(entry2);

        await repository.remove('book1');

        final result = await repository.getAll();
        expect(result.length, 1);
        expect(result.first.bookId, 'book2');
      });

      test('does nothing when bookId not found', () async {
        final entry = RecentBookEntry(
          bookId: 'book1',
          title: 'Flutter Guide',
          authors: ['Author 1'],
          viewedAt: DateTime.now(),
        );

        await repository.add(entry);
        await repository.remove('nonexistent');

        final result = await repository.getAll();
        expect(result.length, 1);
      });
    });

    group('clear', () {
      test('removes all entries', () async {
        final now = DateTime.now();
        for (var i = 0; i < 5; i++) {
          final entry = RecentBookEntry(
            bookId: 'book_$i',
            title: 'Book $i',
            authors: ['Author $i'],
            viewedAt: now.add(Duration(minutes: i)),
          );
          await repository.add(entry);
        }

        await repository.clear();

        final result = await repository.getAll();
        expect(result, isEmpty);
      });
    });
  });
}
