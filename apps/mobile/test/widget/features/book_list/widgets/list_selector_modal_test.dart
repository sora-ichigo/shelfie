import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_list/data/book_list_repository.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_list/presentation/widgets/list_selector_modal.dart';

class MockBookListRepository extends Mock implements BookListRepository {}

void main() {
  late MockBookListRepository mockRepository;
  final now = DateTime(2024, 1, 15, 10, 30);

  BookListSummary createSummary({
    int id = 1,
    String title = 'Test List',
    String? description,
    int bookCount = 3,
    List<String> coverImages = const [],
  }) {
    return BookListSummary(
      id: id,
      title: title,
      description: description,
      bookCount: bookCount,
      coverImages: coverImages,
      createdAt: now,
      updatedAt: now,
    );
  }

  MyBookListsResult createMyBookListsResult({
    List<BookListSummary>? items,
    int totalCount = 1,
    bool hasMore = false,
  }) {
    return MyBookListsResult(
      items: items ?? [createSummary()],
      totalCount: totalCount,
      hasMore: hasMore,
    );
  }

  setUp(() {
    mockRepository = MockBookListRepository();
    when(() => mockRepository.getListIdsContainingUserBook(
          userBookId: any(named: 'userBookId'),
        )).thenAnswer((_) async => right(<int>[]));
  });

  Widget buildTestWidget({
    required int userBookId,
    List<BookListSummary>? lists,
    List<int> addedListIds = const [],
  }) {
    if (lists != null) {
      when(() => mockRepository.getMyBookLists()).thenAnswer(
        (_) async => right(createMyBookListsResult(items: lists)),
      );
    }

    if (addedListIds.isNotEmpty) {
      when(() => mockRepository.getListIdsContainingUserBook(
            userBookId: any(named: 'userBookId'),
          )).thenAnswer((_) async => right(addedListIds));
    }

    return ProviderScope(
      overrides: [
        bookListRepositoryProvider.overrideWithValue(mockRepository),
      ],
      child: MaterialApp(
        theme: AppTheme.dark(),
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                showListSelectorModal(
                  context: context,
                  userBookId: userBookId,
                );
              },
              child: const Text('Show Modal'),
            ),
          ),
        ),
      ),
    );
  }

  group('ListSelectorModal', () {
    group('structure', () {
      testWidgets('displays modal title', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          userBookId: 1,
          lists: [createSummary()],
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        expect(find.text('リストに追加'), findsOneWidget);
      });

      testWidgets('displays create new list button', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          userBookId: 1,
          lists: [createSummary()],
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        expect(find.text('新しいリストを作成'), findsOneWidget);
      });
    });

    group('list display', () {
      testWidgets('displays available lists', (tester) async {
        final lists = [
          createSummary(id: 1, title: 'Favorites'),
          createSummary(id: 2, title: 'To Read'),
        ];

        await tester.pumpWidget(buildTestWidget(
          userBookId: 1,
          lists: lists,
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        expect(find.text('Favorites'), findsOneWidget);
        expect(find.text('To Read'), findsOneWidget);
      });

      testWidgets('displays book count for each list', (tester) async {
        final lists = [
          createSummary(id: 1, title: 'My List', bookCount: 5),
        ];

        await tester.pumpWidget(buildTestWidget(
          userBookId: 1,
          lists: lists,
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        expect(find.textContaining('5冊'), findsOneWidget);
      });

      testWidgets('displays empty state when no lists', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          userBookId: 1,
          lists: [],
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        expect(find.textContaining('リストがありません'), findsOneWidget);
      });
    });

    group('loading state', () {
      testWidgets('displays loading indicator while loading', (tester) async {
        when(() => mockRepository.getMyBookLists()).thenAnswer((_) async {
          await Future<void>.delayed(const Duration(milliseconds: 500));
          return right(createMyBookListsResult());
        });

        await tester.pumpWidget(buildTestWidget(
          userBookId: 1,
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        await tester.pumpAndSettle();
      });
    });

    group('add to list', () {
      testWidgets('calls addBookToList when list is tapped', (tester) async {
        final lists = [createSummary(id: 10, title: 'My List')];

        when(() => mockRepository.addBookToList(
              listId: 10,
              userBookId: 1,
            )).thenAnswer(
          (_) async => right(BookListItem(
            id: 1,
            position: 0,
            addedAt: now,
          )),
        );

        await tester.pumpWidget(buildTestWidget(
          userBookId: 1,
          lists: lists,
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('My List'));
        await tester.pumpAndSettle();

        verify(() => mockRepository.addBookToList(
              listId: 10,
              userBookId: 1,
            )).called(1);
      });

      testWidgets('stays open after adding to list', (tester) async {
        final lists = [createSummary(id: 10, title: 'My List')];

        when(() => mockRepository.addBookToList(
              listId: 10,
              userBookId: 1,
            )).thenAnswer(
          (_) async => right(BookListItem(
            id: 1,
            position: 0,
            addedAt: now,
          )),
        );

        await tester.pumpWidget(buildTestWidget(
          userBookId: 1,
          lists: lists,
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        expect(find.text('リストに追加'), findsOneWidget);

        await tester.tap(find.text('My List'));
        await tester.pumpAndSettle();

        expect(find.text('リストに追加'), findsOneWidget);
      });

      testWidgets('shows success snackbar after adding', (tester) async {
        final lists = [createSummary(id: 10, title: 'My List')];

        when(() => mockRepository.addBookToList(
              listId: 10,
              userBookId: 1,
            )).thenAnswer(
          (_) async => right(BookListItem(
            id: 1,
            position: 0,
            addedAt: now,
          )),
        );

        await tester.pumpWidget(buildTestWidget(
          userBookId: 1,
          lists: lists,
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('My List'));
        await tester.pumpAndSettle();

        expect(find.text('「My List」に追加しました'), findsOneWidget);
      });

      testWidgets('shows check icon after adding', (tester) async {
        final lists = [createSummary(id: 10, title: 'My List')];

        when(() => mockRepository.addBookToList(
              listId: 10,
              userBookId: 1,
            )).thenAnswer(
          (_) async => right(BookListItem(
            id: 1,
            position: 0,
            addedAt: now,
          )),
        );

        await tester.pumpWidget(buildTestWidget(
          userBookId: 1,
          lists: lists,
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.add_circle_outline), findsOneWidget);

        await tester.tap(find.text('My List'));
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.check_circle), findsOneWidget);
        expect(find.byIcon(Icons.close), findsOneWidget);
      });
    });

    group('added list display', () {
      testWidgets('shows check icon for already added lists', (tester) async {
        final lists = [
          createSummary(id: 10, title: 'Added List'),
          createSummary(id: 20, title: 'New List'),
        ];

        await tester.pumpWidget(buildTestWidget(
          userBookId: 1,
          lists: lists,
          addedListIds: [10],
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.check_circle), findsOneWidget);
        expect(find.byIcon(Icons.add_circle_outline), findsOneWidget);
      });
    });

    group('remove from list', () {
      testWidgets('calls removeBookFromList when close icon is tapped',
          (tester) async {
        final lists = [createSummary(id: 10, title: 'My List')];

        when(() => mockRepository.removeBookFromList(
              listId: 10,
              userBookId: 1,
            )).thenAnswer((_) async => right(null));

        await tester.pumpWidget(buildTestWidget(
          userBookId: 1,
          lists: lists,
          addedListIds: [10],
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.close));
        await tester.pumpAndSettle();

        verify(() => mockRepository.removeBookFromList(
              listId: 10,
              userBookId: 1,
            )).called(1);
      });

      testWidgets('shows add icon after removing', (tester) async {
        final lists = [createSummary(id: 10, title: 'My List')];

        when(() => mockRepository.removeBookFromList(
              listId: 10,
              userBookId: 1,
            )).thenAnswer((_) async => right(null));

        await tester.pumpWidget(buildTestWidget(
          userBookId: 1,
          lists: lists,
          addedListIds: [10],
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.check_circle), findsOneWidget);

        await tester.tap(find.byIcon(Icons.close));
        await tester.pumpAndSettle();

        expect(find.byIcon(Icons.add_circle_outline), findsOneWidget);
        expect(find.byIcon(Icons.check_circle), findsNothing);
      });
    });

    group('create new list', () {
      testWidgets('opens create book list modal when tapped', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          userBookId: 1,
          lists: [createSummary()],
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('新しいリストを作成'));
        await tester.pumpAndSettle();

        expect(find.text('ブックリストを作成'), findsOneWidget);
      });

      testWidgets('adds book to newly created list', (tester) async {
        final createdList = BookList(
          id: 99,
          title: 'ブックリスト#2',
          createdAt: now,
          updatedAt: now,
        );

        when(() => mockRepository.createBookList(
              title: any(named: 'title'),
              description: any(named: 'description'),
            )).thenAnswer((_) async => right(createdList));

        when(() => mockRepository.addBookToList(
              listId: 99,
              userBookId: 42,
            )).thenAnswer(
          (_) async => right(BookListItem(
            id: 1,
            position: 0,
            addedAt: now,
          )),
        );

        await tester.pumpWidget(buildTestWidget(
          userBookId: 42,
          lists: [createSummary()],
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('新しいリストを作成'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('作成する'));
        await tester.pumpAndSettle();

        verify(() => mockRepository.addBookToList(
              listId: 99,
              userBookId: 42,
            )).called(1);
      });

      testWidgets('shows success snackbar after adding book to list',
          (tester) async {
        final createdList = BookList(
          id: 99,
          title: 'ブックリスト#2',
          createdAt: now,
          updatedAt: now,
        );

        when(() => mockRepository.createBookList(
              title: any(named: 'title'),
              description: any(named: 'description'),
            )).thenAnswer((_) async => right(createdList));

        when(() => mockRepository.addBookToList(
              listId: any(named: 'listId'),
              userBookId: any(named: 'userBookId'),
            )).thenAnswer(
          (_) async => right(BookListItem(
            id: 1,
            position: 0,
            addedAt: now,
          )),
        );

        await tester.pumpWidget(buildTestWidget(
          userBookId: 42,
          lists: [createSummary()],
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('新しいリストを作成'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('作成する'));
        await tester.pumpAndSettle();

        expect(find.text('リストに追加しました'), findsOneWidget);
      });

      testWidgets('stays open after creating list', (tester) async {
        final createdList = BookList(
          id: 99,
          title: 'ブックリスト#2',
          createdAt: now,
          updatedAt: now,
        );

        when(() => mockRepository.createBookList(
              title: any(named: 'title'),
              description: any(named: 'description'),
            )).thenAnswer((_) async => right(createdList));

        when(() => mockRepository.addBookToList(
              listId: any(named: 'listId'),
              userBookId: any(named: 'userBookId'),
            )).thenAnswer(
          (_) async => right(BookListItem(
            id: 1,
            position: 0,
            addedAt: now,
          )),
        );

        await tester.pumpWidget(buildTestWidget(
          userBookId: 42,
          lists: [createSummary()],
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        expect(find.text('リストに追加'), findsOneWidget);

        await tester.tap(find.text('新しいリストを作成'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('作成する'));
        await tester.pumpAndSettle();

        expect(find.text('リストに追加'), findsOneWidget);
      });

      testWidgets('shows error snackbar when adding book fails',
          (tester) async {
        final createdList = BookList(
          id: 99,
          title: 'ブックリスト#2',
          createdAt: now,
          updatedAt: now,
        );

        when(() => mockRepository.createBookList(
              title: any(named: 'title'),
              description: any(named: 'description'),
            )).thenAnswer((_) async => right(createdList));

        when(() => mockRepository.addBookToList(
              listId: any(named: 'listId'),
              userBookId: any(named: 'userBookId'),
            )).thenAnswer(
          (_) async => left(const ServerFailure(
            message: 'Server error',
            code: 'INTERNAL_ERROR',
          )),
        );

        await tester.pumpWidget(buildTestWidget(
          userBookId: 42,
          lists: [createSummary()],
        ));
        await tester.pump();

        await tester.tap(find.text('Show Modal'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('新しいリストを作成'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('作成する'));
        await tester.pumpAndSettle();

        expect(find.text('サーバーエラーが発生しました'), findsOneWidget);
      });
    });
  });
}
