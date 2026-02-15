import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/features/notification/data/notification_repository.dart';
import 'package:shelfie/features/notification/domain/notification_model.dart';

part 'notification_list_notifier.g.dart';

@riverpod
class NotificationListNotifier extends _$NotificationListNotifier {
  static const _pageSize = 20;
  List<NotificationModel> _items = [];
  bool _hasMore = true;
  bool _isLoadingMore = false;

  @override
  AsyncValue<List<NotificationModel>> build() {
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

    final repo = ref.read(notificationRepositoryProvider);
    final result = await repo.getNotifications(limit: _pageSize);

    result.fold(
      (failure) => state = AsyncError(failure, StackTrace.current),
      (notifications) {
        _items = notifications;
        _hasMore = notifications.length >= _pageSize;
        state = AsyncData(List.unmodifiable(_items));
      },
    );
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore) return;
    _isLoadingMore = true;

    final cursor = _items.isNotEmpty ? _items.last.id : null;
    final repo = ref.read(notificationRepositoryProvider);
    final result = await repo.getNotifications(
      cursor: cursor,
      limit: _pageSize,
    );

    result.fold(
      (failure) {},
      (notifications) {
        _items = [..._items, ...notifications];
        _hasMore = notifications.length >= _pageSize;
        state = AsyncData(List.unmodifiable(_items));
      },
    );

    _isLoadingMore = false;
  }

  void removeNotification(int notificationId) {
    _items = _items.where((n) => n.id != notificationId).toList();
    state = AsyncData(List.unmodifiable(_items));
  }

  Future<void> markAsReadById(int notificationId) async {
    final index = _items.indexWhere((n) => n.id == notificationId);
    if (index != -1 && !_items[index].isRead) {
      _items = [
        ..._items.sublist(0, index),
        _items[index].copyWith(isRead: true),
        ..._items.sublist(index + 1),
      ];
      state = AsyncData(List.unmodifiable(_items));
    }

    final repo = ref.read(notificationRepositoryProvider);
    await repo.markAsRead(notificationId);
  }
}
