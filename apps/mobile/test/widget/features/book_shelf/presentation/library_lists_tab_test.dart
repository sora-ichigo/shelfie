import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/library_lists_tab.dart';

void main() {
  final now = DateTime(2024, 1, 15, 10, 30);

  BookListSummary createListSummary({
    int id = 1,
    String title = 'Test List',
    int bookCount = 3,
    List<String> coverImages = const [],
  }) {
    return BookListSummary(
      id: id,
      title: title,
      description: null,
      bookCount: bookCount,
      coverImages: coverImages,
      createdAt: now,
      updatedAt: now,
    );
  }

  group('LibraryListsTab', () {
    testWidgets('displays vertical list of book lists with horizontal layout',
        (tester) async {
      final lists = [
        createListSummary(id: 1, title: 'My List 1'),
        createListSummary(id: 2, title: 'My List 2'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: LibraryListsTab(
              lists: lists,

              onListTap: (_) {},
              onCreateTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('My List 1'), findsOneWidget);
      expect(find.text('My List 2'), findsOneWidget);
    });

    testWidgets('displays empty state with create button when lists is empty',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: LibraryListsTab(
              lists: [],

              onListTap: (_) {},
              onCreateTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('最初のリストを作成'), findsOneWidget);
      expect(find.text('リストを作成'), findsOneWidget);
    });

    testWidgets('calls onCreateTap when create button is tapped in empty state',
        (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: LibraryListsTab(
              lists: [],

              onListTap: (_) {},
              onCreateTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('リストを作成'));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('displays create button when lists exist', (tester) async {
      final lists = [
        createListSummary(id: 1, title: 'Existing List'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: LibraryListsTab(
              lists: lists,

              onListTap: (_) {},
              onCreateTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('新しいリスト'), findsOneWidget);
    });
  });
}
