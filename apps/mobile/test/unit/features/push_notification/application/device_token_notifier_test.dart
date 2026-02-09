import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/features/push_notification/application/device_token_notifier.dart';
import 'package:shelfie/features/push_notification/data/device_token_repository.dart';

import '../../../../helpers/test_helpers.dart';

class MockDeviceTokenRepository extends Mock
    implements DeviceTokenRepository {}

class MockFirebaseMessagingWrapper extends Mock
    implements FirebaseMessagingWrapper {}

void main() {
  late MockDeviceTokenRepository mockRepository;
  late MockFirebaseMessagingWrapper mockMessaging;

  setUp(() {
    mockRepository = MockDeviceTokenRepository();
    mockMessaging = MockFirebaseMessagingWrapper();
  });

  group('DeviceTokenNotifier', () {
    test('ログイン時にトークンを取得して API に登録する', () async {
      when(() => mockMessaging.getToken())
          .thenAnswer((_) async => 'fcm-token-123');
      when(() => mockMessaging.getPlatform()).thenReturn('ios');
      when(() => mockMessaging.onTokenRefresh)
          .thenAnswer((_) => const Stream<String>.empty());
      when(
        () => mockRepository.registerToken(
          token: any(named: 'token'),
          platform: any(named: 'platform'),
        ),
      ).thenAnswer((_) async => right(null));

      final container = createTestContainer(
        overrides: [
          deviceTokenRepositoryProvider.overrideWithValue(mockRepository),
          firebaseMessagingWrapperProvider.overrideWithValue(mockMessaging),
          deviceTokenNotifierProvider
              .overrideWith(() => DeviceTokenNotifier()),
        ],
      );
      addTearDown(container.dispose);

      await container.read(authStateProvider.notifier).login(
            userId: 'user-123',
            email: 'test@example.com',
            token: 'test-token',
            refreshToken: 'test-refresh-token',
          );

      final notifier = container.read(deviceTokenNotifierProvider.notifier);
      await notifier.syncToken();

      verify(
        () => mockRepository.registerToken(
          token: 'fcm-token-123',
          platform: 'ios',
        ),
      ).called(1);
    });

    test('トークン更新時に API に再登録する', () async {
      final tokenController = StreamController<String>.broadcast();
      addTearDown(tokenController.close);

      when(() => mockMessaging.getToken())
          .thenAnswer((_) async => 'fcm-token-123');
      when(() => mockMessaging.getPlatform()).thenReturn('ios');
      when(() => mockMessaging.onTokenRefresh)
          .thenAnswer((_) => tokenController.stream);
      when(
        () => mockRepository.registerToken(
          token: any(named: 'token'),
          platform: any(named: 'platform'),
        ),
      ).thenAnswer((_) async => right(null));

      final container = createTestContainer(
        overrides: [
          deviceTokenRepositoryProvider.overrideWithValue(mockRepository),
          firebaseMessagingWrapperProvider.overrideWithValue(mockMessaging),
          deviceTokenNotifierProvider
              .overrideWith(() => DeviceTokenNotifier()),
        ],
      );
      addTearDown(container.dispose);

      await container.read(authStateProvider.notifier).login(
            userId: 'user-123',
            email: 'test@example.com',
            token: 'test-token',
            refreshToken: 'test-refresh-token',
          );

      final notifier = container.read(deviceTokenNotifierProvider.notifier);
      await notifier.syncToken();

      tokenController.add('new-fcm-token-456');
      await Future<void>.delayed(Duration.zero);

      verify(
        () => mockRepository.registerToken(
          token: 'new-fcm-token-456',
          platform: 'ios',
        ),
      ).called(1);
    });

    test('ログアウト時にトークン登録を解除する', () async {
      when(() => mockMessaging.getToken())
          .thenAnswer((_) async => 'fcm-token-123');
      when(() => mockMessaging.getPlatform()).thenReturn('ios');
      when(() => mockMessaging.onTokenRefresh)
          .thenAnswer((_) => const Stream<String>.empty());
      when(
        () => mockRepository.registerToken(
          token: any(named: 'token'),
          platform: any(named: 'platform'),
        ),
      ).thenAnswer((_) async => right(null));
      when(
        () => mockRepository.unregisterToken(
          token: any(named: 'token'),
        ),
      ).thenAnswer((_) async => right(null));

      final container = createTestContainer(
        overrides: [
          deviceTokenRepositoryProvider.overrideWithValue(mockRepository),
          firebaseMessagingWrapperProvider.overrideWithValue(mockMessaging),
          deviceTokenNotifierProvider
              .overrideWith(() => DeviceTokenNotifier()),
        ],
      );
      addTearDown(container.dispose);

      await container.read(authStateProvider.notifier).login(
            userId: 'user-123',
            email: 'test@example.com',
            token: 'test-token',
            refreshToken: 'test-refresh-token',
          );

      final notifier = container.read(deviceTokenNotifierProvider.notifier);
      await notifier.syncToken();
      await notifier.unregisterCurrentToken();

      verify(
        () => mockRepository.unregisterToken(token: 'fcm-token-123'),
      ).called(1);
    });

    test('通知許可拒否時（トークンが null）は登録をスキップする', () async {
      when(() => mockMessaging.getToken()).thenAnswer((_) async => null);
      when(() => mockMessaging.getPlatform()).thenReturn('ios');
      when(() => mockMessaging.onTokenRefresh)
          .thenAnswer((_) => const Stream<String>.empty());

      final container = createTestContainer(
        overrides: [
          deviceTokenRepositoryProvider.overrideWithValue(mockRepository),
          firebaseMessagingWrapperProvider.overrideWithValue(mockMessaging),
          deviceTokenNotifierProvider
              .overrideWith(() => DeviceTokenNotifier()),
        ],
      );
      addTearDown(container.dispose);

      await container.read(authStateProvider.notifier).login(
            userId: 'user-123',
            email: 'test@example.com',
            token: 'test-token',
            refreshToken: 'test-refresh-token',
          );

      final notifier = container.read(deviceTokenNotifierProvider.notifier);
      await notifier.syncToken();

      verifyNever(
        () => mockRepository.registerToken(
          token: any(named: 'token'),
          platform: any(named: 'platform'),
        ),
      );
    });

    test('登録失敗時にエラーをハンドリングする', () async {
      when(() => mockMessaging.getToken())
          .thenAnswer((_) async => 'fcm-token-123');
      when(() => mockMessaging.getPlatform()).thenReturn('ios');
      when(() => mockMessaging.onTokenRefresh)
          .thenAnswer((_) => const Stream<String>.empty());
      when(
        () => mockRepository.registerToken(
          token: any(named: 'token'),
          platform: any(named: 'platform'),
        ),
      ).thenAnswer(
        (_) async => left(
          const NetworkFailure(message: 'No internet connection'),
        ),
      );

      final container = createTestContainer(
        overrides: [
          deviceTokenRepositoryProvider.overrideWithValue(mockRepository),
          firebaseMessagingWrapperProvider.overrideWithValue(mockMessaging),
          deviceTokenNotifierProvider
              .overrideWith(() => DeviceTokenNotifier()),
        ],
      );
      addTearDown(container.dispose);

      await container.read(authStateProvider.notifier).login(
            userId: 'user-123',
            email: 'test@example.com',
            token: 'test-token',
            refreshToken: 'test-refresh-token',
          );

      final notifier = container.read(deviceTokenNotifierProvider.notifier);
      await expectLater(notifier.syncToken(), completes);
    });
  });
}
