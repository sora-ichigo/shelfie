import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/state/shelf_version.dart';
import 'package:shelfie/features/account/application/account_notifier.dart';
import 'package:shelfie/features/account/data/account_repository.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';

class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  late MockAccountRepository mockRepository;

  setUp(() {
    mockRepository = MockAccountRepository();
  });

  UserProfile createTestProfile() {
    return UserProfile(
      id: 1,
      email: 'test@example.com',
      name: 'Test User',
      avatarUrl: 'https://example.com/avatar.png',
      handle: '@testuser',
      bookCount: 10,
      bio: null,
      instagramHandle: null,
      shareUrl: null,
      readingStartYear: 2020,
      readingStartMonth: 1,
      createdAt: DateTime(2020, 1, 1),
    );
  }

  group('AccountNotifier', () {
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

      final state = container.read(accountNotifierProvider);
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

      await container.read(accountNotifierProvider.future);
      final state = container.read(accountNotifierProvider);

      expect(state, isA<AsyncData<UserProfile>>());
      expect(state.value, equals(profile));
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
        await container.read(accountNotifierProvider.future);
      } catch (_) {}

      final state = container.read(accountNotifierProvider);
      expect(state, isA<AsyncError<UserProfile>>());
    });

    group('refresh', () {
      test('refresh でプロフィールを再取得できる', () async {
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

        await container.read(accountNotifierProvider.future);

        final updatedProfile = profile.copyWith(name: 'Updated Name');
        when(() => mockRepository.getMyProfile()).thenAnswer(
          (_) async => right(updatedProfile),
        );

        await container.read(accountNotifierProvider.notifier).refresh();

        final state = container.read(accountNotifierProvider);
        expect(state.value?.name, equals('Updated Name'));
      });

      test('refresh 失敗時はエラー状態になる', () async {
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

        await container.read(accountNotifierProvider.future);

        const failure = NetworkFailure(message: 'Network error');
        when(() => mockRepository.getMyProfile()).thenAnswer(
          (_) async => left(failure),
        );

        await container.read(accountNotifierProvider.notifier).refresh();

        final state = container.read(accountNotifierProvider);
        expect(state, isA<AsyncError<UserProfile>>());
      });
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

        // listen でプロバイダを維持
        container.listen(
          accountNotifierProvider,
          (_, __) {},
          fireImmediately: true,
        );
        await container.read(accountNotifierProvider.future);
        verify(() => mockRepository.getMyProfile()).called(1);

        final updatedProfile = profile.copyWith(bookCount: 5);
        when(() => mockRepository.getMyProfile()).thenAnswer(
          (_) async => right(updatedProfile),
        );

        container.read(shelfVersionProvider.notifier).increment();

        // build() はキャッシュを即座に返し、バックグラウンドで再取得する
        await Future<void>.delayed(Duration.zero);

        verify(() => mockRepository.getMyProfile()).called(1);
        final state = container.read(accountNotifierProvider);
        expect(state.value?.bookCount, 5);
      });
    });
  });
}
