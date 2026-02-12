import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/state/book_list_version.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_version.dart';
import 'package:shelfie/features/book_detail/data/book_detail_repository.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart';

part 'shelf_state_notifier.g.dart';

/// ユーザーの本棚にある本の状態を管理する（SSOT）
///
/// externalId (Google Books ID) → ShelfEntry のマッピングを保持
/// 読書状態（readingStatus, note など）を一元管理する
@Riverpod(keepAlive: true)
class ShelfState extends _$ShelfState {
  @override
  Map<String, ShelfEntry> build() {
    return {};
  }

  /// 本を本棚に追加（API呼び出し + 状態更新）
  Future<Either<Failure, UserBook>> addToShelf({
    required String externalId,
    required String title,
    required List<String> authors,
    String? publisher,
    String? publishedDate,
    String? isbn,
    String? coverImageUrl,
    required BookSource source,
    ReadingStatus readingStatus = ReadingStatus.interested,
  }) async {
    final repository = ref.read(bookSearchRepositoryProvider);
    final result = await repository.addBookToShelf(
      externalId: externalId,
      title: title,
      authors: authors,
      publisher: publisher,
      publishedDate: publishedDate,
      isbn: isbn,
      coverImageUrl: coverImageUrl,
      source: source,
      readingStatus: readingStatus,
    );

    result.fold(
      (_) {},
      (userBook) {
        registerEntry(
          ShelfEntry(
            userBookId: userBook.id,
            externalId: userBook.externalId,
            readingStatus: readingStatus,
            addedAt: userBook.addedAt,
            startedAt: _resolveStartedAt(readingStatus, null),
            completedAt: _resolveCompletedAt(readingStatus, null),
          ),
        );
        ref.read(shelfVersionProvider.notifier).increment();
      },
    );

    return result;
  }

  /// 本を本棚から削除（API呼び出し + 状態更新）
  Future<Either<Failure, bool>> removeFromShelf({
    required String externalId,
    required int userBookId,
  }) async {
    final repository = ref.read(bookSearchRepositoryProvider);
    final result = await repository.removeFromShelf(
      userBookId: userBookId,
    );

    result.fold(
      (_) {},
      (_) {
        removeEntry(externalId);
        ref.read(shelfVersionProvider.notifier).increment();
        ref.read(bookListVersionProvider.notifier).increment();
      },
    );

    return result;
  }

  /// ShelfEntry を登録する
  void registerEntry(ShelfEntry entry) {
    state = {...state, entry.externalId: entry};
  }

  /// 指定した externalId の ShelfEntry を削除する
  void removeEntry(String externalId) {
    state = Map.from(state)..remove(externalId);
  }

  /// 指定した externalId の ShelfEntry を取得する
  ShelfEntry? getEntry(String externalId) {
    return state[externalId];
  }

  /// 読書状態を更新する（Optimistic Update + API呼び出し）
  Future<Either<Failure, ShelfEntry>> updateReadingStatusWithApi({
    required String externalId,
    required ReadingStatus status,
  }) async {
    final entry = state[externalId];
    if (entry == null) {
      return left(const UnexpectedFailure(message: 'Entry not found'));
    }

    final previousEntry = entry;
    _updateReadingStatusOptimistic(externalId: externalId, status: status);

    final repository = ref.read(bookDetailRepositoryProvider);
    final result = await repository.updateReadingStatus(
      userBookId: entry.userBookId,
      status: status,
    );

    return result.fold(
      (failure) {
        state = {...state, externalId: previousEntry};
        return left(failure);
      },
      (userBook) {
        final updated = entry.copyWith(
          readingStatus: userBook.readingStatus,
          startedAt: userBook.startedAt,
          completedAt: userBook.completedAt,
        );
        state = {...state, externalId: updated};
        ref.read(shelfVersionProvider.notifier).increment();
        return right(updated);
      },
    );
  }

  /// 読書メモを更新する（Optimistic Update + API呼び出し）
  Future<Either<Failure, ShelfEntry>> updateReadingNoteWithApi({
    required String externalId,
    required String note,
  }) async {
    final entry = state[externalId];
    if (entry == null) {
      return left(const UnexpectedFailure(message: 'Entry not found'));
    }

    final previousEntry = entry;
    _updateReadingNoteOptimistic(externalId: externalId, note: note);

    final repository = ref.read(bookDetailRepositoryProvider);
    final result = await repository.updateReadingNote(
      userBookId: entry.userBookId,
      note: note,
    );

    return result.fold(
      (failure) {
        state = {...state, externalId: previousEntry};
        return left(failure);
      },
      (userBook) {
        final updated = entry.copyWith(
          note: userBook.note,
          noteUpdatedAt: userBook.noteUpdatedAt,
        );
        state = {...state, externalId: updated};
        return right(updated);
      },
    );
  }

  /// 感想を更新する（Optimistic Update + API呼び出し）
  Future<Either<Failure, ShelfEntry>> updateThoughtsWithApi({
    required String externalId,
    required String thoughts,
  }) async {
    final entry = state[externalId];
    if (entry == null) {
      return left(const UnexpectedFailure(message: 'Entry not found'));
    }

    final previousEntry = entry;
    _updateThoughtsOptimistic(externalId: externalId, thoughts: thoughts);

    final repository = ref.read(bookDetailRepositoryProvider);
    final result = await repository.updateThoughts(
      userBookId: entry.userBookId,
      thoughts: thoughts,
    );

    return result.fold(
      (failure) {
        state = {...state, externalId: previousEntry};
        return left(failure);
      },
      (userBook) {
        final updated = entry.copyWith(
          thoughts: userBook.thoughts,
          thoughtsUpdatedAt: userBook.thoughtsUpdatedAt,
        );
        state = {...state, externalId: updated};
        return right(updated);
      },
    );
  }

  /// 評価を更新する（Optimistic Update + API呼び出し）
  Future<Either<Failure, ShelfEntry>> updateRatingWithApi({
    required String externalId,
    required int? rating,
  }) async {
    final entry = state[externalId];
    if (entry == null) {
      return left(const UnexpectedFailure(message: 'Entry not found'));
    }

    final previousEntry = entry;
    _updateRatingOptimistic(externalId: externalId, rating: rating);

    final repository = ref.read(bookDetailRepositoryProvider);
    final result = await repository.updateRating(
      userBookId: entry.userBookId,
      rating: rating,
    );

    return result.fold(
      (failure) {
        state = {...state, externalId: previousEntry};
        return left(failure);
      },
      (userBook) {
        final updated = entry.copyWith(
          rating: userBook.rating,
        );
        state = {...state, externalId: updated};
        return right(updated);
      },
    );
  }

  /// 読了日を更新する（Optimistic Update + API呼び出し）
  Future<Either<Failure, ShelfEntry>> updateCompletedAtWithApi({
    required String externalId,
    required DateTime completedAt,
  }) async {
    final entry = state[externalId];
    if (entry == null) {
      return left(const UnexpectedFailure(message: 'Entry not found'));
    }

    final previousEntry = entry;
    final optimistic = entry.copyWith(completedAt: completedAt);
    state = {...state, externalId: optimistic};

    final repository = ref.read(bookDetailRepositoryProvider);
    final result = await repository.updateCompletedAt(
      userBookId: entry.userBookId,
      completedAt: completedAt,
    );

    return result.fold(
      (failure) {
        state = {...state, externalId: previousEntry};
        return left(failure);
      },
      (userBook) {
        final updated = entry.copyWith(
          completedAt: userBook.completedAt,
        );
        state = {...state, externalId: updated};
        return right(updated);
      },
    );
  }

  /// 読書開始日を更新する（Optimistic Update + API呼び出し）
  Future<Either<Failure, ShelfEntry>> updateStartedAtWithApi({
    required String externalId,
    required DateTime startedAt,
  }) async {
    final entry = state[externalId];
    if (entry == null) {
      return left(const UnexpectedFailure(message: 'Entry not found'));
    }

    final previousEntry = entry;
    final optimistic = entry.copyWith(startedAt: startedAt);
    state = {...state, externalId: optimistic};

    final repository = ref.read(bookDetailRepositoryProvider);
    final result = await repository.updateStartedAt(
      userBookId: entry.userBookId,
      startedAt: startedAt,
    );

    return result.fold(
      (failure) {
        state = {...state, externalId: previousEntry};
        return left(failure);
      },
      (userBook) {
        final updated = entry.copyWith(
          startedAt: userBook.startedAt,
        );
        state = {...state, externalId: updated};
        return right(updated);
      },
    );
  }

  /// 読書状態を更新する（Optimistic Update のみ）
  void updateReadingStatus({
    required String externalId,
    required ReadingStatus status,
  }) {
    _updateReadingStatusOptimistic(externalId: externalId, status: status);
  }

  /// 読書メモを更新する（Optimistic Update のみ）
  void updateReadingNote({
    required String externalId,
    required String note,
  }) {
    _updateReadingNoteOptimistic(externalId: externalId, note: note);
  }

  /// 感想を更新する（Optimistic Update のみ）
  void updateThoughts({
    required String externalId,
    required String thoughts,
  }) {
    _updateThoughtsOptimistic(externalId: externalId, thoughts: thoughts);
  }

  void _updateReadingStatusOptimistic({
    required String externalId,
    required ReadingStatus status,
  }) {
    final entry = state[externalId];
    if (entry == null) return;

    final startedAt = _resolveStartedAt(status, entry.startedAt);
    final updated = entry.copyWith(
      readingStatus: status,
      startedAt: startedAt,
      completedAt: _resolveCompletedAt(status, entry.completedAt),
    );

    state = {...state, externalId: updated};
  }

  void _updateReadingNoteOptimistic({
    required String externalId,
    required String note,
  }) {
    final entry = state[externalId];
    if (entry == null) return;

    final updated = entry.copyWith(
      note: note,
      noteUpdatedAt: DateTime.now(),
    );

    state = {...state, externalId: updated};
  }

  void _updateThoughtsOptimistic({
    required String externalId,
    required String thoughts,
  }) {
    final entry = state[externalId];
    if (entry == null) return;

    final updated = entry.copyWith(
      thoughts: thoughts,
      thoughtsUpdatedAt: DateTime.now(),
    );

    state = {...state, externalId: updated};
  }

  void _updateRatingOptimistic({
    required String externalId,
    required int? rating,
  }) {
    final entry = state[externalId];
    if (entry == null) return;

    final updated = entry.copyWith(
      rating: rating,
    );

    state = {...state, externalId: updated};
  }

  /// 本が本棚にあるかどうか
  bool isInShelf(String externalId) {
    return state.containsKey(externalId);
  }

  /// 本の userBookId を取得（本棚にない場合は null）
  int? getUserBookId(String externalId) {
    return state[externalId]?.userBookId;
  }

  /// 外部から状態を更新する（後方互換性のため維持）
  void registerBook(String externalId, int userBookId) {
    registerEntry(
      ShelfEntry(
        userBookId: userBookId,
        externalId: externalId,
        readingStatus: ReadingStatus.interested,
        addedAt: DateTime.now(),
      ),
    );
  }

  static DateTime? _resolveStartedAt(
    ReadingStatus status,
    DateTime? currentStartedAt,
  ) {
    if (status == ReadingStatus.reading && currentStartedAt == null) {
      return DateTime.now();
    }
    return currentStartedAt;
  }

  static DateTime? _resolveCompletedAt(
    ReadingStatus status,
    DateTime? currentCompletedAt,
  ) {
    if (status == ReadingStatus.completed) {
      return currentCompletedAt ?? DateTime.now();
    }
    return currentCompletedAt;
  }

  /// 全てのエントリをクリアする
  void clear() {
    state = {};
  }
}
