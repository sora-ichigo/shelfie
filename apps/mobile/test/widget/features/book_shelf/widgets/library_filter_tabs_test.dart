import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/library_filter_tabs.dart';

void main() {
  Widget buildTestWidget({
    required LibraryFilterTab selectedTab,
    required ValueChanged<LibraryFilterTab> onTabChanged,
  }) {
    return MaterialApp(
      theme: AppTheme.dark(),
      home: Scaffold(
        body: LibraryFilterTabs(
          selectedTab: selectedTab,
          onTabChanged: onTabChanged,
        ),
      ),
    );
  }

  group('LibraryFilterTabs', () {
    group('tab display', () {
      testWidgets('displays two tabs: books, lists', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          selectedTab: LibraryFilterTab.books,
          onTabChanged: (_) {},
        ));
        await tester.pump();

        expect(find.text('すべて'), findsOneWidget);
        expect(find.text('ブックリスト'), findsOneWidget);
      });

      testWidgets('highlights selected tab (books)', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          selectedTab: LibraryFilterTab.books,
          onTabChanged: (_) {},
        ));
        await tester.pump();

        final booksTabContainer = find.ancestor(
          of: find.text('すべて'),
          matching: find.byType(AnimatedContainer),
        );
        expect(booksTabContainer, findsOneWidget);
      });

      testWidgets('highlights selected tab (lists)', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          selectedTab: LibraryFilterTab.lists,
          onTabChanged: (_) {},
        ));
        await tester.pump();

        final listsTabContainer = find.ancestor(
          of: find.text('ブックリスト'),
          matching: find.byType(AnimatedContainer),
        );
        expect(listsTabContainer, findsOneWidget);
      });
    });

    group('tab selection', () {
      testWidgets('calls onTabChanged when "books" tab is tapped',
          (tester) async {
        LibraryFilterTab? selectedTab;

        await tester.pumpWidget(buildTestWidget(
          selectedTab: LibraryFilterTab.lists,
          onTabChanged: (tab) => selectedTab = tab,
        ));
        await tester.pump();

        await tester.tap(find.text('すべて'));
        await tester.pumpAndSettle();

        expect(selectedTab, LibraryFilterTab.books);
      });

      testWidgets('calls onTabChanged when "lists" tab is tapped',
          (tester) async {
        LibraryFilterTab? selectedTab;

        await tester.pumpWidget(buildTestWidget(
          selectedTab: LibraryFilterTab.books,
          onTabChanged: (tab) => selectedTab = tab,
        ));
        await tester.pump();

        await tester.tap(find.text('ブックリスト'));
        await tester.pumpAndSettle();

        expect(selectedTab, LibraryFilterTab.lists);
      });

      testWidgets('allows switching from books to lists', (tester) async {
        LibraryFilterTab? selectedTab;

        await tester.pumpWidget(buildTestWidget(
          selectedTab: LibraryFilterTab.books,
          onTabChanged: (tab) => selectedTab = tab,
        ));
        await tester.pump();

        await tester.tap(find.text('ブックリスト'));
        await tester.pumpAndSettle();

        expect(selectedTab, LibraryFilterTab.lists);
      });

      testWidgets('allows switching from lists to books', (tester) async {
        LibraryFilterTab? selectedTab;

        await tester.pumpWidget(buildTestWidget(
          selectedTab: LibraryFilterTab.lists,
          onTabChanged: (tab) => selectedTab = tab,
        ));
        await tester.pump();

        await tester.tap(find.text('すべて'));
        await tester.pumpAndSettle();

        expect(selectedTab, LibraryFilterTab.books);
      });
    });

    group('LibraryFilterTab extension', () {
      test('returns correct label for books', () {
        expect(LibraryFilterTab.books.label, 'すべて');
      });

      test('returns correct label for lists', () {
        expect(LibraryFilterTab.lists.label, 'ブックリスト');
      });
    });
  });
}
