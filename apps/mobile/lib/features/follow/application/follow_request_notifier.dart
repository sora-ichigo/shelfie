import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/state/follow_version.dart';
import 'package:shelfie/features/follow/data/follow_repository.dart';
import 'package:shelfie/features/follow/domain/follow_status_type.dart';

part 'follow_request_notifier.g.dart';

typedef FollowDirectionalStatus = ({FollowStatusType outgoing, FollowStatusType incoming});

@riverpod
class FollowRequestNotifier extends _$FollowRequestNotifier {
  late int _targetUserId;
  bool _isOperating = false;

  @override
  AsyncValue<FollowDirectionalStatus> build(int targetUserId) {
    _targetUserId = targetUserId;
    _isOperating = false;
    return const AsyncData((outgoing: FollowStatusType.none, incoming: FollowStatusType.none));
  }

  void setStatus({
    required FollowStatusType outgoing,
    required FollowStatusType incoming,
  }) {
    state = AsyncData((outgoing: outgoing, incoming: incoming));
  }

  Future<void> approveRequest(int requestId) async {
    if (_isOperating) return;
    _isOperating = true;

    final previous = state;
    final current = state.value!;
    state = AsyncData((outgoing: current.outgoing, incoming: FollowStatusType.following));

    final repo = ref.read(followRepositoryProvider);
    final result = await repo.approveFollowRequest(requestId: requestId);

    result.fold(
      (failure) => state = previous,
      (_) => ref.read(followVersionProvider.notifier).increment(),
    );

    _isOperating = false;
  }

  Future<void> rejectRequest(int requestId) async {
    if (_isOperating) return;
    _isOperating = true;

    final previous = state;
    final current = state.value!;
    state = AsyncData((outgoing: current.outgoing, incoming: FollowStatusType.none));

    final repo = ref.read(followRepositoryProvider);
    final result = await repo.rejectFollowRequest(requestId: requestId);

    result.fold(
      (failure) => state = previous,
      (_) => ref.read(followVersionProvider.notifier).increment(),
    );

    _isOperating = false;
  }

  Future<void> sendFollowRequest() async {
    if (_isOperating) return;
    _isOperating = true;

    final previous = state;
    final current = state.value!;
    state = AsyncData((outgoing: FollowStatusType.pending, incoming: current.incoming));

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
    final current = state.value!;
    state = AsyncData((outgoing: FollowStatusType.none, incoming: current.incoming));

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
    final current = state.value!;
    state = AsyncData((outgoing: FollowStatusType.none, incoming: current.incoming));

    final repo = ref.read(followRepositoryProvider);
    final result = await repo.unfollow(targetUserId: _targetUserId);

    result.fold(
      (failure) => state = previous,
      (_) => ref.read(followVersionProvider.notifier).increment(),
    );

    _isOperating = false;
  }
}
