import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_search/domain/recent_book_entry.dart';
import 'package:shelfie/features/book_search/presentation/widgets/recent_books_section.dart';

void main() {
  group('RecentBooksSection', () {
    final testBooks = [
      RecentBookEntry(
        bookId: 'book1',
        title: 'Flutter Complete Guide',
        authors: const ['John Doe'],
        coverImageUrl: 'https://example.com/cover1.jpg',
        viewedAt: DateTime(2026, 1, 25, 10, 0),
      ),
      RecentBookEntry(
        bookId: 'book2',
        title: 'Dart Programming',
        authors: const ['Jane Smith', 'Bob Wilson'],
        coverImageUrl: null,
        viewedAt: DateTime(2026, 1, 24, 15, 30),
      ),
      RecentBookEntry(
        bookId: 'book3',
        title: 'Clean Architecture',
        authors: const ['Robert Martin'],
        coverImageUrl: 'https://example.com/cover3.jpg',
        viewedAt: DateTime(2026, 1, 23, 9, 0),
      ),
    ];

    Widget buildTestWidget({
      required List<RecentBookEntry> books,
      void Function(String)? onBookTap,
    }) {
      return ProviderScope(
        child: MaterialApp(
          theme: AppTheme.theme,
          home: Scaffold(
            body: RecentBooksSection(
              books: books,
              onBookTap: onBookTap ?? (_) {},
            ),
          ),
        ),
      );
    }

    testWidgets('最近チェックした本を表示する', (tester) async {
      await tester.pumpWidget(buildTestWidget(books: testBooks));
      await tester.pumpAndSettle();

      expect(find.text('最近チェックした本'), findsOneWidget);
      expect(find.text('Flutter Complete Guide'), findsOneWidget);
      expect(find.text('Dart Programming'), findsOneWidget);
      expect(find.text('Clean Architecture'), findsOneWidget);
    });

    testWidgets('履歴が空の場合はセクション全体を非表示', (tester) async {
      await tester.pumpWidget(buildTestWidget(books: []));
      await tester.pumpAndSettle();

      expect(find.byType(RecentBooksSection), findsOneWidget);
      expect(find.text('最近チェックした本'), findsNothing);
    });

    testWidgets('項目タップで onBookTap が bookId と共に呼ばれる', (tester) async {
      String? tappedBookId;
      await tester.pumpWidget(
        buildTestWidget(
          books: testBooks,
          onBookTap: (bookId) => tappedBookId = bookId,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Flutter Complete Guide'));
      await tester.pumpAndSettle();

      expect(tappedBookId, equals('book1'));
    });

    testWidgets('カバー画像がない場合はプレースホルダーアイコンを表示', (tester) async {
      await tester.pumpWidget(buildTestWidget(books: testBooks));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.book), findsWidgets);
    });

    testWidgets('各項目にカバー画像とタイトルを表示', (tester) async {
      await tester.pumpWidget(buildTestWidget(books: testBooks));
      await tester.pumpAndSettle();

      expect(find.text('Flutter Complete Guide'), findsOneWidget);
      expect(find.text('Dart Programming'), findsOneWidget);
      expect(find.text('Clean Architecture'), findsOneWidget);
    });

    testWidgets('水平スクロール可能なリスト形式で表示', (tester) async {
      await tester.pumpWidget(buildTestWidget(books: testBooks));
      await tester.pumpAndSettle();

      final listView = find.byType(ListView);
      expect(listView, findsOneWidget);

      final listViewWidget = tester.widget<ListView>(listView);
      expect(listViewWidget.scrollDirection, Axis.horizontal);
    });
  });
}
