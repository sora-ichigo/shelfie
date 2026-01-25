import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shelfie/features/book_search/data/search_history_repository.dart';
import 'package:shelfie/features/book_search/domain/search_history_entry.dart';

void main() {
  group('SearchHistoryRepository', () {
    late Box<Map<dynamic, dynamic>> box;
    late SearchHistoryRepository repository;

    setUp(() async {
      Hive.init('test_hive');
      box = await Hive.openBox<Map<dynamic, dynamic>>('test_search_history');
      await box.clear();
      repository = SearchHistoryRepository(box);
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

      test('returns all history entries sorted by searchedAt descending',
          () async {
        final now = DateTime.now();
        final entry1 = SearchHistoryEntry(
          query: 'flutter',
          searchedAt: now.subtract(const Duration(hours: 2)),
        );
        final entry2 = SearchHistoryEntry(
          query: 'dart',
          searchedAt: now.subtract(const Duration(hours: 1)),
        );
        final entry3 = SearchHistoryEntry(
          query: 'riverpod',
          searchedAt: now,
        );

        await repository.add(entry1);
        await repository.add(entry2);
        await repository.add(entry3);

        final result = await repository.getAll();

        expect(result.length, 3);
        expect(result[0].query, 'riverpod');
        expect(result[1].query, 'dart');
        expect(result[2].query, 'flutter');
      });
    });

    group('add', () {
      test('adds a new entry to history', () async {
        final entry = SearchHistoryEntry(
          query: 'flutter',
          searchedAt: DateTime.now(),
        );

        await repository.add(entry);

        final result = await repository.getAll();
        expect(result.length, 1);
        expect(result.first.query, 'flutter');
      });

      test('updates existing entry with same query', () async {
        final now = DateTime.now();
        final entry1 = SearchHistoryEntry(
          query: 'flutter',
          searchedAt: now.subtract(const Duration(hours: 1)),
        );
        final entry2 = SearchHistoryEntry(
          query: 'flutter',
          searchedAt: now,
        );

        await repository.add(entry1);
        await repository.add(entry2);

        final result = await repository.getAll();
        expect(result.length, 1);
        expect(result.first.searchedAt, now);
      });

      test('enforces maximum 20 entries limit', () async {
        final now = DateTime.now();

        for (var i = 0; i < 25; i++) {
          final entry = SearchHistoryEntry(
            query: 'query_$i',
            searchedAt: now.add(Duration(minutes: i)),
          );
          await repository.add(entry);
        }

        final result = await repository.getAll();
        expect(result.length, 20);
        expect(result.first.query, 'query_24');
        expect(result.last.query, 'query_5');
      });

      test('removes oldest entry when limit is exceeded', () async {
        final now = DateTime.now();

        for (var i = 0; i < 20; i++) {
          final entry = SearchHistoryEntry(
            query: 'query_$i',
            searchedAt: now.add(Duration(minutes: i)),
          );
          await repository.add(entry);
        }

        final newEntry = SearchHistoryEntry(
          query: 'new_query',
          searchedAt: now.add(const Duration(minutes: 21)),
        );
        await repository.add(newEntry);

        final result = await repository.getAll();
        expect(result.length, 20);
        expect(result.any((e) => e.query == 'query_0'), isFalse);
        expect(result.any((e) => e.query == 'new_query'), isTrue);
      });
    });

    group('remove', () {
      test('removes entry with matching query', () async {
        final entry1 = SearchHistoryEntry(
          query: 'flutter',
          searchedAt: DateTime.now(),
        );
        final entry2 = SearchHistoryEntry(
          query: 'dart',
          searchedAt: DateTime.now(),
        );

        await repository.add(entry1);
        await repository.add(entry2);

        await repository.remove('flutter');

        final result = await repository.getAll();
        expect(result.length, 1);
        expect(result.first.query, 'dart');
      });

      test('does nothing when query not found', () async {
        final entry = SearchHistoryEntry(
          query: 'flutter',
          searchedAt: DateTime.now(),
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
          final entry = SearchHistoryEntry(
            query: 'query_$i',
            searchedAt: now.add(Duration(minutes: i)),
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
