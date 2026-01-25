import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_shelf/domain/group_option.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/search_filter_bar.dart';

void main() {
  Widget buildSearchFilterBar({
    SortOption sortOption = SortOption.addedAtDesc,
    GroupOption groupOption = GroupOption.none,
    void Function(SortOption)? onSortChanged,
    void Function(GroupOption)? onGroupChanged,
  }) {
    return MaterialApp(
      theme: AppTheme.dark(),
      home: Scaffold(
        body: SearchFilterBar(
          sortOption: sortOption,
          groupOption: groupOption,
          onSortChanged: onSortChanged ?? (_) {},
          onGroupChanged: onGroupChanged ?? (_) {},
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

      testWidgets('4つのソートオプションがBottomSheetに表示される', (tester) async {
        await tester.pumpWidget(buildSearchFilterBar());

        await tester.tap(find.byIcon(Icons.tune));
        await tester.pumpAndSettle();

        expect(find.text('追加日（新しい順）'), findsOneWidget);
        expect(find.text('追加日（古い順）'), findsOneWidget);
        expect(find.text('タイトル（A→Z）'), findsOneWidget);
        expect(find.text('著者名（A→Z）'), findsOneWidget);
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

        await tester.tap(find.text('タイトル（A→Z）'));
        await tester.pumpAndSettle();

        expect(selectedOption, equals(SortOption.titleAsc));
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

    group('グループ化ボタン', () {
      testWidgets('グループ化ボタンが表示される', (tester) async {
        await tester.pumpWidget(buildSearchFilterBar());

        expect(find.byIcon(Icons.grid_view), findsOneWidget);
      });

      testWidgets('グループ化ボタンタップでBottomSheetが表示される', (tester) async {
        await tester.pumpWidget(buildSearchFilterBar());

        await tester.tap(find.byIcon(Icons.grid_view));
        await tester.pumpAndSettle();

        expect(find.text('グループ化'), findsOneWidget);
      });

      testWidgets('3つのグループ化オプションがBottomSheetに表示される', (tester) async {
        await tester.pumpWidget(buildSearchFilterBar());

        await tester.tap(find.byIcon(Icons.grid_view));
        await tester.pumpAndSettle();

        expect(find.text('すべて'), findsOneWidget);
        expect(find.text('ステータス別'), findsOneWidget);
        expect(find.text('著者別'), findsOneWidget);
      });

      testWidgets('グループ化オプション選択時にコールバックが呼ばれる', (tester) async {
        GroupOption? selectedOption;

        await tester.pumpWidget(
          buildSearchFilterBar(
            onGroupChanged: (option) => selectedOption = option,
          ),
        );

        await tester.tap(find.byIcon(Icons.grid_view));
        await tester.pumpAndSettle();

        await tester.tap(find.text('ステータス別'));
        await tester.pumpAndSettle();

        expect(selectedOption, equals(GroupOption.byStatus));
      });

      testWidgets('デフォルト以外選択時にインジケーターが表示される', (tester) async {
        await tester.pumpWidget(
          buildSearchFilterBar(groupOption: GroupOption.byStatus),
        );

        // Stackが使われていることを確認（インジケーター用）
        final groupButtonFinder = find.ancestor(
          of: find.byIcon(Icons.grid_view),
          matching: find.byType(Stack),
        );
        expect(groupButtonFinder, findsOneWidget);
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
