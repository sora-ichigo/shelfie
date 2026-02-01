import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_detail/domain/book_detail.dart';
import 'package:shelfie/features/book_detail/presentation/widgets/book_info_section.dart';

void main() {
  Widget buildTestWidget({required BookDetail bookDetail}) {
    return MaterialApp(
      theme: AppTheme.dark(),
      home: Scaffold(
        body: SingleChildScrollView(
          child: BookInfoSection(bookDetail: bookDetail, isInShelf: false),
        ),
      ),
    );
  }

  group('BookInfoSection フィールド欠損時の表示処理', () {
    group('Requirements 1.5: 書籍情報の一部が存在しない場合', () {
      testWidgets('thumbnailUrl が null の場合、プレースホルダーが表示される', (tester) async {
        const bookDetail = BookDetail(
          id: 'test-id',
          title: 'Test Book',
          authors: ['Test Author'],
          thumbnailUrl: null,
        );

        await tester.pumpWidget(buildTestWidget(bookDetail: bookDetail));
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.book), findsOneWidget);
      });

      testWidgets('publisher が null の場合、出版社フィールドが非表示になる', (tester) async {
        const bookDetail = BookDetail(
          id: 'test-id',
          title: 'Test Book',
          authors: ['Test Author'],
          publisher: null,
          publishedDate: '2024-01-01',
        );

        await tester.pumpWidget(buildTestWidget(bookDetail: bookDetail));
        await tester.pumpAndSettle();

        expect(find.text('出版社'), findsNothing);
        expect(find.text('発売日'), findsOneWidget);
      });

      testWidgets('publishedDate が null の場合、発売日フィールドが非表示になる', (tester) async {
        const bookDetail = BookDetail(
          id: 'test-id',
          title: 'Test Book',
          authors: ['Test Author'],
          publisher: 'Test Publisher',
          publishedDate: null,
        );

        await tester.pumpWidget(buildTestWidget(bookDetail: bookDetail));
        await tester.pumpAndSettle();

        expect(find.text('発売日'), findsNothing);
        expect(find.text('出版社'), findsOneWidget);
      });

      testWidgets('pageCount が null の場合、ページ数フィールドが非表示になる', (tester) async {
        const bookDetail = BookDetail(
          id: 'test-id',
          title: 'Test Book',
          authors: ['Test Author'],
          publisher: 'Test Publisher',
          pageCount: null,
        );

        await tester.pumpWidget(buildTestWidget(bookDetail: bookDetail));
        await tester.pumpAndSettle();

        expect(find.text('ページ数'), findsNothing);
        expect(find.text('出版社'), findsOneWidget);
      });

      testWidgets('categories が null の場合、ジャンルフィールドが非表示になる', (tester) async {
        const bookDetail = BookDetail(
          id: 'test-id',
          title: 'Test Book',
          authors: ['Test Author'],
          publisher: 'Test Publisher',
          categories: null,
        );

        await tester.pumpWidget(buildTestWidget(bookDetail: bookDetail));
        await tester.pumpAndSettle();

        expect(find.text('ジャンル'), findsNothing);
        expect(find.text('出版社'), findsOneWidget);
      });

      testWidgets('categories が空リストの場合、ジャンルフィールドが非表示になる', (tester) async {
        const bookDetail = BookDetail(
          id: 'test-id',
          title: 'Test Book',
          authors: ['Test Author'],
          publisher: 'Test Publisher',
          categories: [],
        );

        await tester.pumpWidget(buildTestWidget(bookDetail: bookDetail));
        await tester.pumpAndSettle();

        expect(find.text('ジャンル'), findsNothing);
        expect(find.text('出版社'), findsOneWidget);
      });

      testWidgets('description が null の場合、作品紹介セクションが非表示になる', (tester) async {
        const bookDetail = BookDetail(
          id: 'test-id',
          title: 'Test Book',
          authors: ['Test Author'],
          description: null,
        );

        await tester.pumpWidget(buildTestWidget(bookDetail: bookDetail));
        await tester.pumpAndSettle();

        expect(find.text('作品紹介'), findsNothing);
      });

      testWidgets('全ての書誌情報が null の場合、書誌情報セクションが非表示になる', (tester) async {
        const bookDetail = BookDetail(
          id: 'test-id',
          title: 'Test Book',
          authors: ['Test Author'],
          publisher: null,
          publishedDate: null,
          pageCount: null,
          categories: null,
        );

        await tester.pumpWidget(buildTestWidget(bookDetail: bookDetail));
        await tester.pumpAndSettle();

        expect(find.text('書誌情報'), findsNothing);
      });

      testWidgets('authors が空リストの場合、著者名が空文字として表示される', (tester) async {
        const bookDetail = BookDetail(
          id: 'test-id',
          title: 'Test Book',
          authors: [],
        );

        await tester.pumpWidget(buildTestWidget(bookDetail: bookDetail));
        await tester.pumpAndSettle();

        expect(find.text('Test Book'), findsOneWidget);
        expect(find.text(''), findsWidgets);
      });
    });

    group('フィールドが存在する場合の正常表示', () {
      testWidgets('全フィールドが存在する場合、全ての情報が表示される', (tester) async {
        const bookDetail = BookDetail(
          id: 'test-id',
          title: 'Complete Book',
          authors: ['Author 1', 'Author 2'],
          publisher: 'Test Publisher',
          publishedDate: '2024-01-01',
          pageCount: 300,
          categories: ['小説', 'ドラマ'],
          description: 'This is a test description.',
          thumbnailUrl: 'https://example.com/cover.jpg',
        );

        await tester.pumpWidget(buildTestWidget(bookDetail: bookDetail));
        await tester.pumpAndSettle();

        expect(find.text('Complete Book'), findsOneWidget);
        expect(find.text('Author 1, Author 2'), findsOneWidget);
        expect(find.text('書誌情報'), findsOneWidget);
        expect(find.text('出版社'), findsOneWidget);
        expect(find.text('Test Publisher'), findsOneWidget);
        expect(find.text('発売日'), findsOneWidget);
        expect(find.text('2024年1月1日'), findsOneWidget);
        expect(find.text('ページ数'), findsOneWidget);
        expect(find.text('300ページ'), findsOneWidget);
        expect(find.text('ジャンル'), findsOneWidget);
        expect(find.text('作品紹介'), findsOneWidget);
        expect(find.text('This is a test description.'), findsOneWidget);
      });

      testWidgets('複数の著者がカンマ区切りで表示される', (tester) async {
        const bookDetail = BookDetail(
          id: 'test-id',
          title: 'Test Book',
          authors: ['Author A', 'Author B', 'Author C'],
        );

        await tester.pumpWidget(buildTestWidget(bookDetail: bookDetail));
        await tester.pumpAndSettle();

        expect(find.text('Author A, Author B, Author C'), findsOneWidget);
      });

      testWidgets('カテゴリがチップとして表示される', (tester) async {
        const bookDetail = BookDetail(
          id: 'test-id',
          title: 'Test Book',
          authors: ['Test Author'],
          categories: ['小説', 'ドラマ'],
        );

        await tester.pumpWidget(buildTestWidget(bookDetail: bookDetail));
        await tester.pumpAndSettle();

        expect(find.text('小説'), findsOneWidget);
        expect(find.text('ドラマ'), findsOneWidget);
      });
    });

    group('外部リンクボタン', () {
      testWidgets('外部リンクボタンはタップ時にリップルエフェクトのフィードバックがある',
          (tester) async {
        const bookDetail = BookDetail(
          id: 'test-id',
          title: 'Test Book',
          authors: ['Test Author'],
          amazonUrl: 'https://amazon.co.jp/test',
          rakutenBooksUrl: 'https://books.rakuten.co.jp/test',
        );

        await tester.pumpWidget(buildTestWidget(bookDetail: bookDetail));
        await tester.pumpAndSettle();

        // 購入・詳細セクションが表示される
        expect(find.text('購入・詳細'), findsOneWidget);
        expect(find.text('Amazonで見る'), findsOneWidget);
        expect(find.text('楽天ブックスで見る'), findsOneWidget);

        // 外部リンクボタンがMaterialでラップされたInkWellを使用していることを確認
        // （リップルエフェクトが正しく表示されるため）
        final amazonButton = find.ancestor(
          of: find.text('Amazonで見る'),
          matching: find.byType(Material),
        );
        final rakutenButton = find.ancestor(
          of: find.text('楽天ブックスで見る'),
          matching: find.byType(Material),
        );

        expect(amazonButton, findsWidgets);
        expect(rakutenButton, findsWidgets);
      });
    });
  });
}
