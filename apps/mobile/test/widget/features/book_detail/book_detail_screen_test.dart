import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_detail/data/book_detail_repository.dart';
import 'package:shelfie/features/book_detail/domain/book_detail.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_detail/domain/user_book.dart';
import 'package:shelfie/features/book_detail/presentation/book_detail_screen.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart'
    as book_search;

class MockBookDetailRepository extends Mock implements BookDetailRepository {}

class MockBookSearchRepository extends Mock
    implements book_search.BookSearchRepository {}

void main() {
  late MockBookDetailRepository mockRepository;
  late MockBookSearchRepository mockBookSearchRepository;

  setUp(() {
    mockRepository = MockBookDetailRepository();
    mockBookSearchRepository = MockBookSearchRepository();
  });

  Widget buildTestWidget({
    required String bookId,
    BookDetail? bookDetail,
    Failure? failure,
    bool isLoading = false,
  }) {
    return ProviderScope(
      overrides: [
        bookDetailRepositoryProvider.overrideWithValue(mockRepository),
        book_search.bookSearchRepositoryProvider
            .overrideWithValue(mockBookSearchRepository),
      ],
      child: MaterialApp(
        theme: AppTheme.dark(),
        home: BookDetailScreen(bookId: bookId),
      ),
    );
  }

  group('BookDetailScreen 基本構造', () {
    testWidgets('Scaffold が適用されている', (tester) async {
      when(() => mockRepository.getBookDetail(bookId: any(named: 'bookId')))
          .thenAnswer((_) async => right((
                bookDetail: const BookDetail(
                  id: 'test-id',
                  title: 'Test Book',
                  authors: ['Test Author'],
                ),
                userBook: null,
              )));

      await tester.pumpWidget(buildTestWidget(bookId: 'test-id'));

      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('AppBar に戻るボタンが表示される', (tester) async {
      when(() => mockRepository.getBookDetail(bookId: any(named: 'bookId')))
          .thenAnswer((_) async => right((
                bookDetail: const BookDetail(
                  id: 'test-id',
                  title: 'Test Book',
                  authors: ['Test Author'],
                ),
                userBook: null,
              )));

      await tester.pumpWidget(buildTestWidget(bookId: 'test-id'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);
    });

    testWidgets('AppBar に共有ボタンが表示される', (tester) async {
      when(() => mockRepository.getBookDetail(bookId: any(named: 'bookId')))
          .thenAnswer((_) async => right((
                bookDetail: const BookDetail(
                  id: 'test-id',
                  title: 'Test Book',
                  authors: ['Test Author'],
                ),
                userBook: null,
              )));

      await tester.pumpWidget(buildTestWidget(bookId: 'test-id'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.share), findsOneWidget);
    });
  });

  group('BookDetailScreen ローディング状態', () {
    testWidgets('ローディング中はインジケータが表示される', (tester) async {
      final completer = Completer<Either<Failure, BookDetailResponse>>();
      when(() => mockRepository.getBookDetail(bookId: any(named: 'bookId')))
          .thenAnswer((_) => completer.future);

      await tester.pumpWidget(buildTestWidget(bookId: 'test-id'));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      completer.complete(right((
        bookDetail: const BookDetail(
          id: 'test-id',
          title: 'Test Book',
          authors: ['Test Author'],
        ),
        userBook: null,
      )));
      await tester.pumpAndSettle();
    });
  });

  group('BookDetailScreen エラー状態', () {
    testWidgets('エラー時はエラーメッセージとリトライボタンが表示される',
        (tester) async {
      when(() => mockRepository.getBookDetail(bookId: any(named: 'bookId')))
          .thenAnswer(
        (_) async => left(const NetworkFailure(message: 'Network error')),
      );

      await tester.pumpWidget(buildTestWidget(bookId: 'test-id'));
      await tester.pumpAndSettle();

      expect(find.text('ネットワーク接続を確認してください'), findsOneWidget);
      expect(find.text('再試行'), findsOneWidget);
    });

    testWidgets('リトライボタンをタップすると再取得される', (tester) async {
      var callCount = 0;
      when(() => mockRepository.getBookDetail(bookId: any(named: 'bookId')))
          .thenAnswer((_) async {
        callCount++;
        if (callCount == 1) {
          return left(const NetworkFailure(message: 'Network error'));
        }
        return right((
          bookDetail: const BookDetail(
            id: 'test-id',
            title: 'Test Book',
            authors: ['Test Author'],
          ),
          userBook: null,
        ));
      });

      await tester.pumpWidget(buildTestWidget(bookId: 'test-id'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('再試行'));
      await tester.pumpAndSettle();

      expect(callCount, 2);
    });
  });

  group('BookDetailScreen データ表示', () {
    testWidgets('書籍情報が正しく表示される', (tester) async {
      when(() => mockRepository.getBookDetail(bookId: any(named: 'bookId')))
          .thenAnswer((_) async => right((
                bookDetail: const BookDetail(
                  id: 'test-id',
                  title: 'Test Book Title',
                  authors: ['Author 1', 'Author 2'],
                  publisher: 'Test Publisher',
                  publishedDate: '2024-01-01',
                  pageCount: 300,
                  categories: ['Fiction', 'Thriller'],
                  description: 'This is a test description.',
                ),
                userBook: null,
              )));

      await tester.pumpWidget(buildTestWidget(bookId: 'test-id'));
      await tester.pumpAndSettle();

      expect(find.text('Test Book Title'), findsOneWidget);
      expect(find.text('Author 1, Author 2'), findsOneWidget);
    });
  });

  group('BookDetailScreen 本棚追加状態', () {
    testWidgets('未追加時は「本棚に追加」ボタンが表示される', (tester) async {
      when(() => mockRepository.getBookDetail(bookId: any(named: 'bookId')))
          .thenAnswer((_) async => right((
                bookDetail: const BookDetail(
                  id: 'test-id',
                  title: 'Test Book',
                  authors: ['Test Author'],
                ),
                userBook: null,
              )));

      await tester.pumpWidget(buildTestWidget(bookId: 'test-id'));
      await tester.pumpAndSettle();

      expect(find.text('本棚に追加'), findsOneWidget);
    });

    testWidgets('追加済み時は読書記録セクションが表示される', (tester) async {
      final userBook = UserBook(
        id: 1,
        readingStatus: ReadingStatus.backlog,
        addedAt: DateTime(2024, 1, 1),
      );
      when(() => mockRepository.getBookDetail(bookId: any(named: 'bookId')))
          .thenAnswer((_) async => right((
                bookDetail: const BookDetail(
                  id: 'test-id',
                  title: 'Test Book',
                  authors: ['Test Author'],
                ),
                userBook: userBook,
              )));

      await tester.pumpWidget(buildTestWidget(bookId: 'test-id'));
      await tester.pumpAndSettle();

      expect(find.text('積読'), findsOneWidget);
      expect(find.text('本棚に追加'), findsNothing);
    });
  });

  group('BookDetailScreen 本棚操作ローディング', () {
    testWidgets('本棚追加中はボタンにローディングインジケーターが表示される',
        (tester) async {
      when(() => mockRepository.getBookDetail(bookId: any(named: 'bookId')))
          .thenAnswer((_) async => right((
                bookDetail: const BookDetail(
                  id: 'test-id',
                  title: 'Test Book',
                  authors: ['Test Author'],
                ),
                userBook: null,
              )));

      final addCompleter = Completer<Either<Failure, book_search.UserBook>>();
      when(() => mockBookSearchRepository.addBookToShelf(
            externalId: any(named: 'externalId'),
            title: any(named: 'title'),
            authors: any(named: 'authors'),
            publisher: any(named: 'publisher'),
            publishedDate: any(named: 'publishedDate'),
            isbn: any(named: 'isbn'),
            coverImageUrl: any(named: 'coverImageUrl'),
          )).thenAnswer((_) => addCompleter.future);

      await tester.pumpWidget(buildTestWidget(bookId: 'test-id'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('本棚に追加'));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('本棚に追加'), findsNothing);

      addCompleter.complete(right(book_search.UserBook(
        id: 1,
        externalId: 'test-id',
        title: 'Test Book',
        authors: ['Test Author'],
        addedAt: DateTime.now(),
      )));
      await tester.pumpAndSettle();
    });

    testWidgets('本棚削除中はボタンにローディングインジケーターが表示される',
        (tester) async {
      final userBook = UserBook(
        id: 1,
        readingStatus: ReadingStatus.backlog,
        addedAt: DateTime(2024, 1, 1),
      );
      when(() => mockRepository.getBookDetail(bookId: any(named: 'bookId')))
          .thenAnswer((_) async => right((
                bookDetail: const BookDetail(
                  id: 'test-id',
                  title: 'Test Book',
                  authors: ['Test Author'],
                ),
                userBook: userBook,
              )));

      final removeCompleter = Completer<Either<Failure, bool>>();
      when(() => mockBookSearchRepository.removeFromShelf(
            userBookId: any(named: 'userBookId'),
          )).thenAnswer((_) => removeCompleter.future);

      await tester.pumpWidget(buildTestWidget(bookId: 'test-id'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('本棚から削除'));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('本棚から削除'), findsNothing);

      removeCompleter.complete(right(true));
      await tester.pumpAndSettle();
    });

    testWidgets('本棚追加完了後はローディングが消えてボタンが更新される',
        (tester) async {
      when(() => mockRepository.getBookDetail(bookId: any(named: 'bookId')))
          .thenAnswer((_) async => right((
                bookDetail: const BookDetail(
                  id: 'test-id',
                  title: 'Test Book',
                  authors: ['Test Author'],
                ),
                userBook: null,
              )));

      when(() => mockBookSearchRepository.addBookToShelf(
            externalId: any(named: 'externalId'),
            title: any(named: 'title'),
            authors: any(named: 'authors'),
            publisher: any(named: 'publisher'),
            publishedDate: any(named: 'publishedDate'),
            isbn: any(named: 'isbn'),
            coverImageUrl: any(named: 'coverImageUrl'),
          )).thenAnswer((_) async => right(book_search.UserBook(
            id: 1,
            externalId: 'test-id',
            title: 'Test Book',
            authors: ['Test Author'],
            addedAt: DateTime.now(),
          )));

      await tester.pumpWidget(buildTestWidget(bookId: 'test-id'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('本棚に追加'));
      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('本棚から削除'), findsOneWidget);
    });
  });
}
