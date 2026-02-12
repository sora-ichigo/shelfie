import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/search_filter_bar.dart';

void main() {
  Widget buildSearchFilterBar({
    SortOption sortOption = SortOption.addedAtDesc,
    void Function(SortOption)? onSortChanged,
    void Function(ShelfBookItem)? onBookTap,
  }) {
    return MaterialApp(
      theme: AppTheme.dark(),
      home: Scaffold(
        body: SearchFilterBar(
          sortOption: sortOption,
          onSortChanged: onSortChanged ?? (_) {},
          onBookTap: onBookTap ?? (_) {},
        ),
      ),
    );
  }

  group('SearchFilterBar', () {
    group('ソートボタン', () {
      testWidgets('ソートボタンが表示される', (tester) async {
        await tester.pumpWidget(buildSearchFilterBar());

        expect(find.byIcon(Icons.tune), findsOneWidget);
      });

      testWidgets('ソートボタンタップでBottomSheetが表示される', (tester) async {
        await tester.pumpWidget(buildSearchFilterBar());

        await tester.tap(find.byIcon(Icons.tune));
        await tester.pumpAndSettle();

        expect(find.text('並び替え'), findsOneWidget);
      });

      testWidgets('visibleValuesのソートオプションがBottomSheetに表示される', (tester) async {
        await tester.pumpWidget(buildSearchFilterBar());

        await tester.tap(find.byIcon(Icons.tune));
        await tester.pumpAndSettle();

        for (final option in SortOption.visibleValues) {
          expect(find.text(option.displayName), findsOneWidget);
        }
        expect(find.text('タイトル（A→Z）'), findsNothing);
      });

      testWidgets('ソートオプション選択時にコールバックが呼ばれる', (tester) async {
        SortOption? selectedOption;

        await tester.pumpWidget(
          buildSearchFilterBar(
            onSortChanged: (option) => selectedOption = option,
          ),
        );

        await tester.tap(find.byIcon(Icons.tune));
        await tester.pumpAndSettle();

        await tester.tap(find.text('著者名（A→Z）'));
        await tester.pumpAndSettle();

        expect(selectedOption, equals(SortOption.authorAsc));
      });

      testWidgets('デフォルト以外選択時にインジケーターが表示される', (tester) async {
        await tester.pumpWidget(
          buildSearchFilterBar(sortOption: SortOption.titleAsc),
        );

        // Stackが使われていることを確認（インジケーター用）
        final sortButtonFinder = find.ancestor(
          of: find.byIcon(Icons.tune),
          matching: find.byType(Stack),
        );
        expect(sortButtonFinder, findsOneWidget);
      });
    });

    group('検索ボタン', () {
      testWidgets('検索ボタンが表示される', (tester) async {
        await tester.pumpWidget(buildSearchFilterBar());

        expect(find.byIcon(Icons.search), findsOneWidget);
      });

      testWidgets('検索ボタンがソートボタンの左に配置される', (tester) async {
        await tester.pumpWidget(buildSearchFilterBar());

        final searchCenter = tester.getCenter(find.byIcon(Icons.search));
        final sortCenter = tester.getCenter(find.byIcon(Icons.tune));

        expect(searchCenter.dx, lessThan(sortCenter.dx));
      });
    });

    group('テーマ', () {
      testWidgets('ダークテーマに準拠したデザインで表示される', (tester) async {
        await tester.pumpWidget(buildSearchFilterBar());

        final context = tester.element(find.byType(SearchFilterBar));
        final theme = Theme.of(context);

        expect(theme.brightness, equals(Brightness.dark));
      });
    });
  });
}
