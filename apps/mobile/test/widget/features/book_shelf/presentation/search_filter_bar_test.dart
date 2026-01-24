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
    void Function(String)? onSearchChanged,
    void Function(SortOption)? onSortChanged,
    void Function(GroupOption)? onGroupChanged,
  }) {
    return MaterialApp(
      theme: AppTheme.dark(),
      home: Scaffold(
        body: SearchFilterBar(
          sortOption: sortOption,
          groupOption: groupOption,
          onSearchChanged: onSearchChanged ?? (_) {},
          onSortChanged: onSortChanged ?? (_) {},
          onGroupChanged: onGroupChanged ?? (_) {},
        ),
      ),
    );
  }

  group('SearchFilterBar', () {
    group('検索バー', () {
      testWidgets('虫眼鏡アイコンが表示される', (tester) async {
        await tester.pumpWidget(buildSearchFilterBar());

        expect(find.byIcon(Icons.search), findsOneWidget);
      });

      testWidgets('「本を検索...」プレースホルダーが表示される', (tester) async {
        await tester.pumpWidget(buildSearchFilterBar());

        expect(find.text('本を検索...'), findsOneWidget);
      });

      testWidgets('検索入力後にクリアボタンが表示される', (tester) async {
        await tester.pumpWidget(buildSearchFilterBar());

        await tester.enterText(find.byType(TextField), 'テスト');
        await tester.pump();

        expect(find.byIcon(Icons.clear), findsOneWidget);
      });

      testWidgets('クリアボタンタップで入力がクリアされる', (tester) async {
        await tester.pumpWidget(buildSearchFilterBar());

        await tester.enterText(find.byType(TextField), 'テスト');
        await tester.pump();

        await tester.tap(find.byIcon(Icons.clear));
        await tester.pump();

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.controller?.text, isEmpty);
      });
    });

    group('検索デバウンス', () {
      testWidgets('検索入力時は300msのデバウンスが適用される', (tester) async {
        var callCount = 0;
        String? lastValue;

        await tester.pumpWidget(
          buildSearchFilterBar(
            onSearchChanged: (value) {
              callCount++;
              lastValue = value;
            },
          ),
        );

        await tester.enterText(find.byType(TextField), 'テ');
        await tester.pump(const Duration(milliseconds: 100));

        await tester.enterText(find.byType(TextField), 'テス');
        await tester.pump(const Duration(milliseconds: 100));

        await tester.enterText(find.byType(TextField), 'テスト');
        await tester.pump(const Duration(milliseconds: 100));

        expect(callCount, equals(0));

        await tester.pump(const Duration(milliseconds: 300));

        expect(callCount, equals(1));
        expect(lastValue, equals('テスト'));
      });
    });

    group('ソート選択ドロップダウン', () {
      testWidgets('ソート選択ドロップダウンが表示される', (tester) async {
        await tester.pumpWidget(buildSearchFilterBar());

        expect(find.byType(DropdownButton<SortOption>), findsOneWidget);
      });

      testWidgets('4つのソートオプションが表示される', (tester) async {
        await tester.pumpWidget(buildSearchFilterBar());

        await tester.tap(find.byType(DropdownButton<SortOption>));
        await tester.pumpAndSettle();

        expect(find.text('追加日（新しい順）'), findsWidgets);
        expect(find.text('追加日（古い順）'), findsOneWidget);
        expect(find.text('タイトル（A→Z）'), findsOneWidget);
        expect(find.text('著者名（A→Z）'), findsOneWidget);
      });

      testWidgets('デフォルトで「追加日（新しい順）」が選択状態', (tester) async {
        await tester.pumpWidget(buildSearchFilterBar());

        final dropdown = tester.widget<DropdownButton<SortOption>>(
          find.byType(DropdownButton<SortOption>),
        );

        expect(dropdown.value, equals(SortOption.addedAtDesc));
      });

      testWidgets('ソートオプション選択時にコールバックが呼ばれる', (tester) async {
        SortOption? selectedOption;

        await tester.pumpWidget(
          buildSearchFilterBar(
            onSortChanged: (option) => selectedOption = option,
          ),
        );

        await tester.tap(find.byType(DropdownButton<SortOption>));
        await tester.pumpAndSettle();

        await tester.tap(find.text('タイトル（A→Z）').last);
        await tester.pumpAndSettle();

        expect(selectedOption, equals(SortOption.titleAsc));
      });
    });

    group('グループ化選択ドロップダウン', () {
      testWidgets('グループ化選択ドロップダウンが表示される', (tester) async {
        await tester.pumpWidget(buildSearchFilterBar());

        expect(find.byType(DropdownButton<GroupOption>), findsOneWidget);
      });

      testWidgets('3つのグループ化オプションが表示される', (tester) async {
        await tester.pumpWidget(buildSearchFilterBar());

        await tester.tap(find.byType(DropdownButton<GroupOption>));
        await tester.pumpAndSettle();

        expect(find.text('すべて'), findsWidgets);
        expect(find.text('ステータス別'), findsOneWidget);
        expect(find.text('著者別'), findsOneWidget);
      });

      testWidgets('デフォルトで「すべて」が選択状態', (tester) async {
        await tester.pumpWidget(buildSearchFilterBar());

        final dropdown = tester.widget<DropdownButton<GroupOption>>(
          find.byType(DropdownButton<GroupOption>),
        );

        expect(dropdown.value, equals(GroupOption.none));
      });

      testWidgets('グループ化オプション選択時にコールバックが呼ばれる', (tester) async {
        GroupOption? selectedOption;

        await tester.pumpWidget(
          buildSearchFilterBar(
            onGroupChanged: (option) => selectedOption = option,
          ),
        );

        await tester.tap(find.byType(DropdownButton<GroupOption>));
        await tester.pumpAndSettle();

        await tester.tap(find.text('ステータス別').last);
        await tester.pumpAndSettle();

        expect(selectedOption, equals(GroupOption.byStatus));
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
