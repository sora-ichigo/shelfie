import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/state/follow_version.dart';
import 'package:shelfie/features/follow/application/follow_request_notifier.dart';
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
      sender: const UserSummary(id: 1, name: null, avatarUrl: null, handle: null),
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

  group('FollowRequestNotifier', () {
    group('initial state', () {
      test('should start with AsyncData(FollowStatusType.none)', () {
        final state = container.read(followRequestNotifierProvider(targetUserId));
        expect(state, const AsyncData(FollowStatusType.none));
      });
    });

    group('setStatus', () {
      test('should update state to the given status', () {
        container
            .read(followRequestNotifierProvider(targetUserId).notifier)
            .setStatus(FollowStatusType.following);

        final state = container.read(followRequestNotifierProvider(targetUserId));
        expect(state, const AsyncData(FollowStatusType.following));
      });
    });

    group('sendFollowRequest', () {
      test('should optimistically set state to pendingSent', () async {
        when(() => mockRepository.sendFollowRequest(receiverId: targetUserId))
            .thenAnswer((_) async => right(createFollowRequest()));

        final notifier = container
            .read(followRequestNotifierProvider(targetUserId).notifier);

        final future = notifier.sendFollowRequest();

        expect(
          container.read(followRequestNotifierProvider(targetUserId)),
          const AsyncData(FollowStatusType.pendingSent),
        );

        await future;
      });

      test('should increment FollowVersion on success', () async {
        when(() => mockRepository.sendFollowRequest(receiverId: targetUserId))
            .thenAnswer((_) async => right(createFollowRequest()));

        final versionBefore = container.read(followVersionProvider);

        await container
            .read(followRequestNotifierProvider(targetUserId).notifier)
            .sendFollowRequest();

        expect(container.read(followVersionProvider), versionBefore + 1);
      });

      test('should rollback state on failure', () async {
        when(() => mockRepository.sendFollowRequest(receiverId: targetUserId))
            .thenAnswer(
          (_) async =>
              left(const NetworkFailure(message: 'No internet connection')),
        );

        final notifier = container
            .read(followRequestNotifierProvider(targetUserId).notifier);
        notifier.setStatus(FollowStatusType.none);

        await notifier.sendFollowRequest();

        expect(
          container.read(followRequestNotifierProvider(targetUserId)),
          const AsyncData(FollowStatusType.none),
        );
      });

      test('should not increment FollowVersion on failure', () async {
        when(() => mockRepository.sendFollowRequest(receiverId: targetUserId))
            .thenAnswer(
          (_) async =>
              left(const NetworkFailure(message: 'No internet connection')),
        );

        final versionBefore = container.read(followVersionProvider);

        await container
            .read(followRequestNotifierProvider(targetUserId).notifier)
            .sendFollowRequest();

        expect(container.read(followVersionProvider), versionBefore);
      });

      test('should prevent duplicate operations', () async {
        final completer = Completer<Either<Failure, FollowRequestModel>>();
        when(() => mockRepository.sendFollowRequest(receiverId: targetUserId))
            .thenAnswer((_) => completer.future);

        final notifier = container
            .read(followRequestNotifierProvider(targetUserId).notifier);

        unawaited(notifier.sendFollowRequest());
        unawaited(notifier.sendFollowRequest());

        completer.complete(right(createFollowRequest()));
        await Future<void>.delayed(Duration.zero);

        verify(() => mockRepository.sendFollowRequest(receiverId: targetUserId))
            .called(1);
      });
    });

    group('unfollow', () {
      test('should optimistically set state to none', () async {
        when(() => mockRepository.unfollow(targetUserId: targetUserId))
            .thenAnswer((_) async => right(null));

        final notifier = container
            .read(followRequestNotifierProvider(targetUserId).notifier);
        notifier.setStatus(FollowStatusType.following);

        final future = notifier.unfollow();

        expect(
          container.read(followRequestNotifierProvider(targetUserId)),
          const AsyncData(FollowStatusType.none),
        );

        await future;
      });

      test('should increment FollowVersion on success', () async {
        when(() => mockRepository.unfollow(targetUserId: targetUserId))
            .thenAnswer((_) async => right(null));

        final notifier = container
            .read(followRequestNotifierProvider(targetUserId).notifier);
        notifier.setStatus(FollowStatusType.following);

        final versionBefore = container.read(followVersionProvider);
        await notifier.unfollow();

        expect(container.read(followVersionProvider), versionBefore + 1);
      });

      test('should rollback state on failure', () async {
        when(() => mockRepository.unfollow(targetUserId: targetUserId))
            .thenAnswer(
          (_) async =>
              left(const NetworkFailure(message: 'No internet connection')),
        );

        final notifier = container
            .read(followRequestNotifierProvider(targetUserId).notifier);
        notifier.setStatus(FollowStatusType.following);

        await notifier.unfollow();

        expect(
          container.read(followRequestNotifierProvider(targetUserId)),
          const AsyncData(FollowStatusType.following),
        );
      });

      test('should prevent duplicate operations', () async {
        final completer = Completer<Either<Failure, void>>();
        when(() => mockRepository.unfollow(targetUserId: targetUserId))
            .thenAnswer((_) => completer.future);

        final notifier = container
            .read(followRequestNotifierProvider(targetUserId).notifier);
        notifier.setStatus(FollowStatusType.following);

        unawaited(notifier.unfollow());
        unawaited(notifier.unfollow());

        completer.complete(right(null));
        await Future<void>.delayed(Duration.zero);

        verify(() => mockRepository.unfollow(targetUserId: targetUserId))
            .called(1);
      });
    });
  });
}
