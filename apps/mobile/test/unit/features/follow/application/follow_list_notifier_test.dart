import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/state/follow_version.dart';
import 'package:shelfie/features/follow/application/follow_list_notifier.dart';
import 'package:shelfie/features/follow/data/follow_repository.dart';
import 'package:shelfie/features/follow/domain/follow_list_type.dart';
import 'package:shelfie/features/follow/domain/user_summary.dart';

class MockFollowRepository extends Mock implements FollowRepository {}

void main() {
  late ProviderContainer container;
  late MockFollowRepository mockRepository;

  const userId = 1;

  UserSummary createUser({required int id}) {
    return UserSummary(
      id: id,
      name: 'User $id',
      avatarUrl: null,
      handle: 'user$id',
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

  group('FollowListNotifier (following)', () {
    group('loadInitial', () {
      test('should load following list', () async {
        final users = [createUser(id: 10), createUser(id: 20)];
        when(() => mockRepository.getFollowing(
              userId: userId,
              limit: 20,
            )).thenAnswer((_) async => right(users));

        final notifier = container.read(
          followListNotifierProvider(userId, FollowListType.following).notifier,
        );
        await notifier.loadInitial();

        final state = container.read(
          followListNotifierProvider(userId, FollowListType.following),
        );
        expect(state.value, hasLength(2));
      });

      test('should set hasMore to true when page is full', () async {
        final users = List.generate(20, (i) => createUser(id: i + 1));
        when(() => mockRepository.getFollowing(
              userId: userId,
              limit: 20,
            )).thenAnswer((_) async => right(users));

        final notifier = container.read(
          followListNotifierProvider(userId, FollowListType.following).notifier,
        );
        await notifier.loadInitial();

        expect(notifier.hasMore, isTrue);
      });

      test('should set hasMore to false when page is not full', () async {
        final users = [createUser(id: 10)];
        when(() => mockRepository.getFollowing(
              userId: userId,
              limit: 20,
            )).thenAnswer((_) async => right(users));

        final notifier = container.read(
          followListNotifierProvider(userId, FollowListType.following).notifier,
        );
        await notifier.loadInitial();

        expect(notifier.hasMore, isFalse);
      });

      test('should set error state on failure', () async {
        when(() => mockRepository.getFollowing(
              userId: userId,
              limit: 20,
            )).thenAnswer(
          (_) async => left(const NetworkFailure(message: 'error')),
        );

        final notifier = container.read(
          followListNotifierProvider(userId, FollowListType.following).notifier,
        );
        await notifier.loadInitial();

        final state = container.read(
          followListNotifierProvider(userId, FollowListType.following),
        );
        expect(state.hasError, isTrue);
      });
    });

    group('loadMore', () {
      test('should append items to list', () async {
        final page1 = List.generate(20, (i) => createUser(id: i + 1));
        final page2 = [createUser(id: 21)];

        when(() => mockRepository.getFollowing(userId: userId, limit: 20))
            .thenAnswer((_) async => right(page1));
        when(() => mockRepository.getFollowing(
              userId: userId,
              cursor: 20,
              limit: 20,
            )).thenAnswer((_) async => right(page2));

        final notifier = container.read(
          followListNotifierProvider(userId, FollowListType.following).notifier,
        );
        await notifier.loadInitial();
        await notifier.loadMore();

        final state = container.read(
          followListNotifierProvider(userId, FollowListType.following),
        );
        expect(state.value, hasLength(21));
      });
    });

    group('refresh', () {
      test('should reload data when loadInitial is called again', () async {
        final users = [createUser(id: 10)];
        when(() => mockRepository.getFollowing(userId: userId, limit: 20))
            .thenAnswer((_) async => right(users));

        final notifier = container.read(
          followListNotifierProvider(userId, FollowListType.following).notifier,
        );
        await notifier.loadInitial();

        final updatedUsers = [createUser(id: 10), createUser(id: 20)];
        when(() => mockRepository.getFollowing(userId: userId, limit: 20))
            .thenAnswer((_) async => right(updatedUsers));

        await notifier.loadInitial();

        final state = container.read(
          followListNotifierProvider(userId, FollowListType.following),
        );
        expect(state.value, hasLength(2));
      });

      test('should call loadInitial when FollowVersion changes', () async {
        when(() => mockRepository.getFollowing(userId: userId, limit: 20))
            .thenAnswer((_) async => right([]));

        container.read(
          followListNotifierProvider(userId, FollowListType.following).notifier,
        );

        container.read(followVersionProvider.notifier).increment();
        await Future<void>.delayed(const Duration(milliseconds: 50));

        verify(() => mockRepository.getFollowing(userId: userId, limit: 20))
            .called(1);
      });
    });
  });

  group('FollowListNotifier (followers)', () {
    group('loadInitial', () {
      test('should load followers list', () async {
        final users = [createUser(id: 10), createUser(id: 20)];
        when(() => mockRepository.getFollowers(
              userId: userId,
              limit: 20,
            )).thenAnswer((_) async => right(users));

        final notifier = container.read(
          followListNotifierProvider(userId, FollowListType.followers).notifier,
        );
        await notifier.loadInitial();

        final state = container.read(
          followListNotifierProvider(userId, FollowListType.followers),
        );
        expect(state.value, hasLength(2));
      });
    });
  });
}
