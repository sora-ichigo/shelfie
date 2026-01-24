import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart';
import 'package:shelfie/features/book_search/presentation/widgets/book_list_item.dart';

import '../../../helpers/test_helpers.dart';

void main() {
  setUpAll(registerTestFallbackValues);

  group('BookListItem Tap Navigation', () {
    group('10.1 書籍検索結果画面からのタップで BookDetailScreen に遷移', () {
      testWidgets('BookListItem がタップ可能である', (tester) async {
        var tapped = false;

        await tester.pumpWidget(
          buildTestWidget(
            child: BookListItem(
              book: const Book(
                id: 'test-id',
                title: 'Test Book',
                authors: ['Test Author'],
              ),
              onAddPressed: () {},
              onTap: () {
                tapped = true;
              },
            ),
          ),
        );

        // ListTile 部分をタップ
        await tester.tap(find.byType(ListTile));
        await tester.pumpAndSettle();

        expect(tapped, isTrue);
      });

      testWidgets('BookListItem タップ時に正しい bookId が渡される', (tester) async {
        String? tappedBookId;
        const expectedBookId = 'expected-book-id';

        await tester.pumpWidget(
          buildTestWidget(
            child: BookListItem(
              book: const Book(
                id: expectedBookId,
                title: 'Test Book',
                authors: ['Test Author'],
              ),
              onAddPressed: () {},
              onTap: () {
                tappedBookId = expectedBookId;
              },
            ),
          ),
        );

        await tester.tap(find.byType(ListTile));
        await tester.pumpAndSettle();

        expect(tappedBookId, expectedBookId);
      });

      testWidgets('追加ボタンをタップしても onTap は呼ばれない', (tester) async {
        var listItemTapped = false;
        var addButtonTapped = false;

        await tester.pumpWidget(
          buildTestWidget(
            child: BookListItem(
              book: const Book(
                id: 'test-id',
                title: 'Test Book',
                authors: ['Test Author'],
              ),
              onAddPressed: () {
                addButtonTapped = true;
              },
              onTap: () {
                listItemTapped = true;
              },
            ),
          ),
        );

        // 追加ボタンをタップ
        await tester.tap(find.byIcon(Icons.add_circle_outline));
        await tester.pumpAndSettle();

        expect(addButtonTapped, isTrue);
        expect(listItemTapped, isFalse);
      });
    });
  });
}
