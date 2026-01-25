import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/app/app.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/core/widgets/error_view.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_repository.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/book_card.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/book_grid.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/search_filter_bar.dart';

class MockBookShelfRepository extends Mock implements BookShelfRepository {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockBookShelfRepository mockRepository;

  final now = DateTime(2024, 1, 15, 10, 30);

  ShelfBookItem createBook({
    int userBookId = 1,
    String externalId = 'id',
    String title = 'Title',
    List<String> authors = const ['Author'],
    ReadingStatus readingStatus = ReadingStatus.backlog,
    DateTime? addedAt,
  }) {
    return ShelfBookItem(
      userBookId: userBookId,
      externalId: externalId,
      title: title,
      authors: authors,
      readingStatus: readingStatus,
      addedAt: addedAt ?? now,
    );
  }

  MyShelfResult createMyShelfResult({
    List<ShelfBookItem>? items,
    int totalCount = 1,
    bool hasMore = false,
  }) {
    return MyShelfResult(
      items: items ?? [createBook()],
      totalCount: totalCount,
      hasMore: hasMore,
    );
  }

  setUp(() {
    mockRepository = MockBookShelfRepository();
  });

  group('Book Shelf Integration Tests', () {
    group('Search Flow', () {
      testWidgets(
        'search query filters books from server',
        (tester) async {
          final books = [
            createBook(userBookId: 1, externalId: 'id1', title: 'Flutter Guide'),
            createBook(userBookId: 2, externalId: 'id2', title: 'Dart Handbook'),
          ];

          when(
            () => mockRepository.getMyShelf(
              query: any(named: 'query'),
              sortBy: any(named: 'sortBy'),
              sortOrder: any(named: 'sortOrder'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).thenAnswer(
            (_) async => right(
              createMyShelfResult(items: books, totalCount: 2),
            ),
          );

          when(
            () => mockRepository.getMyShelf(
              query: 'Flutter',
              sortBy: any(named: 'sortBy'),
              sortOrder: any(named: 'sortOrder'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).thenAnswer(
            (_) async => right(
              createMyShelfResult(
                items: [books[0]],
                totalCount: 1,
              ),
            ),
          );

          final container = ProviderContainer(
            overrides: [
              bookShelfRepositoryProvider.overrideWithValue(mockRepository),
            ],
          );
          addTearDown(container.dispose);

          await container.read(authStateProvider.notifier).login(
                userId: 'test-user',
                email: 'test@example.com',
                token: 'test-token',
                refreshToken: 'test-refresh-token',
              );

          await tester.pumpWidget(
            ProviderScope(
              parent: container,
              child: const ShelfieApp(),
            ),
          );

          await tester.pumpAndSettle();

          expect(find.byType(SearchFilterBar), findsOneWidget);

          final searchField = find.byType(TextField);
          await tester.enterText(searchField, 'Flutter');
          await tester.pump(const Duration(milliseconds: 350));
          await tester.pumpAndSettle();

          verify(
            () => mockRepository.getMyShelf(
              query: 'Flutter',
              sortBy: any(named: 'sortBy'),
              sortOrder: any(named: 'sortOrder'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).called(1);
        },
      );
    });

    group('Sort Flow', () {
      testWidgets(
        'sort option change refetches data from server',
        (tester) async {
          final books = [
            createBook(userBookId: 1, externalId: 'id1', title: 'Book A'),
            createBook(userBookId: 2, externalId: 'id2', title: 'Book B'),
          ];

          when(
            () => mockRepository.getMyShelf(
              query: any(named: 'query'),
              sortBy: any(named: 'sortBy'),
              sortOrder: any(named: 'sortOrder'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).thenAnswer(
            (_) async => right(
              createMyShelfResult(items: books, totalCount: 2),
            ),
          );

          when(
            () => mockRepository.getMyShelf(
              query: any(named: 'query'),
              sortBy: GShelfSortField.TITLE,
              sortOrder: GSortOrder.ASC,
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).thenAnswer(
            (_) async => right(
              createMyShelfResult(items: books, totalCount: 2),
            ),
          );

          final container = ProviderContainer(
            overrides: [
              bookShelfRepositoryProvider.overrideWithValue(mockRepository),
            ],
          );
          addTearDown(container.dispose);

          await container.read(authStateProvider.notifier).login(
                userId: 'test-user',
                email: 'test@example.com',
                token: 'test-token',
                refreshToken: 'test-refresh-token',
              );

          await tester.pumpWidget(
            ProviderScope(
              parent: container,
              child: const ShelfieApp(),
            ),
          );

          await tester.pumpAndSettle();

          final sortDropdown = find.byType(DropdownButton<SortOption>);
          await tester.tap(sortDropdown);
          await tester.pumpAndSettle();

          final titleOption = find.text('タイトル（A→Z）').last;
          await tester.tap(titleOption);
          await tester.pumpAndSettle();

          verify(
            () => mockRepository.getMyShelf(
              query: any(named: 'query'),
              sortBy: GShelfSortField.TITLE,
              sortOrder: GSortOrder.ASC,
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).called(1);
        },
      );
    });

    group('Infinite Scroll Flow', () {
      testWidgets(
        'scrolling to bottom loads more items',
        (tester) async {
          final initialBooks = List.generate(
            20,
            (i) => createBook(
              userBookId: i + 1,
              externalId: 'id-$i',
              title: 'Book $i',
            ),
          );

          final moreBooks = List.generate(
            10,
            (i) => createBook(
              userBookId: i + 21,
              externalId: 'id-${i + 20}',
              title: 'Book ${i + 20}',
            ),
          );

          when(
            () => mockRepository.getMyShelf(
              query: any(named: 'query'),
              sortBy: any(named: 'sortBy'),
              sortOrder: any(named: 'sortOrder'),
              limit: any(named: 'limit'),
              offset: 0,
            ),
          ).thenAnswer(
            (_) async => right(
              MyShelfResult(
                items: initialBooks,
                totalCount: 30,
                hasMore: true,
              ),
            ),
          );

          when(
            () => mockRepository.getMyShelf(
              query: any(named: 'query'),
              sortBy: any(named: 'sortBy'),
              sortOrder: any(named: 'sortOrder'),
              limit: any(named: 'limit'),
              offset: 20,
            ),
          ).thenAnswer(
            (_) async => right(
              MyShelfResult(
                items: moreBooks,
                totalCount: 30,
                hasMore: false,
              ),
            ),
          );

          final container = ProviderContainer(
            overrides: [
              bookShelfRepositoryProvider.overrideWithValue(mockRepository),
            ],
          );
          addTearDown(container.dispose);

          await container.read(authStateProvider.notifier).login(
                userId: 'test-user',
                email: 'test@example.com',
                token: 'test-token',
                refreshToken: 'test-refresh-token',
              );

          await tester.pumpWidget(
            ProviderScope(
              parent: container,
              child: const ShelfieApp(),
            ),
          );

          await tester.pumpAndSettle();

          expect(find.byType(BookGrid), findsOneWidget);

          await tester.drag(
            find.byType(CustomScrollView),
            const Offset(0, -10000),
          );
          await tester.pumpAndSettle();

          verify(
            () => mockRepository.getMyShelf(
              query: any(named: 'query'),
              sortBy: any(named: 'sortBy'),
              sortOrder: any(named: 'sortOrder'),
              limit: any(named: 'limit'),
              offset: 20,
            ),
          ).called(1);
        },
      );
    });

    group('Book Detail Navigation', () {
      testWidgets(
        'tapping book card navigates to detail screen',
        (tester) async {
          final books = [
            createBook(
              userBookId: 1,
              externalId: 'test-book-id',
              title: 'Test Book',
            ),
          ];

          when(
            () => mockRepository.getMyShelf(
              query: any(named: 'query'),
              sortBy: any(named: 'sortBy'),
              sortOrder: any(named: 'sortOrder'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).thenAnswer(
            (_) async => right(
              createMyShelfResult(items: books, totalCount: 1),
            ),
          );

          final container = ProviderContainer(
            overrides: [
              bookShelfRepositoryProvider.overrideWithValue(mockRepository),
            ],
          );
          addTearDown(container.dispose);

          await container.read(authStateProvider.notifier).login(
                userId: 'test-user',
                email: 'test@example.com',
                token: 'test-token',
                refreshToken: 'test-refresh-token',
              );

          await tester.pumpWidget(
            ProviderScope(
              parent: container,
              child: const ShelfieApp(),
            ),
          );

          await tester.pumpAndSettle();

          final bookCard = find.byType(BookCard);
          expect(bookCard, findsOneWidget);

          await tester.tap(bookCard);
          await tester.pumpAndSettle();

          expect(find.textContaining('test-book-id'), findsWidgets);
        },
      );
    });

    group('Error Recovery Flow', () {
      testWidgets(
        'error state shows retry button and recovers on retry',
        (tester) async {
          var callCount = 0;

          when(
            () => mockRepository.getMyShelf(
              query: any(named: 'query'),
              sortBy: any(named: 'sortBy'),
              sortOrder: any(named: 'sortOrder'),
              limit: any(named: 'limit'),
              offset: any(named: 'offset'),
            ),
          ).thenAnswer((_) async {
            callCount++;
            if (callCount == 1) {
              return left(const NetworkFailure(message: 'Network error'));
            }
            return right(
              createMyShelfResult(
                items: [createBook()],
                totalCount: 1,
              ),
            );
          });

          final container = ProviderContainer(
            overrides: [
              bookShelfRepositoryProvider.overrideWithValue(mockRepository),
            ],
          );
          addTearDown(container.dispose);

          await container.read(authStateProvider.notifier).login(
                userId: 'test-user',
                email: 'test@example.com',
                token: 'test-token',
                refreshToken: 'test-refresh-token',
              );

          await tester.pumpWidget(
            ProviderScope(
              parent: container,
              child: const ShelfieApp(),
            ),
          );

          await tester.pumpAndSettle();

          expect(find.byType(ErrorView), findsOneWidget);
          expect(find.textContaining('ネットワーク'), findsOneWidget);

          final retryButton = find.widgetWithText(ElevatedButton, 'リトライ');
          expect(retryButton, findsOneWidget);

          await tester.tap(retryButton);
          await tester.pumpAndSettle();

          expect(find.byType(BookGrid), findsOneWidget);
          expect(find.byType(BookCard), findsOneWidget);
        },
      );
    });
  });
}
