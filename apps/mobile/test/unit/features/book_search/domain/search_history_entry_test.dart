import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/book_search/domain/search_history_entry.dart';

void main() {
  group('SearchHistoryEntry', () {
    final now = DateTime(2026, 1, 24, 12, 0, 0);

    test('should create with required fields', () {
      final entry = SearchHistoryEntry(
        query: 'flutter',
        searchedAt: now,
      );

      expect(entry.query, 'flutter');
      expect(entry.searchedAt, now);
    });

    test('copyWith creates a new instance with updated values', () {
      final entry = SearchHistoryEntry(
        query: 'flutter',
        searchedAt: now,
      );

      final newTime = DateTime(2026, 1, 25, 12, 0, 0);
      final updated = entry.copyWith(
        query: 'dart',
        searchedAt: newTime,
      );

      expect(updated.query, 'dart');
      expect(updated.searchedAt, newTime);
    });

    test('copyWith preserves original values when not specified', () {
      final entry = SearchHistoryEntry(
        query: 'flutter',
        searchedAt: now,
      );

      final updated = entry.copyWith(query: 'dart');

      expect(updated.query, 'dart');
      expect(updated.searchedAt, now);
    });

    test('equality compares all fields', () {
      final entry1 = SearchHistoryEntry(
        query: 'flutter',
        searchedAt: now,
      );

      final entry2 = SearchHistoryEntry(
        query: 'flutter',
        searchedAt: now,
      );

      expect(entry1, equals(entry2));
    });

    test('inequality when query differs', () {
      final entry1 = SearchHistoryEntry(
        query: 'flutter',
        searchedAt: now,
      );

      final entry2 = SearchHistoryEntry(
        query: 'dart',
        searchedAt: now,
      );

      expect(entry1, isNot(equals(entry2)));
    });

    test('inequality when searchedAt differs', () {
      final entry1 = SearchHistoryEntry(
        query: 'flutter',
        searchedAt: now,
      );

      final entry2 = SearchHistoryEntry(
        query: 'flutter',
        searchedAt: DateTime(2026, 1, 25, 12, 0, 0),
      );

      expect(entry1, isNot(equals(entry2)));
    });

    group('JSON serialization', () {
      test('toJson converts to JSON map', () {
        final entry = SearchHistoryEntry(
          query: 'flutter',
          searchedAt: now,
        );

        final json = entry.toJson();

        expect(json['query'], 'flutter');
        expect(json['searchedAt'], now.toIso8601String());
      });

      test('fromJson creates instance from JSON map', () {
        final json = {
          'query': 'flutter',
          'searchedAt': now.toIso8601String(),
        };

        final entry = SearchHistoryEntry.fromJson(json);

        expect(entry.query, 'flutter');
        expect(entry.searchedAt, now);
      });

      test('round-trip serialization preserves data', () {
        final original = SearchHistoryEntry(
          query: 'flutter programming',
          searchedAt: now,
        );

        final json = original.toJson();
        final restored = SearchHistoryEntry.fromJson(json);

        expect(restored, equals(original));
      });
    });

    test('toString includes all fields', () {
      final entry = SearchHistoryEntry(
        query: 'flutter',
        searchedAt: now,
      );

      final string = entry.toString();

      expect(string, contains('SearchHistoryEntry'));
      expect(string, contains('flutter'));
    });

    test('hashCode is consistent for equal objects', () {
      final entry1 = SearchHistoryEntry(
        query: 'flutter',
        searchedAt: now,
      );

      final entry2 = SearchHistoryEntry(
        query: 'flutter',
        searchedAt: now,
      );

      expect(entry1.hashCode, equals(entry2.hashCode));
    });
  });
}
