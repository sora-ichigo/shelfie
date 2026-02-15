import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/state/follow_version.dart';
import 'package:shelfie/features/follow/data/follow_repository.dart';
import 'package:shelfie/features/follow/domain/follow_request_status.dart';
import 'package:shelfie/features/follow/domain/follow_status_type.dart';

part 'follow_state_notifier.g.dart';

typedef FollowDirectionalStatus = ({
  FollowStatusType outgoing,
  FollowStatusType incoming,
});

@Riverpod(keepAlive: true)
class FollowState extends _$FollowState {
  final Set<int> _operatingUsers = {};

  @override
  Map<int, FollowDirectionalStatus> build() => {};

  void registerStatus({
    required int userId,
    required FollowStatusType outgoing,
    required FollowStatusType incoming,
  }) {
    state = {
      ...state,
      userId: (outgoing: outgoing, incoming: incoming),
    };
  }

  Future<void> approveRequest({
    required int userId,
    required int requestId,
  }) async {
    final current = state[userId];
    if (current == null) return;
    if (_operatingUsers.contains(userId)) return;
    _operatingUsers.add(userId);

    final previous = current;
    state = {
      ...state,
      userId: (outgoing: current.outgoing, incoming: FollowStatusType.following),
    };

    final repo = ref.read(followRepositoryProvider);
    final result = await repo.approveFollowRequest(requestId: requestId);

    result.fold(
      (_) => state = {...state, userId: previous},
      (_) => ref.read(followVersionProvider.notifier).increment(),
    );

    _operatingUsers.remove(userId);
  }

  Future<void> rejectRequest({
    required int userId,
    required int requestId,
  }) async {
    final current = state[userId];
    if (current == null) return;
    if (_operatingUsers.contains(userId)) return;
    _operatingUsers.add(userId);

    final previous = current;
    state = {
      ...state,
      userId: (outgoing: current.outgoing, incoming: FollowStatusType.none),
    };

    final repo = ref.read(followRepositoryProvider);
    final result = await repo.rejectFollowRequest(requestId: requestId);

    result.fold(
      (_) => state = {...state, userId: previous},
      (_) => ref.read(followVersionProvider.notifier).increment(),
    );

    _operatingUsers.remove(userId);
  }

  Future<void> sendFollowRequest({
    required int userId,
    bool isTargetPublic = false,
  }) async {
    final current = state[userId];
    if (current == null) return;
    if (_operatingUsers.contains(userId)) return;
    _operatingUsers.add(userId);

    final previous = current;
    state = {
      ...state,
      userId: (
        outgoing: isTargetPublic
            ? FollowStatusType.following
            : FollowStatusType.pendingSent,
        incoming: current.incoming,
      ),
    };

    final repo = ref.read(followRepositoryProvider);
    final result = await repo.sendFollowRequest(receiverId: userId);

    result.fold(
      (_) => state = {...state, userId: previous},
      (followRequest) {
        if (followRequest.status == FollowRequestStatus.approved) {
          state = {
            ...state,
            userId: (outgoing: FollowStatusType.following, incoming: current.incoming),
          };
        }
        ref.read(followVersionProvider.notifier).increment();
      },
    );

    _operatingUsers.remove(userId);
  }

  Future<void> cancelFollowRequest({required int userId}) async {
    final current = state[userId];
    if (current == null) return;
    if (_operatingUsers.contains(userId)) return;
    _operatingUsers.add(userId);

    final previous = current;
    state = {
      ...state,
      userId: (outgoing: FollowStatusType.none, incoming: current.incoming),
    };

    final repo = ref.read(followRepositoryProvider);
    final result = await repo.cancelFollowRequest(targetUserId: userId);

    result.fold(
      (_) => state = {...state, userId: previous},
      (_) => ref.read(followVersionProvider.notifier).increment(),
    );

    _operatingUsers.remove(userId);
  }

  Future<void> unfollow({required int userId}) async {
    final current = state[userId];
    if (current == null) return;
    if (_operatingUsers.contains(userId)) return;
    _operatingUsers.add(userId);

    final previous = current;
    state = {
      ...state,
      userId: (outgoing: FollowStatusType.none, incoming: current.incoming),
    };

    final repo = ref.read(followRepositoryProvider);
    final result = await repo.unfollow(targetUserId: userId);

    result.fold(
      (_) => state = {...state, userId: previous},
      (_) => ref.read(followVersionProvider.notifier).increment(),
    );

    _operatingUsers.remove(userId);
  }
}
