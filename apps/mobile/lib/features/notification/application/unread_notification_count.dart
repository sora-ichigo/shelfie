import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/state/follow_version.dart';
import 'package:shelfie/features/notification/data/notification_repository.dart';

part 'unread_notification_count.g.dart';

@Riverpod(keepAlive: true)
class UnreadNotificationCount extends _$UnreadNotificationCount {
  @override
  AsyncValue<int> build() {
    ref.listen(followVersionProvider, (_, __) {
      refresh();
    });
    return const AsyncData(0);
  }

  Future<void> refresh() async {
    final repo = ref.read(notificationRepositoryProvider);
    final result = await repo.getUnreadCount();

    result.fold(
      (_) {},
      (count) => state = AsyncData(count),
    );
  }

  void reset() {
    state = const AsyncData(0);
  }
}
