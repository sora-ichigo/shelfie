import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/state/follow_state_notifier.dart';
import 'package:shelfie/core/state/follow_version.dart';
import 'package:shelfie/features/follow/data/follow_repository.dart';
import 'package:shelfie/features/follow/domain/follow_request_model.dart';
import 'package:shelfie/features/follow/domain/follow_request_status.dart';
import 'package:shelfie/features/follow/domain/follow_status_type.dart';
import 'package:shelfie/features/follow/domain/user_summary.dart';

class MockFollowRepository extends Mock implements FollowRepository {}

void main() {
  late ProviderContainer container;
  late MockFollowRepository mockRepository;

  const targetUserId = 42;

  FollowRequestModel createFollowRequest() {
    return FollowRequestModel(
      id: 1,
      sender: const UserSummary(
        id: 1,
        name: null,
        avatarUrl: null,
        handle: null,
      ),
      receiver: const UserSummary(
        id: targetUserId,
        name: null,
        avatarUrl: null,
        handle: null,
      ),
      status: FollowRequestStatus.pending,
      createdAt: DateTime(2024, 1, 1),
    );
  }

  setUp(() {
    mockRepository = MockFollowRepository();
    container = ProviderContainer(
      overrides: [
        followRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('FollowStateNotifier', () {
    group('initial state', () {
      test('空のMapで初期化されること', () {
        final state = container.read(followStateProvider);
        expect(state, isEmpty);
      });
    });

    group('registerStatus', () {
      test('新しいユーザーのステータスを登録できること', () {
        container.read(followStateProvider.notifier).registerStatus(
              userId: targetUserId,
              outgoing: FollowStatusType.following,
              incoming: FollowStatusType.none,
            );

        final state = container.read(followStateProvider);
        expect(state[targetUserId]?.outgoing, FollowStatusType.following);
        expect(state[targetUserId]?.incoming, FollowStatusType.none);
      });

      test('既存のユーザーのステータスを上書きできること', () {
        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.none,
          incoming: FollowStatusType.none,
        );
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.following,
          incoming: FollowStatusType.following,
        );

        final state = container.read(followStateProvider);
        expect(state[targetUserId]?.outgoing, FollowStatusType.following);
        expect(state[targetUserId]?.incoming, FollowStatusType.following);
      });

      test('複数ユーザーのステータスを独立して管理できること', () {
        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: 1,
          outgoing: FollowStatusType.following,
          incoming: FollowStatusType.none,
        );
        notifier.registerStatus(
          userId: 2,
          outgoing: FollowStatusType.none,
          incoming: FollowStatusType.following,
        );

        final state = container.read(followStateProvider);
        expect(state[1]?.outgoing, FollowStatusType.following);
        expect(state[2]?.incoming, FollowStatusType.following);
      });
    });

    group('approveRequest', () {
      test('楽観的に incoming を following に更新すること', () async {
        when(() => mockRepository.approveFollowRequest(requestId: 100))
            .thenAnswer((_) async => right(createFollowRequest()));

        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.none,
          incoming: FollowStatusType.pendingReceived,
        );

        final future =
            notifier.approveRequest(userId: targetUserId, requestId: 100);

        final state = container.read(followStateProvider);
        expect(state[targetUserId]?.incoming, FollowStatusType.following);
        expect(state[targetUserId]?.outgoing, FollowStatusType.none);

        await future;
      });

      test('成功時に followVersion を increment すること', () async {
        when(() => mockRepository.approveFollowRequest(requestId: 100))
            .thenAnswer((_) async => right(createFollowRequest()));

        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.none,
          incoming: FollowStatusType.pendingReceived,
        );

        final versionBefore = container.read(followVersionProvider);
        await notifier.approveRequest(userId: targetUserId, requestId: 100);
        expect(container.read(followVersionProvider), versionBefore + 1);
      });

      test('失敗時にロールバックすること', () async {
        when(() => mockRepository.approveFollowRequest(requestId: 100))
            .thenAnswer((_) async =>
                left(const NetworkFailure(message: 'Network error')));

        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.none,
          incoming: FollowStatusType.pendingReceived,
        );

        await notifier.approveRequest(userId: targetUserId, requestId: 100);

        final state = container.read(followStateProvider);
        expect(state[targetUserId]?.incoming, FollowStatusType.pendingReceived);
        expect(state[targetUserId]?.outgoing, FollowStatusType.none);
      });

      test('失敗時に followVersion を increment しないこと', () async {
        when(() => mockRepository.approveFollowRequest(requestId: 100))
            .thenAnswer((_) async =>
                left(const NetworkFailure(message: 'Network error')));

        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.none,
          incoming: FollowStatusType.pendingReceived,
        );

        final versionBefore = container.read(followVersionProvider);
        await notifier.approveRequest(userId: targetUserId, requestId: 100);
        expect(container.read(followVersionProvider), versionBefore);
      });

      test('未登録ユーザーへの操作は何もしないこと', () async {
        verifyNever(
            () => mockRepository.approveFollowRequest(requestId: any(named: 'requestId')));
        await container
            .read(followStateProvider.notifier)
            .approveRequest(userId: 999, requestId: 100);
        verifyNever(
            () => mockRepository.approveFollowRequest(requestId: any(named: 'requestId')));
      });
    });

    group('rejectRequest', () {
      test('楽観的に incoming を none に更新すること', () async {
        when(() => mockRepository.rejectFollowRequest(requestId: 100))
            .thenAnswer((_) async => right(createFollowRequest()));

        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.none,
          incoming: FollowStatusType.pendingReceived,
        );

        final future =
            notifier.rejectRequest(userId: targetUserId, requestId: 100);

        final state = container.read(followStateProvider);
        expect(state[targetUserId]?.incoming, FollowStatusType.none);
        expect(state[targetUserId]?.outgoing, FollowStatusType.none);

        await future;
      });

      test('成功時に followVersion を increment すること', () async {
        when(() => mockRepository.rejectFollowRequest(requestId: 100))
            .thenAnswer((_) async => right(createFollowRequest()));

        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.none,
          incoming: FollowStatusType.pendingReceived,
        );

        final versionBefore = container.read(followVersionProvider);
        await notifier.rejectRequest(userId: targetUserId, requestId: 100);
        expect(container.read(followVersionProvider), versionBefore + 1);
      });

      test('失敗時にロールバックすること', () async {
        when(() => mockRepository.rejectFollowRequest(requestId: 100))
            .thenAnswer((_) async =>
                left(const NetworkFailure(message: 'Network error')));

        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.none,
          incoming: FollowStatusType.pendingReceived,
        );

        await notifier.rejectRequest(userId: targetUserId, requestId: 100);

        final state = container.read(followStateProvider);
        expect(state[targetUserId]?.incoming, FollowStatusType.pendingReceived);
      });

      test('未登録ユーザーへの操作は何もしないこと', () async {
        await container
            .read(followStateProvider.notifier)
            .rejectRequest(userId: 999, requestId: 100);
        verifyNever(
            () => mockRepository.rejectFollowRequest(requestId: any(named: 'requestId')));
      });
    });

    group('sendFollowRequest', () {
      test('楽観的に outgoing を pendingSent に更新すること', () async {
        when(() => mockRepository.sendFollowRequest(receiverId: targetUserId))
            .thenAnswer((_) async => right(createFollowRequest()));

        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.none,
          incoming: FollowStatusType.none,
        );

        final future = notifier.sendFollowRequest(userId: targetUserId);

        final state = container.read(followStateProvider);
        expect(state[targetUserId]?.outgoing, FollowStatusType.pendingSent);

        await future;
      });

      test('incoming status を保持すること', () async {
        when(() => mockRepository.sendFollowRequest(receiverId: targetUserId))
            .thenAnswer((_) async => right(createFollowRequest()));

        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.none,
          incoming: FollowStatusType.following,
        );

        final future = notifier.sendFollowRequest(userId: targetUserId);

        final state = container.read(followStateProvider);
        expect(state[targetUserId]?.outgoing, FollowStatusType.pendingSent);
        expect(state[targetUserId]?.incoming, FollowStatusType.following);

        await future;
      });

      test('成功時に followVersion を increment すること', () async {
        when(() => mockRepository.sendFollowRequest(receiverId: targetUserId))
            .thenAnswer((_) async => right(createFollowRequest()));

        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.none,
          incoming: FollowStatusType.none,
        );

        final versionBefore = container.read(followVersionProvider);
        await notifier.sendFollowRequest(userId: targetUserId);
        expect(container.read(followVersionProvider), versionBefore + 1);
      });

      test('失敗時にロールバックすること', () async {
        when(() => mockRepository.sendFollowRequest(receiverId: targetUserId))
            .thenAnswer((_) async =>
                left(const NetworkFailure(message: 'Network error')));

        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.none,
          incoming: FollowStatusType.following,
        );

        await notifier.sendFollowRequest(userId: targetUserId);

        final state = container.read(followStateProvider);
        expect(state[targetUserId]?.outgoing, FollowStatusType.none);
        expect(state[targetUserId]?.incoming, FollowStatusType.following);
      });

      test('重複操作を防止すること', () async {
        final completer = Completer<Either<Failure, FollowRequestModel>>();
        when(() => mockRepository.sendFollowRequest(receiverId: targetUserId))
            .thenAnswer((_) => completer.future);

        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.none,
          incoming: FollowStatusType.none,
        );

        unawaited(notifier.sendFollowRequest(userId: targetUserId));
        unawaited(notifier.sendFollowRequest(userId: targetUserId));

        completer.complete(right(createFollowRequest()));
        await Future<void>.delayed(Duration.zero);

        verify(() => mockRepository.sendFollowRequest(receiverId: targetUserId))
            .called(1);
      });

      test('未登録ユーザーへの操作は何もしないこと', () async {
        await container
            .read(followStateProvider.notifier)
            .sendFollowRequest(userId: 999);
        verifyNever(() =>
            mockRepository.sendFollowRequest(receiverId: any(named: 'receiverId')));
      });

      test('公開アカウントへのフォローで楽観的に outgoing を following に更新すること',
          () async {
        when(() => mockRepository.sendFollowRequest(receiverId: targetUserId))
            .thenAnswer((_) async => right(FollowRequestModel(
                  id: 1,
                  sender: const UserSummary(
                      id: 1, name: null, avatarUrl: null, handle: null),
                  receiver: const UserSummary(
                      id: targetUserId,
                      name: null,
                      avatarUrl: null,
                      handle: null),
                  status: FollowRequestStatus.approved,
                  createdAt: DateTime(2024, 1, 1),
                )));

        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.none,
          incoming: FollowStatusType.none,
        );

        final future = notifier.sendFollowRequest(
            userId: targetUserId, isTargetPublic: true);

        final state = container.read(followStateProvider);
        expect(state[targetUserId]?.outgoing, FollowStatusType.following);

        await future;
      });

      test('公開アカウントへのフォローで incoming を保持すること', () async {
        when(() => mockRepository.sendFollowRequest(receiverId: targetUserId))
            .thenAnswer((_) async => right(FollowRequestModel(
                  id: 1,
                  sender: const UserSummary(
                      id: 1, name: null, avatarUrl: null, handle: null),
                  receiver: const UserSummary(
                      id: targetUserId,
                      name: null,
                      avatarUrl: null,
                      handle: null),
                  status: FollowRequestStatus.approved,
                  createdAt: DateTime(2024, 1, 1),
                )));

        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.none,
          incoming: FollowStatusType.following,
        );

        final future = notifier.sendFollowRequest(
            userId: targetUserId, isTargetPublic: true);

        final state = container.read(followStateProvider);
        expect(state[targetUserId]?.outgoing, FollowStatusType.following);
        expect(state[targetUserId]?.incoming, FollowStatusType.following);

        await future;
      });

      test('公開アカウントへのフォロー失敗時にロールバックすること', () async {
        when(() => mockRepository.sendFollowRequest(receiverId: targetUserId))
            .thenAnswer((_) async =>
                left(const NetworkFailure(message: 'Network error')));

        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.none,
          incoming: FollowStatusType.none,
        );

        await notifier.sendFollowRequest(
            userId: targetUserId, isTargetPublic: true);

        final state = container.read(followStateProvider);
        expect(state[targetUserId]?.outgoing, FollowStatusType.none);
      });
    });

    group('cancelFollowRequest', () {
      test('楽観的に outgoing を none に更新すること', () async {
        when(() =>
                mockRepository.cancelFollowRequest(targetUserId: targetUserId))
            .thenAnswer((_) async => right(null));

        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.pendingSent,
          incoming: FollowStatusType.none,
        );

        final future = notifier.cancelFollowRequest(userId: targetUserId);

        final state = container.read(followStateProvider);
        expect(state[targetUserId]?.outgoing, FollowStatusType.none);

        await future;
      });

      test('incoming status を保持すること', () async {
        when(() =>
                mockRepository.cancelFollowRequest(targetUserId: targetUserId))
            .thenAnswer((_) async => right(null));

        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.pendingSent,
          incoming: FollowStatusType.following,
        );

        await notifier.cancelFollowRequest(userId: targetUserId);

        final state = container.read(followStateProvider);
        expect(state[targetUserId]?.outgoing, FollowStatusType.none);
        expect(state[targetUserId]?.incoming, FollowStatusType.following);
      });

      test('失敗時にロールバックすること', () async {
        when(() =>
                mockRepository.cancelFollowRequest(targetUserId: targetUserId))
            .thenAnswer((_) async =>
                left(const NetworkFailure(message: 'Network error')));

        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.pendingSent,
          incoming: FollowStatusType.following,
        );

        await notifier.cancelFollowRequest(userId: targetUserId);

        final state = container.read(followStateProvider);
        expect(state[targetUserId]?.outgoing, FollowStatusType.pendingSent);
        expect(state[targetUserId]?.incoming, FollowStatusType.following);
      });
    });

    group('unfollow', () {
      test('楽観的に outgoing を none に更新すること', () async {
        when(() => mockRepository.unfollow(targetUserId: targetUserId))
            .thenAnswer((_) async => right(null));

        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.following,
          incoming: FollowStatusType.none,
        );

        final future = notifier.unfollow(userId: targetUserId);

        final state = container.read(followStateProvider);
        expect(state[targetUserId]?.outgoing, FollowStatusType.none);

        await future;
      });

      test('incoming status を保持すること', () async {
        when(() => mockRepository.unfollow(targetUserId: targetUserId))
            .thenAnswer((_) async => right(null));

        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.following,
          incoming: FollowStatusType.following,
        );

        await notifier.unfollow(userId: targetUserId);

        final state = container.read(followStateProvider);
        expect(state[targetUserId]?.outgoing, FollowStatusType.none);
        expect(state[targetUserId]?.incoming, FollowStatusType.following);
      });

      test('成功時に followVersion を increment すること', () async {
        when(() => mockRepository.unfollow(targetUserId: targetUserId))
            .thenAnswer((_) async => right(null));

        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.following,
          incoming: FollowStatusType.none,
        );

        final versionBefore = container.read(followVersionProvider);
        await notifier.unfollow(userId: targetUserId);
        expect(container.read(followVersionProvider), versionBefore + 1);
      });

      test('失敗時にロールバックすること', () async {
        when(() => mockRepository.unfollow(targetUserId: targetUserId))
            .thenAnswer((_) async =>
                left(const NetworkFailure(message: 'Network error')));

        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.following,
          incoming: FollowStatusType.following,
        );

        await notifier.unfollow(userId: targetUserId);

        final state = container.read(followStateProvider);
        expect(state[targetUserId]?.outgoing, FollowStatusType.following);
        expect(state[targetUserId]?.incoming, FollowStatusType.following);
      });

      test('重複操作を防止すること', () async {
        final completer = Completer<Either<Failure, void>>();
        when(() => mockRepository.unfollow(targetUserId: targetUserId))
            .thenAnswer((_) => completer.future);

        final notifier = container.read(followStateProvider.notifier);
        notifier.registerStatus(
          userId: targetUserId,
          outgoing: FollowStatusType.following,
          incoming: FollowStatusType.none,
        );

        unawaited(notifier.unfollow(userId: targetUserId));
        unawaited(notifier.unfollow(userId: targetUserId));

        completer.complete(right(null));
        await Future<void>.delayed(Duration.zero);

        verify(() => mockRepository.unfollow(targetUserId: targetUserId))
            .called(1);
      });

      test('未登録ユーザーへの操作は何もしないこと', () async {
        await container
            .read(followStateProvider.notifier)
            .unfollow(userId: 999);
        verifyNever(() =>
            mockRepository.unfollow(targetUserId: any(named: 'targetUserId')));
      });
    });
  });
}
