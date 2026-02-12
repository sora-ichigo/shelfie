import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/state/follow_version.dart';
import 'package:shelfie/features/follow/data/follow_repository.dart';
import 'package:shelfie/features/follow/domain/follow_status_type.dart';

part 'follow_request_notifier.g.dart';

@riverpod
class FollowRequestNotifier extends _$FollowRequestNotifier {
  late int _targetUserId;
  bool _isOperating = false;

  @override
  AsyncValue<FollowStatusType> build(int targetUserId) {
    _targetUserId = targetUserId;
    _isOperating = false;
    return const AsyncData(FollowStatusType.none);
  }

  void setStatus(FollowStatusType status) {
    state = AsyncData(status);
  }

  Future<void> sendFollowRequest() async {
    if (_isOperating) return;
    _isOperating = true;

    final previous = state;
    state = const AsyncData(FollowStatusType.pendingSent);

    final repo = ref.read(followRepositoryProvider);
    final result = await repo.sendFollowRequest(receiverId: _targetUserId);

    result.fold(
      (failure) => state = previous,
      (_) => ref.read(followVersionProvider.notifier).increment(),
    );

    _isOperating = false;
  }

  Future<void> cancelFollowRequest() async {
    if (_isOperating) return;
    _isOperating = true;

    final previous = state;
    state = const AsyncData(FollowStatusType.none);

    final repo = ref.read(followRepositoryProvider);
    final result = await repo.cancelFollowRequest(targetUserId: _targetUserId);

    result.fold(
      (failure) => state = previous,
      (_) => ref.read(followVersionProvider.notifier).increment(),
    );

    _isOperating = false;
  }

  Future<void> unfollow() async {
    if (_isOperating) return;
    _isOperating = true;

    final previous = state;
    state = const AsyncData(FollowStatusType.none);

    final repo = ref.read(followRepositoryProvider);
    final result = await repo.unfollow(targetUserId: _targetUserId);

    result.fold(
      (failure) => state = previous,
      (_) => ref.read(followVersionProvider.notifier).increment(),
    );

    _isOperating = false;
  }
}
