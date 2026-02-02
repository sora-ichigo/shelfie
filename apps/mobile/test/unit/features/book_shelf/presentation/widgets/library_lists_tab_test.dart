import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_list/presentation/widgets/create_list_card.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/library_lists_tab.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  setUpAll(registerTestFallbackValues);

  group('LibraryListsTab', () {
    testWidgets('isLoading が true のとき LoadingIndicator を表示する',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: LibraryListsTab(
            lists: const [],
            hasBooks: true,
            isLoading: true,
            onListTap: (_) {},
            onCreateTap: () {},
          ),
        ),
      );

      expect(find.byType(LoadingIndicator), findsOneWidget);
      expect(find.byType(CreateListCard), findsNothing);
    });

    testWidgets('isLoading が false でリストが空のとき CreateListCard を表示する',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          child: LibraryListsTab(
            lists: const [],
            hasBooks: true,
            isLoading: false,
            onListTap: (_) {},
            onCreateTap: () {},
          ),
        ),
      );

      expect(find.byType(LoadingIndicator), findsNothing);
      expect(find.byType(CreateListCard), findsOneWidget);
    });

    testWidgets('リストがあるとき一覧を表示する', (tester) async {
      final now = DateTime(2025);
      final lists = [
        BookListSummary(
          id: 1,
          title: 'テストリスト',
          bookCount: 3,
          coverImages: const [],
          createdAt: now,
          updatedAt: now,
        ),
      ];

      await tester.pumpWidget(
        buildTestWidget(
          child: LibraryListsTab(
            lists: lists,
            hasBooks: true,
            isLoading: false,
            onListTap: (_) {},
            onCreateTap: () {},
          ),
        ),
      );

      expect(find.byType(LoadingIndicator), findsNothing);
      expect(find.text('テストリスト'), findsOneWidget);
    });
  });
}
