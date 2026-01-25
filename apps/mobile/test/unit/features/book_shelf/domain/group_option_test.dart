import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/book_shelf/domain/group_option.dart';

void main() {
  group('GroupOption', () {
    group('values', () {
      test('should have 3 options', () {
        expect(GroupOption.values.length, 3);
      });

      test('should have none as first option (default)', () {
        expect(GroupOption.values.first, GroupOption.none);
      });

      test('should include all expected options', () {
        expect(GroupOption.values, contains(GroupOption.none));
        expect(GroupOption.values, contains(GroupOption.byStatus));
        expect(GroupOption.values, contains(GroupOption.byAuthor));
      });
    });

    group('displayName', () {
      test('none should return correct Japanese label', () {
        expect(GroupOption.none.displayName, 'すべて');
      });

      test('byStatus should return correct Japanese label', () {
        expect(GroupOption.byStatus.displayName, 'ステータス別');
      });

      test('byAuthor should return correct Japanese label', () {
        expect(GroupOption.byAuthor.displayName, '著者別');
      });
    });

    group('default', () {
      test('defaultOption should be none', () {
        expect(GroupOption.defaultOption, GroupOption.none);
      });
    });
  });
}
