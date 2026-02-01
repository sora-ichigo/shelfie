import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/features/book_detail/data/book_detail_repository.dart';
import 'package:shelfie/features/book_detail/domain/book_detail.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart'
    show BookSource;

part 'book_detail_notifier.g.dart';

@riverpod
class BookDetailNotifier extends _$BookDetailNotifier {
  @override
  Future<BookDetail?> build(String externalId) async {
    return null;
  }

  Future<void> loadBookDetail({BookSource? source}) async {
    state = const AsyncLoading();

    final repository = ref.read(bookDetailRepositoryProvider);
    final result = await repository.getBookDetail(
      bookId: externalId,
      source: source,
    );

    switch (result) {
      case Left(:final value):
        state = AsyncError(value, StackTrace.current);
      case Right(:final value):
        state = AsyncData(value.bookDetail);
        if (value.userBook != null) {
          final userBook = value.userBook!;
          ref.read(shelfStateProvider.notifier).registerEntry(
            ShelfEntry(
              userBookId: userBook.id,
              externalId: value.bookDetail.id,
              readingStatus: userBook.readingStatus,
              addedAt: userBook.addedAt,
              completedAt: userBook.completedAt,
              note: userBook.note,
              noteUpdatedAt: userBook.noteUpdatedAt,
              rating: userBook.rating,
            ),
          );
        }
    }
  }

  Future<Either<Failure, ShelfEntry>> updateReadingStatus({
    required int userBookId,
    required ReadingStatus status,
  }) async {
    final shelfEntry = ref.read(shelfStateProvider)[externalId];
    if (shelfEntry == null) {
      return left(
        const UnexpectedFailure(message: 'Book is not in shelf'),
      );
    }

    return ref.read(shelfStateProvider.notifier).updateReadingStatusWithApi(
      externalId: externalId,
      status: status,
    );
  }

  Future<Either<Failure, void>> addToShelf({
    ReadingStatus readingStatus = ReadingStatus.backlog,
  }) async {
    final currentState = state;
    if (!currentState.hasValue || currentState.value == null) {
      return left(
        const UnexpectedFailure(message: 'BookDetail is not loaded'),
      );
    }

    final currentBookDetail = currentState.value!;
    final isInShelf = ref.read(shelfStateProvider.notifier).isInShelf(currentBookDetail.id);
    if (isInShelf) {
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
      source: currentBookDetail.source,
      readingStatus: readingStatus,
    );

    return result.fold(left, (_) => right(null));
  }

  Future<Either<Failure, void>> removeFromShelf() async {
    final currentState = state;
    if (!currentState.hasValue || currentState.value == null) {
      return left(
        const UnexpectedFailure(message: 'BookDetail is not loaded'),
      );
    }

    final currentBookDetail = currentState.value!;
    final shelfEntry = ref.read(shelfStateProvider)[currentBookDetail.id];
    if (shelfEntry == null) {
      return left(
        const UnexpectedFailure(message: 'Book is not in shelf'),
      );
    }

    final result = await ref.read(shelfStateProvider.notifier).removeFromShelf(
      externalId: currentBookDetail.id,
      userBookId: shelfEntry.userBookId,
    );

    return result.fold(left, (_) => right(null));
  }

  Future<Either<Failure, ShelfEntry>> updateReadingNote({
    required int userBookId,
    required String note,
  }) async {
    final shelfEntry = ref.read(shelfStateProvider)[externalId];
    if (shelfEntry == null) {
      return left(
        const UnexpectedFailure(message: 'Book is not in shelf'),
      );
    }

    return ref.read(shelfStateProvider.notifier).updateReadingNoteWithApi(
      externalId: externalId,
      note: note,
    );
  }

  Future<Either<Failure, ShelfEntry>> updateRating({
    required int userBookId,
    required int? rating,
  }) async {
    final shelfEntry = ref.read(shelfStateProvider)[externalId];
    if (shelfEntry == null) {
      return left(
        const UnexpectedFailure(message: 'Book is not in shelf'),
      );
    }

    return ref.read(shelfStateProvider.notifier).updateRatingWithApi(
      externalId: externalId,
      rating: rating,
    );
  }
}
