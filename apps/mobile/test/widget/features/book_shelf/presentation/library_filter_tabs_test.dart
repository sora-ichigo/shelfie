import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/library_filter_tabs.dart';

void main() {
  group('LibraryFilterTabs', () {
    Widget buildTestWidget({
      LibraryFilterTab selectedTab = LibraryFilterTab.all,
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
      testWidgets('displays all three tabs', (tester) async {
        await tester.pumpWidget(buildTestWidget());

        expect(find.text('すべて'), findsOneWidget);
        expect(find.text('本'), findsOneWidget);
        expect(find.text('リスト'), findsOneWidget);
      });

      testWidgets('highlights selected "all" tab', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          selectedTab: LibraryFilterTab.all,
        ));

        final allTab = find.ancestor(
          of: find.text('すべて'),
          matching: find.byType(InkWell),
        );
        expect(allTab, findsOneWidget);
      });

      testWidgets('highlights selected "books" tab', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          selectedTab: LibraryFilterTab.books,
        ));

        final booksTab = find.ancestor(
          of: find.text('本'),
          matching: find.byType(InkWell),
        );
        expect(booksTab, findsOneWidget);
      });

      testWidgets('highlights selected "lists" tab', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          selectedTab: LibraryFilterTab.lists,
        ));

        final listsTab = find.ancestor(
          of: find.text('リスト'),
          matching: find.byType(InkWell),
        );
        expect(listsTab, findsOneWidget);
      });
    });

    group('tab interaction', () {
      testWidgets('calls onTabChanged with "all" when "すべて" is tapped',
          (tester) async {
        LibraryFilterTab? changedTab;

        await tester.pumpWidget(buildTestWidget(
          selectedTab: LibraryFilterTab.books,
          onTabChanged: (tab) => changedTab = tab,
        ));

        await tester.tap(find.text('すべて'));
        await tester.pumpAndSettle();

        expect(changedTab, LibraryFilterTab.all);
      });

      testWidgets('calls onTabChanged with "books" when "本" is tapped',
          (tester) async {
        LibraryFilterTab? changedTab;

        await tester.pumpWidget(buildTestWidget(
          selectedTab: LibraryFilterTab.all,
          onTabChanged: (tab) => changedTab = tab,
        ));

        await tester.tap(find.text('本'));
        await tester.pumpAndSettle();

        expect(changedTab, LibraryFilterTab.books);
      });

      testWidgets('calls onTabChanged with "lists" when "リスト" is tapped',
          (tester) async {
        LibraryFilterTab? changedTab;

        await tester.pumpWidget(buildTestWidget(
          selectedTab: LibraryFilterTab.all,
          onTabChanged: (tab) => changedTab = tab,
        ));

        await tester.tap(find.text('リスト'));
        await tester.pumpAndSettle();

        expect(changedTab, LibraryFilterTab.lists);
      });
    });
  });
}
