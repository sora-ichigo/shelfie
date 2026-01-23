import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
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

    final optimisticUserBook = currentUserBook.copyWith(
      readingStatus: status,
    );
    state = AsyncData(currentBookDetail.copyWith(userBook: optimisticUserBook));

    final repository = ref.read(bookDetailRepositoryProvider);
    final result = await repository.updateReadingStatus(
      userBookId: userBookId,
      status: status,
    );

    switch (result) {
      case Left(:final value):
        state = AsyncData(currentBookDetail);
        return left(value);
      case Right(:final value):
        state = AsyncData(currentBookDetail.copyWith(userBook: value));
        return right(value);
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

    final optimisticUserBook = currentUserBook.copyWith(
      note: note,
    );
    state = AsyncData(currentBookDetail.copyWith(userBook: optimisticUserBook));

    final repository = ref.read(bookDetailRepositoryProvider);
    final result = await repository.updateReadingNote(
      userBookId: userBookId,
      note: note,
    );

    switch (result) {
      case Left(:final value):
        state = AsyncData(currentBookDetail);
        return left(value);
      case Right(:final value):
        state = AsyncData(currentBookDetail.copyWith(userBook: value));
        return right(value);
    }
  }
}
