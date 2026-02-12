import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/state/follow_version.dart';
import 'package:shelfie/features/follow/data/follow_repository.dart';
import 'package:shelfie/features/follow/domain/follow_request_model.dart';

part 'follow_request_list_notifier.g.dart';

@riverpod
class FollowRequestListNotifier extends _$FollowRequestListNotifier {
  static const _pageSize = 20;
  List<FollowRequestModel> _items = [];
  bool _hasMore = true;
  bool _isLoadingMore = false;

  @override
  AsyncValue<List<FollowRequestModel>> build() {
    _items = [];
    _hasMore = true;
    _isLoadingMore = false;
    return const AsyncLoading();
  }

  bool get hasMore => _hasMore;
  bool get isLoadingMore => _isLoadingMore;

  Future<void> loadInitial() async {
    state = const AsyncLoading();
    _items = [];
    _hasMore = true;

    final repo = ref.read(followRepositoryProvider);
    final result = await repo.getPendingRequests(limit: _pageSize);

    result.fold(
      (failure) => state = AsyncError(failure, StackTrace.current),
      (requests) {
        _items = requests;
        _hasMore = requests.length >= _pageSize;
        state = AsyncData(List.unmodifiable(_items));
      },
    );
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore) return;
    _isLoadingMore = true;

    final cursor = _items.isNotEmpty ? _items.last.id : null;
    final repo = ref.read(followRepositoryProvider);
    final result = await repo.getPendingRequests(
      cursor: cursor,
      limit: _pageSize,
    );

    result.fold(
      (failure) {},
      (requests) {
        _items = [..._items, ...requests];
        _hasMore = requests.length >= _pageSize;
        state = AsyncData(List.unmodifiable(_items));
      },
    );

    _isLoadingMore = false;
  }

  Future<void> approve(int requestId) async {
    final removedIndex = _items.indexWhere((r) => r.id == requestId);
    if (removedIndex == -1) return;
    final removedItem = _items[removedIndex];

    _items = _items.where((r) => r.id != requestId).toList();
    state = AsyncData(List.unmodifiable(_items));

    final repo = ref.read(followRepositoryProvider);
    final result = await repo.approveFollowRequest(requestId: requestId);

    result.fold(
      (failure) {
        _items = List.from(_items)..insert(removedIndex, removedItem);
        state = AsyncData(List.unmodifiable(_items));
      },
      (_) => ref.read(followVersionProvider.notifier).increment(),
    );
  }

  Future<void> reject(int requestId) async {
    final removedIndex = _items.indexWhere((r) => r.id == requestId);
    if (removedIndex == -1) return;
    final removedItem = _items[removedIndex];

    _items = _items.where((r) => r.id != requestId).toList();
    state = AsyncData(List.unmodifiable(_items));

    final repo = ref.read(followRepositoryProvider);
    final result = await repo.rejectFollowRequest(requestId: requestId);

    result.fold(
      (failure) {
        _items = List.from(_items)..insert(removedIndex, removedItem);
        state = AsyncData(List.unmodifiable(_items));
      },
      (_) => ref.read(followVersionProvider.notifier).increment(),
    );
  }
}
