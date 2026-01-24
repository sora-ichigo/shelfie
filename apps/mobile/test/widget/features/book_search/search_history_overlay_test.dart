import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_search/domain/search_history_entry.dart';
import 'package:shelfie/features/book_search/presentation/widgets/search_history_overlay.dart';

void main() {
  group('SearchHistoryOverlay', () {
    final testEntries = [
      SearchHistoryEntry(
        query: 'Flutter',
        searchedAt: DateTime(2026, 1, 25, 10, 0),
      ),
      SearchHistoryEntry(
        query: 'Dart programming',
        searchedAt: DateTime(2026, 1, 24, 15, 30),
      ),
      SearchHistoryEntry(
        query: 'Clean Architecture',
        searchedAt: DateTime(2026, 1, 23, 9, 0),
      ),
    ];

    Widget buildTestWidget({
      required List<SearchHistoryEntry> entries,
      void Function(String)? onHistorySelected,
      void Function(String)? onHistoryDeleted,
      void Function()? onClearAll,
    }) {
      return ProviderScope(
        child: MaterialApp(
          theme: AppTheme.theme,
          home: Scaffold(
            body: SearchHistoryOverlay(
              entries: entries,
              onHistorySelected: onHistorySelected ?? (_) {},
              onHistoryDeleted: onHistoryDeleted ?? (_) {},
              onClearAll: onClearAll ?? () {},
            ),
          ),
        ),
      );
    }

    testWidgets('履歴候補を表示する', (tester) async {
      await tester.pumpWidget(buildTestWidget(entries: testEntries));
      await tester.pumpAndSettle();

      expect(find.text('Flutter'), findsOneWidget);
      expect(find.text('Dart programming'), findsOneWidget);
      expect(find.text('Clean Architecture'), findsOneWidget);
    });

    testWidgets('履歴が空の場合は何も表示しない', (tester) async {
      await tester.pumpWidget(buildTestWidget(entries: []));
      await tester.pumpAndSettle();

      expect(find.byType(SearchHistoryOverlay), findsOneWidget);
      expect(find.text('Flutter'), findsNothing);
      expect(find.text('検索履歴'), findsNothing);
    });

    testWidgets('履歴項目タップで onHistorySelected が呼ばれる', (tester) async {
      String? selectedQuery;
      await tester.pumpWidget(
        buildTestWidget(
          entries: testEntries,
          onHistorySelected: (query) => selectedQuery = query,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Flutter'));
      await tester.pumpAndSettle();

      expect(selectedQuery, equals('Flutter'));
    });

    testWidgets('左スワイプで項目が削除される（onHistoryDeleted が呼ばれる）', (tester) async {
      String? deletedQuery;
      await tester.pumpWidget(
        buildTestWidget(
          entries: testEntries,
          onHistoryDeleted: (query) => deletedQuery = query,
        ),
      );
      await tester.pumpAndSettle();

      final flutterItem = find.text('Flutter');
      expect(flutterItem, findsOneWidget);

      await tester.drag(flutterItem, const Offset(-500, 0));
      await tester.pumpAndSettle();

      expect(deletedQuery, equals('Flutter'));
    });

    testWidgets('「すべて削除」をタップで onClearAll が呼ばれる', (tester) async {
      var clearAllCalled = false;
      await tester.pumpWidget(
        buildTestWidget(
          entries: testEntries,
          onClearAll: () => clearAllCalled = true,
        ),
      );
      await tester.pumpAndSettle();

      final clearAllButton = find.text('すべて削除');
      expect(clearAllButton, findsOneWidget);

      await tester.tap(clearAllButton);
      await tester.pumpAndSettle();

      expect(clearAllCalled, isTrue);
    });

    testWidgets('各履歴項目に履歴アイコンが表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(entries: testEntries));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.history), findsNWidgets(testEntries.length));
    });
  });
}
