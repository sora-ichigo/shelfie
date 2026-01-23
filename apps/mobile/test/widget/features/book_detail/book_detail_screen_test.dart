import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_detail/application/book_detail_notifier.dart';
import 'package:shelfie/features/book_detail/data/book_detail_repository.dart';
import 'package:shelfie/features/book_detail/domain/book_detail.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_detail/domain/user_book.dart';
import 'package:shelfie/features/book_detail/presentation/book_detail_screen.dart';

class MockBookDetailRepository extends Mock implements BookDetailRepository {}

void main() {
  late MockBookDetailRepository mockRepository;

  setUp(() {
    mockRepository = MockBookDetailRepository();
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
          .thenAnswer((_) async => right(
                const BookDetail(
                  id: 'test-id',
                  title: 'Test Book',
                  authors: ['Test Author'],
                ),
              ));

      await tester.pumpWidget(buildTestWidget(bookId: 'test-id'));

      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('AppBar に閉じるボタン(x)が表示される', (tester) async {
      when(() => mockRepository.getBookDetail(bookId: any(named: 'bookId')))
          .thenAnswer((_) async => right(
                const BookDetail(
                  id: 'test-id',
                  title: 'Test Book',
                  authors: ['Test Author'],
                ),
              ));

      await tester.pumpWidget(buildTestWidget(bookId: 'test-id'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('AppBar に共有ボタンが表示される', (tester) async {
      when(() => mockRepository.getBookDetail(bookId: any(named: 'bookId')))
          .thenAnswer((_) async => right(
                const BookDetail(
                  id: 'test-id',
                  title: 'Test Book',
                  authors: ['Test Author'],
                ),
              ));

      await tester.pumpWidget(buildTestWidget(bookId: 'test-id'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.share), findsOneWidget);
    });
  });

  group('BookDetailScreen ローディング状態', () {
    testWidgets('ローディング中はインジケータが表示される', (tester) async {
      final completer = Completer<Either<Failure, BookDetail>>();
      when(() => mockRepository.getBookDetail(bookId: any(named: 'bookId')))
          .thenAnswer((_) => completer.future);

      await tester.pumpWidget(buildTestWidget(bookId: 'test-id'));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      completer.complete(right(
        const BookDetail(
          id: 'test-id',
          title: 'Test Book',
          authors: ['Test Author'],
        ),
      ));
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
        return right(
          const BookDetail(
            id: 'test-id',
            title: 'Test Book',
            authors: ['Test Author'],
          ),
        );
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
          .thenAnswer((_) async => right(
                const BookDetail(
                  id: 'test-id',
                  title: 'Test Book Title',
                  authors: ['Author 1', 'Author 2'],
                  publisher: 'Test Publisher',
                  publishedDate: '2024-01-01',
                  pageCount: 300,
                  categories: ['Fiction', 'Thriller'],
                  description: 'This is a test description.',
                ),
              ));

      await tester.pumpWidget(buildTestWidget(bookId: 'test-id'));
      await tester.pumpAndSettle();

      expect(find.text('Test Book Title'), findsOneWidget);
      expect(find.text('Author 1, Author 2'), findsOneWidget);
    });
  });

  group('BookDetailScreen 本棚追加状態', () {
    testWidgets('未追加時は「本棚に追加」ボタンが表示される', (tester) async {
      when(() => mockRepository.getBookDetail(bookId: any(named: 'bookId')))
          .thenAnswer((_) async => right(
                const BookDetail(
                  id: 'test-id',
                  title: 'Test Book',
                  authors: ['Test Author'],
                  userBook: null,
                ),
              ));

      await tester.pumpWidget(buildTestWidget(bookId: 'test-id'));
      await tester.pumpAndSettle();

      expect(find.text('本棚に追加'), findsOneWidget);
    });

    testWidgets('追加済み時は読書記録セクションが表示される', (tester) async {
      when(() => mockRepository.getBookDetail(bookId: any(named: 'bookId')))
          .thenAnswer((_) async => right(
                BookDetail(
                  id: 'test-id',
                  title: 'Test Book',
                  authors: ['Test Author'],
                  userBook: UserBook(
                    id: 1,
                    readingStatus: ReadingStatus.backlog,
                    addedAt: DateTime(2024, 1, 1),
                  ),
                ),
              ));

      await tester.pumpWidget(buildTestWidget(bookId: 'test-id'));
      await tester.pumpAndSettle();

      expect(find.text('積読'), findsOneWidget);
      expect(find.text('本棚に追加'), findsNothing);
    });
  });
}
