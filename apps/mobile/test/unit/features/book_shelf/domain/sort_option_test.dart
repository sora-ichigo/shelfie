import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';

void main() {
  group('SortOption', () {
    group('values', () {
      test('should have 4 options', () {
        expect(SortOption.values.length, 4);
      });

      test('should have addedAtDesc as first option (default)', () {
        expect(SortOption.values.first, SortOption.addedAtDesc);
      });

      test('should include all expected options', () {
        expect(SortOption.values, contains(SortOption.addedAtDesc));
        expect(SortOption.values, contains(SortOption.addedAtAsc));
        expect(SortOption.values, contains(SortOption.titleAsc));
        expect(SortOption.values, contains(SortOption.authorAsc));
      });
    });

    group('displayName', () {
      test('addedAtDesc should return correct Japanese label', () {
        expect(SortOption.addedAtDesc.displayName, '追加日（新しい順）');
      });

      test('addedAtAsc should return correct Japanese label', () {
        expect(SortOption.addedAtAsc.displayName, '追加日（古い順）');
      });

      test('titleAsc should return correct Japanese label', () {
        expect(SortOption.titleAsc.displayName, 'タイトル（A→Z）');
      });

      test('authorAsc should return correct Japanese label', () {
        expect(SortOption.authorAsc.displayName, '著者名（A→Z）');
      });
    });

    group('API conversion', () {
      test('addedAtDesc should return ADDED_AT and DESC', () {
        expect(SortOption.addedAtDesc.sortField, 'ADDED_AT');
        expect(SortOption.addedAtDesc.sortOrder, 'DESC');
      });

      test('addedAtAsc should return ADDED_AT and ASC', () {
        expect(SortOption.addedAtAsc.sortField, 'ADDED_AT');
        expect(SortOption.addedAtAsc.sortOrder, 'ASC');
      });

      test('titleAsc should return TITLE and ASC', () {
        expect(SortOption.titleAsc.sortField, 'TITLE');
        expect(SortOption.titleAsc.sortOrder, 'ASC');
      });

      test('authorAsc should return AUTHOR and ASC', () {
        expect(SortOption.authorAsc.sortField, 'AUTHOR');
        expect(SortOption.authorAsc.sortOrder, 'ASC');
      });
    });

    group('default', () {
      test('defaultOption should be addedAtDesc', () {
        expect(SortOption.defaultOption, SortOption.addedAtDesc);
      });
    });
  });
}
