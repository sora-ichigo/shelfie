import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/library_lists_tab.dart';

import '../../../../../helpers/test_helpers.dart';

void main() {
  setUpAll(registerTestFallbackValues);

  Widget buildTestWidget({
    required List<BookListSummary> lists,
    required bool hasBooks,
    ValueChanged<BookListSummary>? onListTap,
    VoidCallback? onCreateTap,
  }) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: Scaffold(
        body: LibraryListsTab(
          lists: lists,
          hasBooks: hasBooks,
          onListTap: onListTap ?? (_) {},
          onCreateTap: onCreateTap ?? () {},
        ),
      ),
    );
  }

  BookListSummary createTestList({
    int id = 1,
    String title = 'Test List',
  }) {
    return BookListSummary(
      id: id,
      title: title,
      bookCount: 0,
      coverImages: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  group('LibraryListsTab', () {
    group('本がない場合', () {
      testWidgets('empty stateを表示する', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            lists: [],
            hasBooks: false,
          ),
        );

        expect(find.text('「さがす」タブから本を追加してみましょう'), findsOneWidget);
        expect(find.byIcon(Icons.auto_stories_outlined), findsOneWidget);
      });
    });

    group('本があってリストがない場合', () {
      testWidgets('リスト作成を促すempty stateを表示する', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            lists: [],
            hasBooks: true,
          ),
        );

        expect(find.text('最初のリストを作成'), findsOneWidget);
        expect(
          find.text('本を整理して、\nあなただけのリストを作りましょう'),
          findsOneWidget,
        );
      });

      testWidgets('「リストを作成」ボタンをタップするとonCreateTapが呼ばれる',
          (tester) async {
        var createTapped = false;

        await tester.pumpWidget(
          buildTestWidget(
            lists: [],
            hasBooks: true,
            onCreateTap: () => createTapped = true,
          ),
        );

        await tester.tap(find.text('リストを作成'));
        await tester.pump();

        expect(createTapped, isTrue);
      });
    });

    group('リストがある場合', () {
      testWidgets('リスト一覧を表示する', (tester) async {
        final lists = [
          createTestList(id: 1, title: 'リスト1'),
          createTestList(id: 2, title: 'リスト2'),
        ];

        await tester.pumpWidget(
          buildTestWidget(
            lists: lists,
            hasBooks: true,
          ),
        );

        expect(find.text('リスト1'), findsOneWidget);
        expect(find.text('リスト2'), findsOneWidget);
      });

      testWidgets('「新しいリスト」ボタンを表示する', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            lists: [createTestList()],
            hasBooks: true,
          ),
        );

        expect(find.text('新しいリスト'), findsOneWidget);
      });
    });
  });
}
