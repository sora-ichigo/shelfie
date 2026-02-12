import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/state/follow_version.dart';
import 'package:shelfie/features/follow/application/follow_request_list_notifier.dart';
import 'package:shelfie/features/follow/data/follow_repository.dart';
import 'package:shelfie/features/follow/domain/follow_request_model.dart';
import 'package:shelfie/features/follow/domain/follow_request_status.dart';
import 'package:shelfie/features/follow/domain/user_summary.dart';

class MockFollowRepository extends Mock implements FollowRepository {}

void main() {
  late ProviderContainer container;
  late MockFollowRepository mockRepository;

  FollowRequestModel createRequest({required int id}) {
    return FollowRequestModel(
      id: id,
      sender: UserSummary(id: id * 10, name: 'User $id', avatarUrl: null, handle: 'user$id'),
      receiver: const UserSummary(id: 1, name: 'Me', avatarUrl: null, handle: 'me'),
      status: FollowRequestStatus.pending,
      createdAt: DateTime(2024, 1, id),
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

  group('FollowRequestListNotifier', () {
    group('loadInitial', () {
      test('should load pending requests', () async {
        final requests = [createRequest(id: 1), createRequest(id: 2)];
        when(() => mockRepository.getPendingRequests(limit: 20))
            .thenAnswer((_) async => right(requests));

        final notifier =
            container.read(followRequestListNotifierProvider.notifier);
        await notifier.loadInitial();

        final state = container.read(followRequestListNotifierProvider);
        expect(state.value, hasLength(2));
      });

      test('should set hasMore to true when page is full', () async {
        final requests = List.generate(20, (i) => createRequest(id: i + 1));
        when(() => mockRepository.getPendingRequests(limit: 20))
            .thenAnswer((_) async => right(requests));

        final notifier =
            container.read(followRequestListNotifierProvider.notifier);
        await notifier.loadInitial();

        expect(notifier.hasMore, isTrue);
      });

      test('should set hasMore to false when page is not full', () async {
        final requests = [createRequest(id: 1)];
        when(() => mockRepository.getPendingRequests(limit: 20))
            .thenAnswer((_) async => right(requests));

        final notifier =
            container.read(followRequestListNotifierProvider.notifier);
        await notifier.loadInitial();

        expect(notifier.hasMore, isFalse);
      });

      test('should set error state on failure', () async {
        when(() => mockRepository.getPendingRequests(limit: 20)).thenAnswer(
          (_) async => left(const NetworkFailure(message: 'error')),
        );

        final notifier =
            container.read(followRequestListNotifierProvider.notifier);
        await notifier.loadInitial();

        final state = container.read(followRequestListNotifierProvider);
        expect(state.hasError, isTrue);
      });
    });

    group('loadMore', () {
      test('should append items to list', () async {
        final page1 = List.generate(20, (i) => createRequest(id: i + 1));
        final page2 = [createRequest(id: 21)];

        when(() => mockRepository.getPendingRequests(limit: 20))
            .thenAnswer((_) async => right(page1));
        when(() => mockRepository.getPendingRequests(cursor: 20, limit: 20))
            .thenAnswer((_) async => right(page2));

        final notifier =
            container.read(followRequestListNotifierProvider.notifier);
        await notifier.loadInitial();
        await notifier.loadMore();

        final state = container.read(followRequestListNotifierProvider);
        expect(state.value, hasLength(21));
      });

      test('should not load when hasMore is false', () async {
        final requests = [createRequest(id: 1)];
        when(() => mockRepository.getPendingRequests(limit: 20))
            .thenAnswer((_) async => right(requests));

        final notifier =
            container.read(followRequestListNotifierProvider.notifier);
        await notifier.loadInitial();
        clearInteractions(mockRepository);

        await notifier.loadMore();

        verifyNever(
          () => mockRepository.getPendingRequests(
            cursor: any(named: 'cursor'),
            limit: any(named: 'limit'),
          ),
        );
      });
    });

    group('approve', () {
      test('should remove item from list immediately', () async {
        final requests = [createRequest(id: 1), createRequest(id: 2)];
        when(() => mockRepository.getPendingRequests(limit: 20))
            .thenAnswer((_) async => right(requests));
        when(() => mockRepository.approveFollowRequest(requestId: 1))
            .thenAnswer((_) async => right(createRequest(id: 1)));

        final notifier =
            container.read(followRequestListNotifierProvider.notifier);
        await notifier.loadInitial();

        await notifier.approve(1);

        final state = container.read(followRequestListNotifierProvider);
        expect(state.value, hasLength(1));
        expect(state.value!.first.id, 2);
      });

      test('should increment FollowVersion on success', () async {
        final requests = [createRequest(id: 1)];
        when(() => mockRepository.getPendingRequests(limit: 20))
            .thenAnswer((_) async => right(requests));
        when(() => mockRepository.approveFollowRequest(requestId: 1))
            .thenAnswer((_) async => right(createRequest(id: 1)));

        final notifier =
            container.read(followRequestListNotifierProvider.notifier);
        await notifier.loadInitial();

        final versionBefore = container.read(followVersionProvider);
        await notifier.approve(1);

        expect(container.read(followVersionProvider), versionBefore + 1);
      });

      test('should rollback on failure', () async {
        final requests = [createRequest(id: 1), createRequest(id: 2)];
        when(() => mockRepository.getPendingRequests(limit: 20))
            .thenAnswer((_) async => right(requests));
        when(() => mockRepository.approveFollowRequest(requestId: 1))
            .thenAnswer(
          (_) async => left(const NetworkFailure(message: 'error')),
        );

        final notifier =
            container.read(followRequestListNotifierProvider.notifier);
        await notifier.loadInitial();

        await notifier.approve(1);

        final state = container.read(followRequestListNotifierProvider);
        expect(state.value, hasLength(2));
      });

      test('should not increment FollowVersion on failure', () async {
        final requests = [createRequest(id: 1)];
        when(() => mockRepository.getPendingRequests(limit: 20))
            .thenAnswer((_) async => right(requests));
        when(() => mockRepository.approveFollowRequest(requestId: 1))
            .thenAnswer(
          (_) async => left(const NetworkFailure(message: 'error')),
        );

        final notifier =
            container.read(followRequestListNotifierProvider.notifier);
        await notifier.loadInitial();

        final versionBefore = container.read(followVersionProvider);
        await notifier.approve(1);

        expect(container.read(followVersionProvider), versionBefore);
      });
    });

    group('reject', () {
      test('should remove item from list immediately', () async {
        final requests = [createRequest(id: 1), createRequest(id: 2)];
        when(() => mockRepository.getPendingRequests(limit: 20))
            .thenAnswer((_) async => right(requests));
        when(() => mockRepository.rejectFollowRequest(requestId: 1))
            .thenAnswer((_) async => right(createRequest(id: 1)));

        final notifier =
            container.read(followRequestListNotifierProvider.notifier);
        await notifier.loadInitial();

        await notifier.reject(1);

        final state = container.read(followRequestListNotifierProvider);
        expect(state.value, hasLength(1));
        expect(state.value!.first.id, 2);
      });

      test('should increment FollowVersion on success', () async {
        final requests = [createRequest(id: 1)];
        when(() => mockRepository.getPendingRequests(limit: 20))
            .thenAnswer((_) async => right(requests));
        when(() => mockRepository.rejectFollowRequest(requestId: 1))
            .thenAnswer((_) async => right(createRequest(id: 1)));

        final notifier =
            container.read(followRequestListNotifierProvider.notifier);
        await notifier.loadInitial();

        final versionBefore = container.read(followVersionProvider);
        await notifier.reject(1);

        expect(container.read(followVersionProvider), versionBefore + 1);
      });

      test('should rollback on failure', () async {
        final requests = [createRequest(id: 1), createRequest(id: 2)];
        when(() => mockRepository.getPendingRequests(limit: 20))
            .thenAnswer((_) async => right(requests));
        when(() => mockRepository.rejectFollowRequest(requestId: 1))
            .thenAnswer(
          (_) async => left(const NetworkFailure(message: 'error')),
        );

        final notifier =
            container.read(followRequestListNotifierProvider.notifier);
        await notifier.loadInitial();

        await notifier.reject(1);

        final state = container.read(followRequestListNotifierProvider);
        expect(state.value, hasLength(2));
      });
    });
  });
}
