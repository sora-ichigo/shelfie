import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/state/follow_version.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/storage/secure_storage_service.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/notification/application/unread_notification_count.dart';
import 'package:shelfie/features/push_notification/application/device_token_notifier.dart';

import '../../../helpers/test_helpers.dart';

class SpyDeviceTokenNotifier extends DeviceTokenNotifier {
  int syncTokenCallCount = 0;

  @override
  DeviceTokenState build() => DeviceTokenState.idle;

  @override
  Future<void> syncToken() async {
    syncTokenCallCount++;
  }

  @override
  Future<void> unregisterCurrentToken() async {}
}

class FailingDeviceTokenNotifier extends DeviceTokenNotifier {
  @override
  DeviceTokenState build() => DeviceTokenState.idle;

  @override
  Future<void> syncToken() async {
    throw Exception('Token sync failed');
  }

  @override
  Future<void> unregisterCurrentToken() async {}
}

void main() {
  setUpAll(registerTestFallbackValues);

  group('AuthStateData', () {
    test('initial 状態は未認証かつ非ゲスト', () {
      const state = AuthStateData.initial();
      expect(state.isAuthenticated, isFalse);
      expect(state.isGuest, isFalse);
      expect(state.userId, isNull);
      expect(state.email, isNull);
      expect(state.token, isNull);
    });

    test('authenticated 状態を作成できる', () {
      const state = AuthStateData(
        isAuthenticated: true,
        userId: 'user-123',
        email: 'test@example.com',
        token: 'test-token',
      );
      expect(state.isAuthenticated, isTrue);
      expect(state.isGuest, isFalse);
      expect(state.userId, equals('user-123'));
      expect(state.email, equals('test@example.com'));
      expect(state.token, equals('test-token'));
    });

    test('guest 状態を作成できる', () {
      const state = AuthStateData(isGuest: true);
      expect(state.isGuest, isTrue);
      expect(state.isAuthenticated, isFalse);
      expect(state.userId, isNull);
      expect(state.email, isNull);
      expect(state.token, isNull);
      expect(state.refreshToken, isNull);
    });

    test('isAuthenticated と isGuest は排他的', () {
      const authState = AuthStateData(
        isAuthenticated: true,
        userId: 'user-123',
        email: 'test@example.com',
        token: 'test-token',
      );
      expect(authState.isAuthenticated, isTrue);
      expect(authState.isGuest, isFalse);

      const guestState = AuthStateData(isGuest: true);
      expect(guestState.isGuest, isTrue);
      expect(guestState.isAuthenticated, isFalse);
    });

    test('copyWith で一部のフィールドのみ変更できる', () {
      const state = AuthStateData(
        isAuthenticated: true,
        userId: 'user-123',
        email: 'test@example.com',
        token: 'old-token',
      );
      final updated = state.copyWith(token: 'new-token');

      expect(updated.isAuthenticated, isTrue);
      expect(updated.userId, equals('user-123'));
      expect(updated.email, equals('test@example.com'));
      expect(updated.token, equals('new-token'));
    });

    test('copyWith で isGuest を変更できる', () {
      const state = AuthStateData.initial();
      final guestState = state.copyWith(isGuest: true);
      expect(guestState.isGuest, isTrue);
      expect(guestState.isAuthenticated, isFalse);
    });

    test('equality に isGuest が含まれる', () {
      const state1 = AuthStateData(isGuest: true);
      const state2 = AuthStateData(isGuest: true);
      const state3 = AuthStateData();
      expect(state1, equals(state2));
      expect(state1, isNot(equals(state3)));
    });
  });

  group('AuthState Notifier', () {
    test('初期状態は未認証', () {
      final container = createTestContainer();
      addTearDown(container.dispose);

      final state = container.read(authStateProvider);
      expect(state.isAuthenticated, isFalse);
    });

    test('login で認証済み状態になる', () {
      final container = createTestContainer();
      addTearDown(container.dispose);

      container.read(authStateProvider.notifier).login(
            userId: 'user-123',
            email: 'test@example.com',
            token: 'test-token',
            refreshToken: 'test-refresh-token',
          );

      final state = container.read(authStateProvider);
      expect(state.isAuthenticated, isTrue);
      expect(state.userId, equals('user-123'));
      expect(state.email, equals('test@example.com'));
      expect(state.token, equals('test-token'));
    });

    test('logout で未認証状態に戻る', () async {
      final container = createTestContainer();
      addTearDown(container.dispose);

      await container.read(authStateProvider.notifier).login(
            userId: 'user-123',
            email: 'test@example.com',
            token: 'test-token',
            refreshToken: 'test-refresh-token',
          );
      await container.read(authStateProvider.notifier).logout();

      final state = container.read(authStateProvider);
      expect(state.isAuthenticated, isFalse);
      expect(state.userId, isNull);
      expect(state.email, isNull);
      expect(state.token, isNull);
    });

    test('状態変更時にリスナーが通知される', () async {
      final container = createTestContainer();
      addTearDown(container.dispose);

      var notificationCount = 0;
      container.listen(authStateProvider, (previous, next) {
        notificationCount++;
      });

      await container.read(authStateProvider.notifier).login(
            userId: 'user-123',
            email: 'test@example.com',
            token: 'test-token',
            refreshToken: 'test-refresh-token',
          );

      expect(notificationCount, equals(1));

      await container.read(authStateProvider.notifier).logout();

      expect(notificationCount, equals(2));
    });

    test('logout 時に ShelfState がクリアされる', () async {
      final container = createTestContainer();
      addTearDown(container.dispose);

      container.read(shelfStateProvider.notifier).registerEntry(
            ShelfEntry(
              userBookId: 1,
              externalId: 'book-123',
              readingStatus: ReadingStatus.backlog,
              addedAt: DateTime.now(),
            ),
          );
      expect(container.read(shelfStateProvider), isNotEmpty);

      await container.read(authStateProvider.notifier).logout();

      expect(container.read(shelfStateProvider), isEmpty);
    });

    test('enterGuestMode でゲスト状態になる', () async {
      final container = createTestContainer();
      addTearDown(container.dispose);

      await container.read(authStateProvider.notifier).enterGuestMode();

      final state = container.read(authStateProvider);
      expect(state.isGuest, isTrue);
      expect(state.isAuthenticated, isFalse);
      expect(state.userId, isNull);
      expect(state.token, isNull);
    });

    test('ゲストモードからログインすると isGuest が false になる', () async {
      final container = createTestContainer();
      addTearDown(container.dispose);

      await container.read(authStateProvider.notifier).enterGuestMode();
      expect(container.read(authStateProvider).isGuest, isTrue);

      await container.read(authStateProvider.notifier).login(
            userId: 'user-123',
            email: 'test@example.com',
            token: 'test-token',
            refreshToken: 'test-refresh-token',
          );

      final state = container.read(authStateProvider);
      expect(state.isAuthenticated, isTrue);
      expect(state.isGuest, isFalse);
    });

    test('restoreSession で認証データ優先、なければゲストモードを確認', () async {
      final mockStorage = MockSecureStorageService();
      when(() => mockStorage.loadAuthData()).thenAnswer((_) async => null);
      when(() => mockStorage.loadGuestMode()).thenAnswer((_) async => true);
      when(() => mockStorage.saveGuestMode(isGuest: any(named: 'isGuest')))
          .thenAnswer((_) async {});
      when(() => mockStorage.clearGuestMode()).thenAnswer((_) async {});
      when(() => mockStorage.saveAuthData(
            userId: any(named: 'userId'),
            email: any(named: 'email'),
            idToken: any(named: 'idToken'),
            refreshToken: any(named: 'refreshToken'),
          )).thenAnswer((_) async {});
      when(() => mockStorage.clearAuthData()).thenAnswer((_) async {});

      final container = createTestContainer(
        overrides: [
          secureStorageServiceProvider.overrideWithValue(mockStorage),
        ],
      );
      addTearDown(container.dispose);

      final restored =
          await container.read(authStateProvider.notifier).restoreSession();

      expect(restored, isTrue);
      final state = container.read(authStateProvider);
      expect(state.isGuest, isTrue);
      expect(state.isAuthenticated, isFalse);
    });

    test('restoreSession で認証データもゲストフラグもない場合は false を返す',
        () async {
      final mockStorage = MockSecureStorageService();
      when(() => mockStorage.loadAuthData()).thenAnswer((_) async => null);
      when(() => mockStorage.loadGuestMode()).thenAnswer((_) async => false);
      when(() => mockStorage.saveGuestMode(isGuest: any(named: 'isGuest')))
          .thenAnswer((_) async {});
      when(() => mockStorage.clearGuestMode()).thenAnswer((_) async {});
      when(() => mockStorage.saveAuthData(
            userId: any(named: 'userId'),
            email: any(named: 'email'),
            idToken: any(named: 'idToken'),
            refreshToken: any(named: 'refreshToken'),
          )).thenAnswer((_) async {});
      when(() => mockStorage.clearAuthData()).thenAnswer((_) async {});

      final container = createTestContainer(
        overrides: [
          secureStorageServiceProvider.overrideWithValue(mockStorage),
        ],
      );
      addTearDown(container.dispose);

      final restored =
          await container.read(authStateProvider.notifier).restoreSession();

      expect(restored, isFalse);
      final state = container.read(authStateProvider);
      expect(state.isGuest, isFalse);
      expect(state.isAuthenticated, isFalse);
    });

    test('login 時に syncToken が呼ばれる', () async {
      final spy = SpyDeviceTokenNotifier();
      final container = createTestContainer(
        overrides: [
          deviceTokenNotifierProvider.overrideWith(() => spy),
        ],
      );
      addTearDown(container.dispose);

      // DeviceTokenNotifier を初期化
      container.read(deviceTokenNotifierProvider);

      await container.read(authStateProvider.notifier).login(
            userId: 'user-123',
            email: 'test@example.com',
            token: 'test-token',
            refreshToken: 'test-refresh-token',
          );

      expect(spy.syncTokenCallCount, equals(1));
    });

    test('syncToken 失敗時もログインは成功する', () async {
      final container = createTestContainer(
        overrides: [
          deviceTokenNotifierProvider
              .overrideWith(() => FailingDeviceTokenNotifier()),
        ],
      );
      addTearDown(container.dispose);

      // DeviceTokenNotifier を初期化
      container.read(deviceTokenNotifierProvider);

      await container.read(authStateProvider.notifier).login(
            userId: 'user-123',
            email: 'test@example.com',
            token: 'test-token',
            refreshToken: 'test-refresh-token',
          );

      final state = container.read(authStateProvider);
      expect(state.isAuthenticated, isTrue);
      expect(state.userId, equals('user-123'));
    });

    test('restoreSession で認証データ復元時に syncToken が呼ばれる', () async {
      final spy = SpyDeviceTokenNotifier();
      final mockStorage = MockSecureStorageService();
      when(() => mockStorage.loadAuthData()).thenAnswer(
        (_) async => const AuthStorageData(
          userId: 'user-123',
          email: 'test@example.com',
          idToken: 'test-token',
          refreshToken: 'test-refresh-token',
        ),
      );
      when(() => mockStorage.loadGuestMode()).thenAnswer((_) async => false);
      when(() => mockStorage.saveGuestMode(isGuest: any(named: 'isGuest')))
          .thenAnswer((_) async {});
      when(() => mockStorage.clearGuestMode()).thenAnswer((_) async {});
      when(() => mockStorage.saveAuthData(
            userId: any(named: 'userId'),
            email: any(named: 'email'),
            idToken: any(named: 'idToken'),
            refreshToken: any(named: 'refreshToken'),
          )).thenAnswer((_) async {});
      when(() => mockStorage.clearAuthData()).thenAnswer((_) async {});

      final container = createTestContainer(
        overrides: [
          secureStorageServiceProvider.overrideWithValue(mockStorage),
          deviceTokenNotifierProvider.overrideWith(() => spy),
        ],
      );
      addTearDown(container.dispose);

      // DeviceTokenNotifier を初期化
      container.read(deviceTokenNotifierProvider);

      await container.read(authStateProvider.notifier).restoreSession();

      expect(spy.syncTokenCallCount, equals(1));
    });

    test('restoreSession でゲストモード復元時は syncToken が呼ばれない', () async {
      final spy = SpyDeviceTokenNotifier();
      final mockStorage = MockSecureStorageService();
      when(() => mockStorage.loadAuthData()).thenAnswer((_) async => null);
      when(() => mockStorage.loadGuestMode()).thenAnswer((_) async => true);
      when(() => mockStorage.saveGuestMode(isGuest: any(named: 'isGuest')))
          .thenAnswer((_) async {});
      when(() => mockStorage.clearGuestMode()).thenAnswer((_) async {});
      when(() => mockStorage.saveAuthData(
            userId: any(named: 'userId'),
            email: any(named: 'email'),
            idToken: any(named: 'idToken'),
            refreshToken: any(named: 'refreshToken'),
          )).thenAnswer((_) async {});
      when(() => mockStorage.clearAuthData()).thenAnswer((_) async {});

      final container = createTestContainer(
        overrides: [
          secureStorageServiceProvider.overrideWithValue(mockStorage),
          deviceTokenNotifierProvider.overrideWith(() => spy),
        ],
      );
      addTearDown(container.dispose);

      // DeviceTokenNotifier を初期化
      container.read(deviceTokenNotifierProvider);

      await container.read(authStateProvider.notifier).restoreSession();

      expect(spy.syncTokenCallCount, equals(0));
    });

    test('logout 時に FollowVersion がリセットされる', () async {
      final container = createTestContainer();
      addTearDown(container.dispose);

      container.read(followVersionProvider.notifier).increment();
      container.read(followVersionProvider.notifier).increment();
      expect(container.read(followVersionProvider), equals(2));

      await container.read(authStateProvider.notifier).logout();

      expect(container.read(followVersionProvider), equals(0));
    });

    test('logout 時に UnreadNotificationCount がリセットされる', () async {
      final container = createTestContainer();
      addTearDown(container.dispose);

      container.read(unreadNotificationCountProvider.notifier).state =
          const AsyncData(5);
      expect(
        container.read(unreadNotificationCountProvider),
        equals(const AsyncData<int>(5)),
      );

      await container.read(authStateProvider.notifier).logout();

      expect(
        container.read(unreadNotificationCountProvider),
        equals(const AsyncData<int>(0)),
      );
    });

    test('logout 時にゲストモードフラグもクリアされる', () async {
      final mockStorage = MockSecureStorageService();
      when(() => mockStorage.saveGuestMode(isGuest: any(named: 'isGuest')))
          .thenAnswer((_) async {});
      when(() => mockStorage.loadGuestMode()).thenAnswer((_) async => false);
      when(() => mockStorage.clearGuestMode()).thenAnswer((_) async {});
      when(() => mockStorage.clearAuthData()).thenAnswer((_) async {});
      when(() => mockStorage.loadAuthData()).thenAnswer((_) async => null);
      when(() => mockStorage.saveAuthData(
            userId: any(named: 'userId'),
            email: any(named: 'email'),
            idToken: any(named: 'idToken'),
            refreshToken: any(named: 'refreshToken'),
          )).thenAnswer((_) async {});

      final container = createTestContainer(
        overrides: [
          secureStorageServiceProvider.overrideWithValue(mockStorage),
        ],
      );
      addTearDown(container.dispose);

      await container.read(authStateProvider.notifier).enterGuestMode();
      await container.read(authStateProvider.notifier).logout();

      verify(() => mockStorage.clearGuestMode()).called(1);
      final state = container.read(authStateProvider);
      expect(state.isGuest, isFalse);
      expect(state.isAuthenticated, isFalse);
    });
  });
}
