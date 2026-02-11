import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/state/shelf_version.dart';
import 'package:shelfie/features/account/data/account_repository.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';
import 'package:shelfie/features/profile/application/profile_notifier.dart';

class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  late MockAccountRepository mockRepository;

  setUp(() {
    mockRepository = MockAccountRepository();
  });

  UserProfile createTestProfile({
    int readingCount = 3,
    int backlogCount = 5,
    int completedCount = 6,
    int interestedCount = 1,
  }) {
    return UserProfile(
      id: 1,
      email: 'test@example.com',
      name: 'Test User',
      avatarUrl: 'https://example.com/avatar.png',
      username: '@testuser',
      bookCount: 15,
      readingCount: readingCount,
      backlogCount: backlogCount,
      completedCount: completedCount,
      interestedCount: interestedCount,
      readingStartYear: 2020,
      readingStartMonth: 1,
      createdAt: DateTime(2020, 1, 1),
    );
  }

  group('ProfileNotifier', () {
    test('初期状態は AsyncLoading', () async {
      when(() => mockRepository.getMyProfile()).thenAnswer(
        (_) async => right(createTestProfile()),
      );

      final container = ProviderContainer(
        overrides: [
          accountRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);

      final state = container.read(profileNotifierProvider);
      expect(state, isA<AsyncLoading<UserProfile>>());
    });

    test('プロフィール取得成功時は AsyncData を返す', () async {
      final profile = createTestProfile();
      when(() => mockRepository.getMyProfile()).thenAnswer(
        (_) async => right(profile),
      );

      final container = ProviderContainer(
        overrides: [
          accountRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);

      await container.read(profileNotifierProvider.future);
      final state = container.read(profileNotifierProvider);

      expect(state, isA<AsyncData<UserProfile>>());
      expect(state.value, equals(profile));
      expect(state.value?.readingCount, equals(3));
      expect(state.value?.backlogCount, equals(5));
      expect(state.value?.completedCount, equals(6));
      expect(state.value?.interestedCount, equals(1));
    });

    test('プロフィール取得失敗時は AsyncError を返す', () async {
      const failure = ServerFailure(
        message: 'Server error',
        code: 'SERVER_ERROR',
      );
      when(() => mockRepository.getMyProfile()).thenAnswer(
        (_) async => left(failure),
      );

      final container = ProviderContainer(
        overrides: [
          accountRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );
      addTearDown(container.dispose);

      try {
        await container.read(profileNotifierProvider.future);
      } catch (_) {}

      final state = container.read(profileNotifierProvider);
      expect(state, isA<AsyncError<UserProfile>>());
    });

    group('shelfVersion 連動', () {
      test('shelfVersion が変わったときプロフィールが再取得される', () async {
        final profile = createTestProfile();
        when(() => mockRepository.getMyProfile()).thenAnswer(
          (_) async => right(profile),
        );

        final container = ProviderContainer(
          overrides: [
            accountRepositoryProvider.overrideWithValue(mockRepository),
          ],
        );
        addTearDown(container.dispose);

        await container.read(profileNotifierProvider.future);
        verify(() => mockRepository.getMyProfile()).called(1);

        final updatedProfile = profile.copyWith(
          readingCount: 4,
          completedCount: 7,
        );
        when(() => mockRepository.getMyProfile()).thenAnswer(
          (_) async => right(updatedProfile),
        );

        container.read(shelfVersionProvider.notifier).increment();
        await container.read(profileNotifierProvider.future);

        verify(() => mockRepository.getMyProfile()).called(1);
        final state = container.read(profileNotifierProvider);
        expect(state.value?.readingCount, 4);
        expect(state.value?.completedCount, 7);
      });
    });
  });
}
