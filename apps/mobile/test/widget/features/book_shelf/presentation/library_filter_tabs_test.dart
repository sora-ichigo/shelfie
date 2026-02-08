import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/library_filter_tabs.dart';

void main() {
  group('LibraryFilterTabs', () {
    Widget buildTestWidget({
      LibraryFilterTab selectedTab = LibraryFilterTab.books,
      ValueChanged<LibraryFilterTab>? onTabChanged,
    }) {
      return MaterialApp(
        theme: AppTheme.dark(),
        home: Scaffold(
          body: LibraryFilterTabs(
            selectedTab: selectedTab,
            onTabChanged: onTabChanged ?? (_) {},
          ),
        ),
      );
    }

    group('tab display', () {
      testWidgets('displays two tabs', (tester) async {
        await tester.pumpWidget(buildTestWidget());

        expect(find.text('本棚'), findsOneWidget);
        expect(find.text('ブックリスト'), findsOneWidget);
      });

      testWidgets('highlights selected "books" tab', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          selectedTab: LibraryFilterTab.books,
        ));

        final booksTab = find.ancestor(
          of: find.text('本棚'),
          matching: find.byType(GestureDetector),
        );
        expect(booksTab, findsOneWidget);
      });

      testWidgets('highlights selected "lists" tab', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          selectedTab: LibraryFilterTab.lists,
        ));

        final listsTab = find.ancestor(
          of: find.text('ブックリスト'),
          matching: find.byType(GestureDetector),
        );
        expect(listsTab, findsOneWidget);
      });
    });

    group('tab interaction', () {
      testWidgets('calls onTabChanged with "books" when "本" is tapped',
          (tester) async {
        LibraryFilterTab? changedTab;

        await tester.pumpWidget(buildTestWidget(
          selectedTab: LibraryFilterTab.lists,
          onTabChanged: (tab) => changedTab = tab,
        ));

        await tester.tap(find.text('本棚'));
        await tester.pumpAndSettle();

        expect(changedTab, LibraryFilterTab.books);
      });

      testWidgets('calls onTabChanged with "lists" when "リスト" is tapped',
          (tester) async {
        LibraryFilterTab? changedTab;

        await tester.pumpWidget(buildTestWidget(
          selectedTab: LibraryFilterTab.books,
          onTabChanged: (tab) => changedTab = tab,
        ));

        await tester.tap(find.text('ブックリスト'));
        await tester.pumpAndSettle();

        expect(changedTab, LibraryFilterTab.lists);
      });
    });
  });
}
