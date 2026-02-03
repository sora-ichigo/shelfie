import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';

void main() {
  group('SortOption', () {
    group('values', () {
      test('should have 8 options', () {
        expect(SortOption.values.length, 8);
      });

      test('should have addedAtDesc as first option (default)', () {
        expect(SortOption.values.first, SortOption.addedAtDesc);
      });

      test('should include all expected options', () {
        expect(SortOption.values, contains(SortOption.addedAtDesc));
        expect(SortOption.values, contains(SortOption.addedAtAsc));
        expect(SortOption.values, contains(SortOption.titleAsc));
        expect(SortOption.values, contains(SortOption.authorAsc));
        expect(SortOption.values, contains(SortOption.completedAtDesc));
        expect(SortOption.values, contains(SortOption.completedAtAsc));
        expect(SortOption.values, contains(SortOption.publishedDateDesc));
        expect(SortOption.values, contains(SortOption.publishedDateAsc));
      });
    });

    group('displayName', () {
      test('addedAtDesc should return correct Japanese label', () {
        expect(SortOption.addedAtDesc.displayName, '追加日（新しい）');
      });

      test('addedAtAsc should return correct Japanese label', () {
        expect(SortOption.addedAtAsc.displayName, '追加日（古い）');
      });

      test('titleAsc should return correct Japanese label', () {
        expect(SortOption.titleAsc.displayName, 'タイトル（A→Z）');
      });

      test('authorAsc should return correct Japanese label', () {
        expect(SortOption.authorAsc.displayName, '著者名（A→Z）');
      });

      test('completedAtDesc should return correct Japanese label', () {
        expect(SortOption.completedAtDesc.displayName, '読了日（新しい）');
      });

      test('completedAtAsc should return correct Japanese label', () {
        expect(SortOption.completedAtAsc.displayName, '読了日（古い）');
      });

      test('publishedDateDesc should return correct Japanese label', () {
        expect(SortOption.publishedDateDesc.displayName, '発売日（新しい）');
      });

      test('publishedDateAsc should return correct Japanese label', () {
        expect(SortOption.publishedDateAsc.displayName, '発売日（古い）');
      });
    });

    group('API conversion', () {
      test('addedAtDesc should return ADDED_AT and DESC', () {
        expect(SortOption.addedAtDesc.sortField, GShelfSortField.ADDED_AT);
        expect(SortOption.addedAtDesc.sortOrder, GSortOrder.DESC);
      });

      test('addedAtAsc should return ADDED_AT and ASC', () {
        expect(SortOption.addedAtAsc.sortField, GShelfSortField.ADDED_AT);
        expect(SortOption.addedAtAsc.sortOrder, GSortOrder.ASC);
      });

      test('titleAsc should return TITLE and ASC', () {
        expect(SortOption.titleAsc.sortField, GShelfSortField.TITLE);
        expect(SortOption.titleAsc.sortOrder, GSortOrder.ASC);
      });

      test('authorAsc should return AUTHOR and ASC', () {
        expect(SortOption.authorAsc.sortField, GShelfSortField.AUTHOR);
        expect(SortOption.authorAsc.sortOrder, GSortOrder.ASC);
      });

      test('completedAtDesc should return COMPLETED_AT and DESC', () {
        expect(
          SortOption.completedAtDesc.sortField,
          GShelfSortField.COMPLETED_AT,
        );
        expect(SortOption.completedAtDesc.sortOrder, GSortOrder.DESC);
      });

      test('completedAtAsc should return COMPLETED_AT and ASC', () {
        expect(
          SortOption.completedAtAsc.sortField,
          GShelfSortField.COMPLETED_AT,
        );
        expect(SortOption.completedAtAsc.sortOrder, GSortOrder.ASC);
      });

      test('publishedDateDesc should return PUBLISHED_DATE and DESC', () {
        expect(
          SortOption.publishedDateDesc.sortField,
          GShelfSortField.PUBLISHED_DATE,
        );
        expect(SortOption.publishedDateDesc.sortOrder, GSortOrder.DESC);
      });

      test('publishedDateAsc should return PUBLISHED_DATE and ASC', () {
        expect(
          SortOption.publishedDateAsc.sortField,
          GShelfSortField.PUBLISHED_DATE,
        );
        expect(SortOption.publishedDateAsc.sortOrder, GSortOrder.ASC);
      });
    });

    group('visibleValues', () {
      test('should have 7 options', () {
        expect(SortOption.visibleValues.length, 7);
      });

      test('should not contain titleAsc', () {
        expect(SortOption.visibleValues, isNot(contains(SortOption.titleAsc)));
      });

      test('should be ordered as addedAt → completedAt → publishedDate → author', () {
        expect(SortOption.visibleValues, [
          SortOption.addedAtDesc,
          SortOption.addedAtAsc,
          SortOption.completedAtDesc,
          SortOption.completedAtAsc,
          SortOption.publishedDateDesc,
          SortOption.publishedDateAsc,
          SortOption.authorAsc,
        ]);
      });
    });

    group('default', () {
      test('defaultOption should be addedAtDesc', () {
        expect(SortOption.defaultOption, SortOption.addedAtDesc);
      });
    });
  });
}
