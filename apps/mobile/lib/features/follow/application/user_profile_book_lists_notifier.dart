import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/features/book_list/data/book_list_repository.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';

part 'user_profile_book_lists_notifier.g.dart';

class UserProfileBookListsState {
  const UserProfileBookListsState({
    this.lists = const [],
    this.isLoading = false,
    this.totalCount = 0,
    this.hasMore = false,
    this.error,
  });

  final List<BookListSummary> lists;
  final bool isLoading;
  final int totalCount;
  final bool hasMore;
  final Failure? error;
}

@riverpod
class UserProfileBookListsNotifier extends _$UserProfileBookListsNotifier {
  @override
  UserProfileBookListsState build(int userId) {
    return const UserProfileBookListsState();
  }

  Future<void> refresh() async {
    final repository = ref.read(bookListRepositoryProvider);
    final result = await repository.getUserBookLists(userId: userId);

    result.fold(
      (failure) {
        state = UserProfileBookListsState(error: failure);
      },
      (bookListsResult) {
        state = UserProfileBookListsState(
          lists: bookListsResult.items,
          totalCount: bookListsResult.totalCount,
          hasMore: bookListsResult.hasMore,
        );
      },
    );
  }

  Future<void> loadLists() async {
    state = const UserProfileBookListsState(isLoading: true);

    final repository = ref.read(bookListRepositoryProvider);
    final result = await repository.getUserBookLists(userId: userId);

    result.fold(
      (failure) {
        state = UserProfileBookListsState(error: failure);
      },
      (bookListsResult) {
        state = UserProfileBookListsState(
          lists: bookListsResult.items,
          totalCount: bookListsResult.totalCount,
          hasMore: bookListsResult.hasMore,
        );
      },
    );
  }
}
