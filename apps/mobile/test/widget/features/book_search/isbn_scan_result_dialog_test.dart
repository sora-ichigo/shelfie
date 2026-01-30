import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart';
import 'package:shelfie/features/book_search/presentation/widgets/isbn_scan_result_dialog.dart';

class MockBookSearchRepository extends Mock implements BookSearchRepository {}

void main() {
  late MockBookSearchRepository mockRepository;

  setUp(() {
    mockRepository = MockBookSearchRepository();
  });

  Widget buildTestWidget({
    required String isbn,
    required BookSearchRepository repository,
  }) {
    return ProviderScope(
      overrides: [
        bookSearchRepositoryProvider.overrideWithValue(repository),
      ],
      child: MaterialApp(
        theme: ThemeData(
          extensions: const [AppColors.dark],
        ),
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ISBNScanResultDialog(
                isbn: isbn,
              );
            },
          ),
        ),
      ),
    );
  }

  group('ISBNScanResultDialog', () {
    testWidgets('displays loading indicator while searching', (tester) async {
      final completer = Completer<Either<Failure, Book?>>();

      when(() => mockRepository.searchBookByISBN(isbn: any(named: 'isbn')))
          .thenAnswer((_) => completer.future);

      await tester.pumpWidget(buildTestWidget(
        isbn: '9784873115658',
        repository: mockRepository,
      ));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      completer.complete(right(null));
      await tester.pumpAndSettle();
    });

    testWidgets('displays book details when found', (tester) async {
      final testBook = Book(
        id: 'test-id',
        title: 'テスト書籍',
        authors: ['著者A', '著者B'],
        publisher: 'テスト出版社',
        publishedDate: '2024',
        isbn: '9784873115658',
        coverImageUrl: null,
      );

      when(() => mockRepository.searchBookByISBN(isbn: any(named: 'isbn')))
          .thenAnswer((_) async => right(testBook));

      await tester.pumpWidget(buildTestWidget(
        isbn: '9784873115658',
        repository: mockRepository,
      ));

      await tester.pumpAndSettle();

      expect(find.text('テスト書籍'), findsOneWidget);
      expect(find.text('著者A, 著者B'), findsOneWidget);
      expect(find.text('登録'), findsOneWidget);
    });

    testWidgets('displays not found message when book is not found',
        (tester) async {
      when(() => mockRepository.searchBookByISBN(isbn: any(named: 'isbn')))
          .thenAnswer((_) async => right(null));

      await tester.pumpWidget(buildTestWidget(
        isbn: '9784873115658',
        repository: mockRepository,
      ));

      await tester.pumpAndSettle();

      expect(find.text('書籍が見つかりませんでした'), findsOneWidget);
    });

    testWidgets('displays error message on failure', (tester) async {
      when(() => mockRepository.searchBookByISBN(isbn: any(named: 'isbn')))
          .thenAnswer(
        (_) async => left(
          const NetworkFailure(message: 'Network error'),
        ),
      );

      await tester.pumpWidget(buildTestWidget(
        isbn: '9784873115658',
        repository: mockRepository,
      ));

      await tester.pumpAndSettle();

      expect(find.text('検索中にエラーが発生しました'), findsOneWidget);
      expect(find.text('再試行'), findsOneWidget);
    });

    testWidgets('shows register button when book is found', (tester) async {
      final testBook = Book(
        id: 'test-id',
        title: 'テスト書籍',
        authors: ['著者A'],
        publisher: null,
        publishedDate: null,
        isbn: '9784873115658',
        coverImageUrl: null,
      );

      when(() => mockRepository.searchBookByISBN(isbn: any(named: 'isbn')))
          .thenAnswer((_) async => right(testBook));

      await tester.pumpWidget(buildTestWidget(
        isbn: '9784873115658',
        repository: mockRepository,
      ));

      await tester.pumpAndSettle();

      expect(find.widgetWithText(ElevatedButton, '登録'), findsOneWidget);
    });

    testWidgets('can close dialog with cancel button', (tester) async {
      final testBook = Book(
        id: 'test-id',
        title: 'テスト書籍',
        authors: ['著者A'],
        publisher: null,
        publishedDate: null,
        isbn: '9784873115658',
        coverImageUrl: null,
      );

      when(() => mockRepository.searchBookByISBN(isbn: any(named: 'isbn')))
          .thenAnswer((_) async => right(testBook));

      await tester.pumpWidget(buildTestWidget(
        isbn: '9784873115658',
        repository: mockRepository,
      ));

      await tester.pumpAndSettle();

      expect(find.widgetWithText(ElevatedButton, 'キャンセル'), findsOneWidget);
    });
  });
}
