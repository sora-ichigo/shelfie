import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/features/book_detail/data/book_detail_repository.dart';
import 'package:shelfie/features/book_detail/domain/book_detail.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_detail/domain/user_book.dart';

part 'book_detail_notifier.g.dart';

@riverpod
class BookDetailNotifier extends _$BookDetailNotifier {
  @override
  Future<BookDetail?> build(String externalId) async {
    return null;
  }

  Future<void> loadBookDetail() async {
    state = const AsyncLoading();

    final repository = ref.read(bookDetailRepositoryProvider);
    final result = await repository.getBookDetail(bookId: externalId);

    switch (result) {
      case Left(:final value):
        state = AsyncError(value, StackTrace.current);
      case Right(:final value):
        if (value.userBook != null) {
          final userBook = value.userBook!;
          ref.read(shelfStateProvider.notifier).registerEntry(
            ShelfEntry(
              userBookId: userBook.id,
              externalId: value.id,
              readingStatus: userBook.readingStatus,
              addedAt: userBook.addedAt,
              completedAt: userBook.completedAt,
              note: userBook.note,
              noteUpdatedAt: userBook.noteUpdatedAt,
            ),
          );
        }
        state = AsyncData(value);
    }
  }

  Future<Either<Failure, UserBook>> updateReadingStatus({
    required int userBookId,
    required ReadingStatus status,
  }) async {
    final currentState = state;
    if (!currentState.hasValue || currentState.value == null) {
      return left(
        const UnexpectedFailure(message: 'BookDetail is not loaded'),
      );
    }

    final currentBookDetail = currentState.value!;
    final currentUserBook = currentBookDetail.userBook;
    if (currentUserBook == null) {
      return left(
        const UnexpectedFailure(message: 'UserBook is not available'),
      );
    }

    final result = await ref.read(shelfStateProvider.notifier).updateReadingStatusWithApi(
      externalId: externalId,
      status: status,
    );

    return result.fold(
      (failure) => left(failure),
      (shelfEntry) {
        final updatedUserBook = currentUserBook.copyWith(
          readingStatus: shelfEntry.readingStatus,
          completedAt: shelfEntry.completedAt,
        );
        state = AsyncData(currentBookDetail.copyWith(userBook: updatedUserBook));
        return right(updatedUserBook);
      },
    );
  }

  Future<Either<Failure, void>> addToShelf() async {
    final currentState = state;
    if (!currentState.hasValue || currentState.value == null) {
      return left(
        const UnexpectedFailure(message: 'BookDetail is not loaded'),
      );
    }

    final currentBookDetail = currentState.value!;
    if (currentBookDetail.isInShelf) {
      return left(
        const DuplicateBookFailure(message: 'Book is already in shelf'),
      );
    }

    final result = await ref.read(shelfStateProvider.notifier).addToShelf(
      externalId: currentBookDetail.id,
      title: currentBookDetail.title,
      authors: currentBookDetail.authors,
      publisher: currentBookDetail.publisher,
      publishedDate: currentBookDetail.publishedDate,
      coverImageUrl: currentBookDetail.thumbnailUrl,
    );

    switch (result) {
      case Left(:final value):
        return left(value);
      case Right(:final value):
        final newUserBook = UserBook(
          id: value.id,
          readingStatus: ReadingStatus.backlog,
          addedAt: value.addedAt,
        );
        state = AsyncData(currentBookDetail.copyWith(userBook: newUserBook));
        return right(null);
    }
  }

  Future<Either<Failure, void>> removeFromShelf() async {
    final currentState = state;
    if (!currentState.hasValue || currentState.value == null) {
      return left(
        const UnexpectedFailure(message: 'BookDetail is not loaded'),
      );
    }

    final currentBookDetail = currentState.value!;
    final userBook = currentBookDetail.userBook;
    if (userBook == null) {
      return left(
        const UnexpectedFailure(message: 'Book is not in shelf'),
      );
    }

    final result = await ref.read(shelfStateProvider.notifier).removeFromShelf(
      externalId: currentBookDetail.id,
      userBookId: userBook.id,
    );

    switch (result) {
      case Left(:final value):
        return left(value);
      case Right():
        state = AsyncData(currentBookDetail.copyWith(userBook: null));
        return right(null);
    }
  }

  Future<Either<Failure, UserBook>> updateReadingNote({
    required int userBookId,
    required String note,
  }) async {
    final currentState = state;
    if (!currentState.hasValue || currentState.value == null) {
      return left(
        const UnexpectedFailure(message: 'BookDetail is not loaded'),
      );
    }

    final currentBookDetail = currentState.value!;
    final currentUserBook = currentBookDetail.userBook;
    if (currentUserBook == null) {
      return left(
        const UnexpectedFailure(message: 'UserBook is not available'),
      );
    }

    final result = await ref.read(shelfStateProvider.notifier).updateReadingNoteWithApi(
      externalId: externalId,
      note: note,
    );

    return result.fold(
      (failure) => left(failure),
      (shelfEntry) {
        final updatedUserBook = currentUserBook.copyWith(
          note: shelfEntry.note,
          noteUpdatedAt: shelfEntry.noteUpdatedAt,
        );
        state = AsyncData(currentBookDetail.copyWith(userBook: updatedUserBook));
        return right(updatedUserBook);
      },
    );
  }
}
