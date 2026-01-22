import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart';
import 'package:shelfie/features/book_search/presentation/widgets/book_list_item.dart';

void main() {
  Widget buildBookListItem({
    required Book book,
    VoidCallback? onAddPressed,
    bool isAddingToShelf = false,
  }) {
    return MaterialApp(
      theme: AppTheme.dark(),
      home: Scaffold(
        body: BookListItem(
          book: book,
          onAddPressed: onAddPressed ?? () {},
          isAddingToShelf: isAddingToShelf,
        ),
      ),
    );
  }

  group('BookListItem', () {
    const testBook = Book(
      id: '1',
      title: 'テスト本のタイトル',
      authors: ['著者A', '著者B'],
      publisher: '出版社X',
      publishedDate: '2024',
      isbn: '9784000000001',
      coverImageUrl: 'https://example.com/cover.jpg',
    );

    testWidgets('タイトルが表示される', (tester) async {
      await tester.pumpWidget(buildBookListItem(book: testBook));

      expect(find.text('テスト本のタイトル'), findsOneWidget);
    });

    testWidgets('著者名がカンマ区切りで表示される', (tester) async {
      await tester.pumpWidget(buildBookListItem(book: testBook));

      expect(find.text('著者A, 著者B'), findsOneWidget);
    });

    testWidgets('出版社と出版年が表示される', (tester) async {
      await tester.pumpWidget(buildBookListItem(book: testBook));

      expect(find.text('出版社X / 2024'), findsOneWidget);
    });

    testWidgets('追加ボタンが表示される', (tester) async {
      await tester.pumpWidget(buildBookListItem(book: testBook));

      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('追加ボタンをタップするとコールバックが呼ばれる', (tester) async {
      var addPressed = false;

      await tester.pumpWidget(
        buildBookListItem(
          book: testBook,
          onAddPressed: () => addPressed = true,
        ),
      );

      await tester.tap(find.byIcon(Icons.add));

      expect(addPressed, isTrue);
    });

    testWidgets('追加中はローディングインジケーターが表示される', (tester) async {
      await tester.pumpWidget(
        buildBookListItem(
          book: testBook,
          isAddingToShelf: true,
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byIcon(Icons.add), findsNothing);
    });

    testWidgets('出版社がない場合は出版年のみ表示される', (tester) async {
      const bookWithoutPublisher = Book(
        id: '2',
        title: 'タイトル',
        authors: ['著者'],
        publishedDate: '2024',
      );

      await tester.pumpWidget(buildBookListItem(book: bookWithoutPublisher));

      expect(find.text('2024'), findsOneWidget);
    });

    testWidgets('出版年がない場合は出版社のみ表示される', (tester) async {
      const bookWithoutDate = Book(
        id: '3',
        title: 'タイトル',
        authors: ['著者'],
        publisher: '出版社Y',
      );

      await tester.pumpWidget(buildBookListItem(book: bookWithoutDate));

      expect(find.text('出版社Y'), findsOneWidget);
    });

    testWidgets('出版社と出版年がない場合は非表示', (tester) async {
      const bookWithoutInfo = Book(
        id: '4',
        title: 'タイトル',
        authors: ['著者'],
      );

      await tester.pumpWidget(buildBookListItem(book: bookWithoutInfo));

      expect(find.text('/'), findsNothing);
    });

    testWidgets('著者がいない場合は「著者不明」と表示される', (tester) async {
      const bookWithoutAuthors = Book(
        id: '5',
        title: 'タイトル',
        authors: [],
      );

      await tester.pumpWidget(buildBookListItem(book: bookWithoutAuthors));

      expect(find.text('著者不明'), findsOneWidget);
    });

    testWidgets('カバー画像がない場合はプレースホルダーが表示される', (tester) async {
      const bookWithoutCover = Book(
        id: '6',
        title: 'タイトル',
        authors: ['著者'],
        coverImageUrl: null,
      );

      await tester.pumpWidget(buildBookListItem(book: bookWithoutCover));

      expect(find.byIcon(Icons.book), findsOneWidget);
    });
  });
}
