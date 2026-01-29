import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/features/book_list/application/book_list_notifier.dart';
import 'package:shelfie/features/book_list/application/book_list_state.dart';
import 'package:shelfie/features/book_list/data/book_list_repository.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';

class MockBookListRepository extends Mock implements BookListRepository {}

void main() {
  late ProviderContainer container;
  late MockBookListRepository mockRepository;

  final now = DateTime(2024, 1, 15, 10, 30);

  BookListSummary createSummary({
    int id = 1,
    String title = 'Test List',
    String? description,
    int bookCount = 3,
    List<String> coverImages = const [],
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BookListSummary(
      id: id,
      title: title,
      description: description,
      bookCount: bookCount,
      coverImages: coverImages,
      createdAt: createdAt ?? now,
      updatedAt: updatedAt ?? now,
    );
  }

  BookListDetail createDetail({
    int id = 1,
    String title = 'Test List',
    String? description,
    List<BookListItem> items = const [],
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BookListDetail(
      id: id,
      title: title,
      description: description,
      items: items,
      stats: const BookListDetailStats(
        bookCount: 0,
        completedCount: 0,
        coverImages: [],
      ),
      createdAt: createdAt ?? now,
      updatedAt: updatedAt ?? now,
    );
  }

  BookListItem createItem({
    int id = 1,
    int position = 0,
    DateTime? addedAt,
  }) {
    return BookListItem(
      id: id,
      position: position,
      addedAt: addedAt ?? now,
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
    container = ProviderContainer(
      overrides: [
        bookListRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('BookListNotifier', () {
    group('build (initialization)', () {
      test('should start with initial state', () {
        when(() => mockRepository.getMyBookLists())
            .thenAnswer((_) async => right(createMyBookListsResult()));

        final notifier = container.read(bookListNotifierProvider.notifier);

        expect(notifier.state, isA<BookListInitial>());
      });

      test('should fetch initial data when loadLists is called', () async {
        when(() => mockRepository.getMyBookLists())
            .thenAnswer((_) async => right(createMyBookListsResult()));

        final notifier = container.read(bookListNotifierProvider.notifier);
        await notifier.loadLists();

        expect(notifier.state, isA<BookListLoaded>());
      });

      test('should transition to loaded state on success', () async {
        final lists = [
          createSummary(id: 1, title: 'List 1'),
          createSummary(id: 2, title: 'List 2'),
        ];
        when(() => mockRepository.getMyBookLists()).thenAnswer(
          (_) async => right(
            createMyBookListsResult(items: lists, totalCount: 2, hasMore: false),
          ),
        );

        final notifier = container.read(bookListNotifierProvider.notifier);
        await notifier.loadLists();

        expect(notifier.state, isA<BookListLoaded>());
        final loaded = notifier.state as BookListLoaded;
        expect(loaded.lists.length, 2);
        expect(loaded.totalCount, 2);
        expect(loaded.hasMore, isFalse);
      });

      test('should transition to error state on failure', () async {
        when(() => mockRepository.getMyBookLists()).thenAnswer(
          (_) async => left(const NetworkFailure(message: 'Network error')),
        );

        final notifier = container.read(bookListNotifierProvider.notifier);
        await notifier.loadLists();

        expect(notifier.state, isA<BookListError>());
        final error = notifier.state as BookListError;
        expect(error.failure, isA<NetworkFailure>());
      });
    });

    group('createList', () {
      test('should refresh lists after successful creation', () async {
        when(() => mockRepository.getMyBookLists())
            .thenAnswer((_) async => right(createMyBookListsResult()));
        when(
          () => mockRepository.createBookList(
            title: any(named: 'title'),
            description: any(named: 'description'),
          ),
        ).thenAnswer(
          (_) async => right(
            BookList(
              id: 1,
              title: 'New List',
              description: null,
              createdAt: now,
              updatedAt: now,
            ),
          ),
        );

        final notifier = container.read(bookListNotifierProvider.notifier);
        await notifier.loadLists();
        clearInteractions(mockRepository);

        when(() => mockRepository.getMyBookLists()).thenAnswer(
          (_) async => right(
            createMyBookListsResult(
              items: [
                createSummary(id: 1, title: 'New List'),
              ],
            ),
          ),
        );

        final result = await notifier.createList(title: 'New List');

        expect(result.isRight(), isTrue);
        verify(() => mockRepository.getMyBookLists()).called(1);
      });

      test('should return Left on failure', () async {
        when(() => mockRepository.getMyBookLists())
            .thenAnswer((_) async => right(createMyBookListsResult()));
        when(
          () => mockRepository.createBookList(
            title: any(named: 'title'),
            description: any(named: 'description'),
          ),
        ).thenAnswer(
          (_) async =>
              left(const ValidationFailure(message: 'Title is required')),
        );

        final notifier = container.read(bookListNotifierProvider.notifier);
        await notifier.loadLists();

        final result = await notifier.createList(title: '');

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<ValidationFailure>());
      });
    });

    group('updateList', () {
      test('should refresh lists after successful update', () async {
        when(() => mockRepository.getMyBookLists())
            .thenAnswer((_) async => right(createMyBookListsResult()));
        when(
          () => mockRepository.updateBookList(
            listId: any(named: 'listId'),
            title: any(named: 'title'),
            description: any(named: 'description'),
          ),
        ).thenAnswer(
          (_) async => right(
            BookList(
              id: 1,
              title: 'Updated Title',
              description: null,
              createdAt: now,
              updatedAt: now,
            ),
          ),
        );

        final notifier = container.read(bookListNotifierProvider.notifier);
        await notifier.loadLists();
        clearInteractions(mockRepository);

        when(() => mockRepository.getMyBookLists()).thenAnswer(
          (_) async => right(
            createMyBookListsResult(
              items: [createSummary(id: 1, title: 'Updated Title')],
            ),
          ),
        );

        final result =
            await notifier.updateList(listId: 1, title: 'Updated Title');

        expect(result.isRight(), isTrue);
        verify(() => mockRepository.getMyBookLists()).called(1);
      });
    });

    group('deleteList', () {
      test('should refresh lists after successful deletion', () async {
        when(() => mockRepository.getMyBookLists())
            .thenAnswer((_) async => right(createMyBookListsResult()));
        when(
          () => mockRepository.deleteBookList(listId: any(named: 'listId')),
        ).thenAnswer((_) async => right(null));

        final notifier = container.read(bookListNotifierProvider.notifier);
        await notifier.loadLists();
        clearInteractions(mockRepository);

        when(() => mockRepository.getMyBookLists()).thenAnswer(
          (_) async => right(
            createMyBookListsResult(items: [], totalCount: 0),
          ),
        );

        final result = await notifier.deleteList(listId: 1);

        expect(result.isRight(), isTrue);
        verify(() => mockRepository.getMyBookLists()).called(1);
      });

      test('should return Left on failure', () async {
        when(() => mockRepository.getMyBookLists())
            .thenAnswer((_) async => right(createMyBookListsResult()));
        when(
          () => mockRepository.deleteBookList(listId: any(named: 'listId')),
        ).thenAnswer(
          (_) async => left(const NotFoundFailure(message: 'List not found')),
        );

        final notifier = container.read(bookListNotifierProvider.notifier);
        await notifier.loadLists();

        final result = await notifier.deleteList(listId: 999);

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<NotFoundFailure>());
      });
    });

    group('refresh', () {
      test('should refetch lists', () async {
        when(() => mockRepository.getMyBookLists())
            .thenAnswer((_) async => right(createMyBookListsResult()));

        final notifier = container.read(bookListNotifierProvider.notifier);
        await notifier.loadLists();
        clearInteractions(mockRepository);

        when(() => mockRepository.getMyBookLists()).thenAnswer(
          (_) async => right(
            createMyBookListsResult(
              items: [
                createSummary(id: 1, title: 'Refreshed'),
              ],
            ),
          ),
        );

        await notifier.refresh();

        verify(() => mockRepository.getMyBookLists()).called(1);
        expect(notifier.state, isA<BookListLoaded>());
        final loaded = notifier.state as BookListLoaded;
        expect(loaded.lists.first.title, 'Refreshed');
      });
    });
  });

  group('BookListDetailNotifier', () {
    group('loadDetail', () {
      test('should start with initial state', () {
        final notifier =
            container.read(bookListDetailNotifierProvider(1).notifier);

        expect(notifier.state, isA<BookListDetailInitial>());
      });

      test('should transition to loaded state on success', () async {
        final detail = createDetail(
          id: 1,
          title: 'Test List',
          items: [createItem(id: 10, position: 0)],
        );

        when(() => mockRepository.getBookListDetail(listId: 1))
            .thenAnswer((_) async => right(detail));

        final notifier =
            container.read(bookListDetailNotifierProvider(1).notifier);
        await notifier.loadDetail();

        expect(notifier.state, isA<BookListDetailLoaded>());
        final loaded = notifier.state as BookListDetailLoaded;
        expect(loaded.list.id, 1);
        expect(loaded.list.title, 'Test List');
        expect(loaded.list.items.length, 1);
      });

      test('should transition to error state on failure', () async {
        when(() => mockRepository.getBookListDetail(listId: 999)).thenAnswer(
          (_) async => left(const NotFoundFailure(message: 'List not found')),
        );

        final notifier =
            container.read(bookListDetailNotifierProvider(999).notifier);
        await notifier.loadDetail();

        expect(notifier.state, isA<BookListDetailError>());
        final error = notifier.state as BookListDetailError;
        expect(error.failure, isA<NotFoundFailure>());
      });
    });

    group('addBook', () {
      test('should refresh detail after successful add', () async {
        final detail = createDetail(id: 1, items: []);

        when(() => mockRepository.getBookListDetail(listId: 1))
            .thenAnswer((_) async => right(detail));
        when(
          () => mockRepository.addBookToList(
            listId: any(named: 'listId'),
            userBookId: any(named: 'userBookId'),
          ),
        ).thenAnswer(
          (_) async => right(createItem(id: 10, position: 0)),
        );

        final notifier =
            container.read(bookListDetailNotifierProvider(1).notifier);
        await notifier.loadDetail();
        clearInteractions(mockRepository);

        final updatedDetail = createDetail(
          id: 1,
          items: [createItem(id: 10, position: 0)],
        );
        when(() => mockRepository.getBookListDetail(listId: 1))
            .thenAnswer((_) async => right(updatedDetail));

        final result = await notifier.addBook(userBookId: 100);

        expect(result.isRight(), isTrue);
        verify(() => mockRepository.getBookListDetail(listId: 1)).called(1);
      });

      test('should return Left on duplicate book', () async {
        final detail = createDetail(id: 1);

        when(() => mockRepository.getBookListDetail(listId: 1))
            .thenAnswer((_) async => right(detail));
        when(
          () => mockRepository.addBookToList(
            listId: any(named: 'listId'),
            userBookId: any(named: 'userBookId'),
          ),
        ).thenAnswer(
          (_) async =>
              left(const DuplicateBookFailure(message: 'Book already in list')),
        );

        final notifier =
            container.read(bookListDetailNotifierProvider(1).notifier);
        await notifier.loadDetail();

        final result = await notifier.addBook(userBookId: 100);

        expect(result.isLeft(), isTrue);
        final failure = result.getLeft().toNullable();
        expect(failure, isA<DuplicateBookFailure>());
      });
    });

    group('removeBook', () {
      test('should refresh detail after successful removal', () async {
        final detail = createDetail(
          id: 1,
          items: [createItem(id: 10, position: 0)],
        );

        when(() => mockRepository.getBookListDetail(listId: 1))
            .thenAnswer((_) async => right(detail));
        when(
          () => mockRepository.removeBookFromList(
            listId: any(named: 'listId'),
            userBookId: any(named: 'userBookId'),
          ),
        ).thenAnswer((_) async => right(null));

        final notifier =
            container.read(bookListDetailNotifierProvider(1).notifier);
        await notifier.loadDetail();
        clearInteractions(mockRepository);

        final updatedDetail = createDetail(id: 1, items: []);
        when(() => mockRepository.getBookListDetail(listId: 1))
            .thenAnswer((_) async => right(updatedDetail));

        final result = await notifier.removeBook(userBookId: 100);

        expect(result.isRight(), isTrue);
        verify(() => mockRepository.getBookListDetail(listId: 1)).called(1);
      });
    });

    group('reorderBook (optimistic update)', () {
      test('should apply optimistic update immediately', () async {
        final detail = createDetail(
          id: 1,
          items: [
            createItem(id: 10, position: 0),
            createItem(id: 20, position: 1),
            createItem(id: 30, position: 2),
          ],
        );

        when(() => mockRepository.getBookListDetail(listId: 1))
            .thenAnswer((_) async => right(detail));
        when(
          () => mockRepository.reorderBookInList(
            listId: any(named: 'listId'),
            itemId: any(named: 'itemId'),
            newPosition: any(named: 'newPosition'),
          ),
        ).thenAnswer((_) async => right(null));

        final notifier =
            container.read(bookListDetailNotifierProvider(1).notifier);
        await notifier.loadDetail();

        final reorderFuture = notifier.reorderBook(
          itemId: 10,
          oldIndex: 0,
          newIndex: 2,
        );

        expect(notifier.state, isA<BookListDetailLoaded>());
        final loaded = notifier.state as BookListDetailLoaded;
        expect(loaded.list.items[0].id, 20);
        expect(loaded.list.items[1].id, 30);
        expect(loaded.list.items[2].id, 10);

        final result = await reorderFuture;
        expect(result.isRight(), isTrue);
      });

      test('should revert on failure', () async {
        final detail = createDetail(
          id: 1,
          items: [
            createItem(id: 10, position: 0),
            createItem(id: 20, position: 1),
            createItem(id: 30, position: 2),
          ],
        );

        when(() => mockRepository.getBookListDetail(listId: 1))
            .thenAnswer((_) async => right(detail));
        when(
          () => mockRepository.reorderBookInList(
            listId: any(named: 'listId'),
            itemId: any(named: 'itemId'),
            newPosition: any(named: 'newPosition'),
          ),
        ).thenAnswer(
          (_) async => left(const ServerFailure(message: 'Error', code: 'ERR')),
        );

        final notifier =
            container.read(bookListDetailNotifierProvider(1).notifier);
        await notifier.loadDetail();

        final result = await notifier.reorderBook(
          itemId: 10,
          oldIndex: 0,
          newIndex: 2,
        );

        expect(result.isLeft(), isTrue);

        final loaded = notifier.state as BookListDetailLoaded;
        expect(loaded.list.items[0].id, 10);
        expect(loaded.list.items[1].id, 20);
        expect(loaded.list.items[2].id, 30);
      });
    });

    group('refresh', () {
      test('should refetch detail', () async {
        final detail = createDetail(id: 1, title: 'Original');

        when(() => mockRepository.getBookListDetail(listId: 1))
            .thenAnswer((_) async => right(detail));

        final notifier =
            container.read(bookListDetailNotifierProvider(1).notifier);
        await notifier.loadDetail();
        clearInteractions(mockRepository);

        final updatedDetail = createDetail(id: 1, title: 'Refreshed');
        when(() => mockRepository.getBookListDetail(listId: 1))
            .thenAnswer((_) async => right(updatedDetail));

        await notifier.refresh();

        verify(() => mockRepository.getBookListDetail(listId: 1)).called(1);
        expect(notifier.state, isA<BookListDetailLoaded>());
        final loaded = notifier.state as BookListDetailLoaded;
        expect(loaded.list.title, 'Refreshed');
      });
    });
  });
}
