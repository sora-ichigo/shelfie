import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_settings_repository.dart';

import 'package:shelfie/features/book_shelf/domain/sort_option.dart';

void main() {
  group('BookShelfSettingsRepository', () {
    late Box<String> box;
    late BookShelfSettingsRepository repository;

    setUp(() async {
      Hive.init('test_hive');
      box = await Hive.openBox<String>('test_book_shelf_settings');
      await box.clear();
      repository = BookShelfSettingsRepository(box);
    });

    tearDown(() async {
      await box.clear();
      await box.close();
      await Hive.deleteFromDisk();
    });

    group('getSortOption', () {
      test('returns default option when not set', () {
        final result = repository.getSortOption();

        expect(result, SortOption.defaultOption);
      });

      test('returns saved sort option', () async {
        await repository.setSortOption(SortOption.titleAsc);

        final result = repository.getSortOption();

        expect(result, SortOption.titleAsc);
      });

      test('returns each saved sort option correctly', () async {
        for (final option in SortOption.values) {
          await repository.setSortOption(option);

          final result = repository.getSortOption();

          expect(result, option);
        }
      });

      test('returns default option when stored value is invalid', () async {
        await box.put('sort_option', 'invalid_value');

        final result = repository.getSortOption();

        expect(result, SortOption.defaultOption);
      });
    });

    group('setSortOption', () {
      test('persists sort option', () async {
        await repository.setSortOption(SortOption.authorAsc);

        final storedValue = box.get('sort_option');
        expect(storedValue, 'authorAsc');
      });

      test('overwrites previous sort option', () async {
        await repository.setSortOption(SortOption.addedAtAsc);
        await repository.setSortOption(SortOption.titleAsc);

        final result = repository.getSortOption();
        expect(result, SortOption.titleAsc);
      });
    });

    group('persistence across instances', () {
      test('settings persist when repository is recreated', () async {
        await repository.setSortOption(SortOption.titleAsc);

        final newRepository = BookShelfSettingsRepository(box);

        expect(newRepository.getSortOption(), SortOption.titleAsc);
      });
    });
  });
}
