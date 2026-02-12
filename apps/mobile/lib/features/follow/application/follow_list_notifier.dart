import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/state/follow_version.dart';
import 'package:shelfie/features/follow/data/follow_repository.dart';
import 'package:shelfie/features/follow/domain/follow_list_type.dart';
import 'package:shelfie/features/follow/domain/user_summary.dart';

part 'follow_list_notifier.g.dart';

@riverpod
class FollowListNotifier extends _$FollowListNotifier {
  static const _pageSize = 20;
  late int _userId;
  late FollowListType _listType;
  List<UserSummary> _items = [];
  bool _hasMore = true;
  bool _isLoadingMore = false;

  @override
  AsyncValue<List<UserSummary>> build(int userId, FollowListType listType) {
    _userId = userId;
    _listType = listType;
    _items = [];
    _hasMore = true;
    _isLoadingMore = false;

    ref.listen(followVersionProvider, (_, __) {
      loadInitial();
    });

    return const AsyncLoading();
  }

  bool get hasMore => _hasMore;
  bool get isLoadingMore => _isLoadingMore;

  Future<void> loadInitial() async {
    state = const AsyncLoading();
    _items = [];
    _hasMore = true;

    final repo = ref.read(followRepositoryProvider);
    final result = switch (_listType) {
      FollowListType.following =>
        await repo.getFollowing(userId: _userId, limit: _pageSize),
      FollowListType.followers =>
        await repo.getFollowers(userId: _userId, limit: _pageSize),
    };

    result.fold(
      (failure) => state = AsyncError(failure, StackTrace.current),
      (users) {
        _items = users;
        _hasMore = users.length >= _pageSize;
        state = AsyncData(List.unmodifiable(_items));
      },
    );
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore) return;
    _isLoadingMore = true;

    final cursor = _items.isNotEmpty ? _items.last.id : null;
    final repo = ref.read(followRepositoryProvider);
    final result = switch (_listType) {
      FollowListType.following =>
        await repo.getFollowing(userId: _userId, cursor: cursor, limit: _pageSize),
      FollowListType.followers =>
        await repo.getFollowers(userId: _userId, cursor: cursor, limit: _pageSize),
    };

    result.fold(
      (failure) {},
      (users) {
        _items = [..._items, ...users];
        _hasMore = users.length >= _pageSize;
        state = AsyncData(List.unmodifiable(_items));
      },
    );

    _isLoadingMore = false;
  }
}
