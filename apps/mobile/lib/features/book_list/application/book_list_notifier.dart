import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/state/book_list_version.dart';
import 'package:shelfie/features/book_list/application/book_list_state.dart';
import 'package:shelfie/features/book_list/data/book_list_repository.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';

part 'book_list_notifier.g.dart';

@riverpod
class BookListNotifier extends _$BookListNotifier {
  @override
  BookListState build() {
    ref.listen(bookListVersionProvider, (_, __) {
      refresh();
    });
    return const BookListState.initial();
  }

  Future<void> loadLists() async {
    state = const BookListState.loading();
    await _fetchLists();
  }

  Future<void> refresh() async {
    state = const BookListState.loading();
    await _fetchLists();
  }

  Future<void> _fetchLists() async {
    final repository = ref.read(bookListRepositoryProvider);
    final result = await repository.getMyBookLists();

    result.fold(
      (failure) {
        state = BookListState.error(failure: failure);
      },
      (myBookListsResult) {
        state = BookListState.loaded(
          lists: myBookListsResult.items,
          totalCount: myBookListsResult.totalCount,
          hasMore: myBookListsResult.hasMore,
        );
      },
    );
  }

  Future<Either<Failure, BookList>> createList({
    required String title,
    String? description,
  }) async {
    final repository = ref.read(bookListRepositoryProvider);
    final result = await repository.createBookList(
      title: title,
      description: description,
    );

    if (result.isRight()) {
      ref.read(bookListVersionProvider.notifier).increment();
    }

    return result;
  }

  Future<Either<Failure, BookList>> updateList({
    required int listId,
    String? title,
    String? description,
  }) async {
    final repository = ref.read(bookListRepositoryProvider);
    final result = await repository.updateBookList(
      listId: listId,
      title: title,
      description: description,
    );

    if (result.isRight()) {
      ref.read(bookListVersionProvider.notifier).increment();
    }

    return result;
  }

  Future<Either<Failure, void>> deleteList({
    required int listId,
  }) async {
    final repository = ref.read(bookListRepositoryProvider);
    final result = await repository.deleteBookList(listId: listId);

    if (result.isRight()) {
      ref.read(bookListVersionProvider.notifier).increment();
    }

    return result;
  }
}

@riverpod
class BookListDetailNotifier extends _$BookListDetailNotifier {
  late int _listId;

  @override
  BookListDetailState build(int listId) {
    _listId = listId;
    ref.listen(bookListVersionProvider, (_, __) {
      refresh();
    });
    return const BookListDetailState.initial();
  }

  Future<void> loadDetail() async {
    state = const BookListDetailState.loading();
    await _fetchDetail();
  }

  Future<void> refresh() async {
    state = const BookListDetailState.loading();
    await _fetchDetail();
  }

  Future<void> _fetchDetail() async {
    final repository = ref.read(bookListRepositoryProvider);
    final result = await repository.getBookListDetail(listId: _listId);

    result.fold(
      (failure) {
        state = BookListDetailState.error(failure: failure);
      },
      (detail) {
        state = BookListDetailState.loaded(list: detail);
      },
    );
  }

  Future<Either<Failure, BookListItem>> addBook({
    required int userBookId,
  }) async {
    final repository = ref.read(bookListRepositoryProvider);
    final result = await repository.addBookToList(
      listId: _listId,
      userBookId: userBookId,
    );

    if (result.isRight()) {
      ref.read(bookListVersionProvider.notifier).increment();
    }

    return result;
  }

  Future<Either<Failure, void>> removeBook({
    required int userBookId,
  }) async {
    final repository = ref.read(bookListRepositoryProvider);
    final result = await repository.removeBookFromList(
      listId: _listId,
      userBookId: userBookId,
    );

    if (result.isRight()) {
      ref.read(bookListVersionProvider.notifier).increment();
    }

    return result;
  }

  void removeItemByExternalId(String externalId, {required bool wasCompleted}) {
    final currentState = state;
    if (currentState is! BookListDetailLoaded) return;

    final list = currentState.list;
    if (!list.items.any((item) => item.userBook?.externalId == externalId)) {
      return;
    }

    final updatedItems = list.items
        .where((item) => item.userBook?.externalId != externalId)
        .toList();

    state = BookListDetailState.loaded(
      list: list.copyWith(
        items: updatedItems,
        stats: list.stats.copyWith(
          bookCount: list.stats.bookCount - 1,
          completedCount: wasCompleted
              ? list.stats.completedCount - 1
              : list.stats.completedCount,
          coverImages: updatedItems
              .where((item) => item.userBook?.coverImageUrl != null)
              .take(4)
              .map((item) => item.userBook!.coverImageUrl!)
              .toList(),
        ),
      ),
    );
  }

  Future<Either<Failure, void>> reorderBook({
    required int itemId,
    required int oldIndex,
    required int newIndex,
  }) async {
    if (state is! BookListDetailLoaded) {
      return left(const ServerFailure(message: 'State not loaded', code: 'ERR'));
    }

    final currentState = state as BookListDetailLoaded;
    final originalList = currentState.list;
    final items = List<BookListItem>.from(originalList.items);

    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);

    final updatedItems = items.asMap().entries.map((entry) {
      return entry.value.copyWith(position: entry.key);
    }).toList();

    state = BookListDetailState.loaded(
      list: originalList.copyWith(items: updatedItems),
    );

    final repository = ref.read(bookListRepositoryProvider);
    final result = await repository.reorderBookInList(
      listId: _listId,
      itemId: itemId,
      newPosition: newIndex,
    );

    if (result.isLeft()) {
      state = BookListDetailState.loaded(list: originalList);
    }

    return result;
  }
}
