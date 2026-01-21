// AuthProvider のユニットテスト
// AuthStateNotifier と認証状態管理のテスト。

import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/auth/auth_state.dart';

import '../../helpers/test_helpers.dart';

void main() {
  setUpAll(registerTestFallbackValues);

  group('AuthStateNotifier', () {
    group('初期状態', () {
      test('初期状態は未認証であること', () {
        final container = createTestContainer();
        addTearDown(container.dispose);

        final authState = container.read(authStateProvider);

        expect(authState, equals(TestAuthStates.unauthenticated));
        expect(authState.isAuthenticated, isFalse);
        expect(authState.userId, isNull);
        expect(authState.token, isNull);
      });
    });

    group('login', () {
      test('ログイン後は認証済み状態になること', () {
        final container = createTestContainer();
        addTearDown(container.dispose);

        container.read(authStateProvider.notifier).login(
              userId: 'test-user',
              email: 'test@example.com',
              token: 'test-token',
              refreshToken: 'test-refresh-token',
            );

        final authState = container.read(authStateProvider);

        expect(authState.isAuthenticated, isTrue);
        expect(authState.userId, equals('test-user'));
        expect(authState.token, equals('test-token'));
      });

      test('異なるユーザーでログインし直せること', () {
        final container = createTestContainer();
        addTearDown(container.dispose);

        container.read(authStateProvider.notifier).login(
              userId: 'user-1',
              email: 'user1@example.com',
              token: 'token-1',
              refreshToken: 'refresh-token-1',
            );
        container.read(authStateProvider.notifier).login(
              userId: 'user-2',
              email: 'user2@example.com',
              token: 'token-2',
              refreshToken: 'refresh-token-2',
            );

        final authState = container.read(authStateProvider);

        expect(authState.userId, equals('user-2'));
        expect(authState.token, equals('token-2'));
      });
    });

    group('logout', () {
      test('ログアウト後は未認証状態になること', () {
        final container = createTestContainer();
        addTearDown(container.dispose);

        container.read(authStateProvider.notifier).login(
              userId: 'test-user',
              email: 'test@example.com',
              token: 'test-token',
              refreshToken: 'test-refresh-token',
            );
        container.read(authStateProvider.notifier).logout();

        final authState = container.read(authStateProvider);

        expect(authState.isAuthenticated, isFalse);
        expect(authState.userId, isNull);
        expect(authState.token, isNull);
      });

      test('未認証状態でログアウトしてもエラーにならないこと', () {
        final container = createTestContainer();
        addTearDown(container.dispose);

        expect(
          () => container.read(authStateProvider.notifier).logout(),
          returnsNormally,
        );
      });
    });

    group('AuthState copyWith', () {
      test('copyWith で一部のフィールドのみ変更できること', () {
        const state = TestAuthStates.authenticated;

        final updated = state.copyWith(userId: 'new-user');

        expect(updated.isAuthenticated, isTrue);
        expect(updated.userId, equals('new-user'));
        expect(updated.token, equals('test-token'));
      });

      test('copyWith で全てのフィールドを変更できること', () {
        const state = TestAuthStates.unauthenticated;

        final updated = state.copyWith(
          isAuthenticated: true,
          userId: 'new-user',
          token: 'new-token',
        );

        expect(updated.isAuthenticated, isTrue);
        expect(updated.userId, equals('new-user'));
        expect(updated.token, equals('new-token'));
      });
    });

    group('AuthChangeNotifier', () {
      test('認証状態変更時に通知が発行されること', () {
        final container = createTestContainer();
        addTearDown(container.dispose);

        var notificationCount = 0;

        container.listen(
          authStateProvider,
          (previous, next) {
            notificationCount++;
          },
        );

        container.read(authStateProvider.notifier).login(
              userId: 'test-user',
              email: 'test@example.com',
              token: 'test-token',
              refreshToken: 'test-refresh-token',
            );

        expect(notificationCount, equals(1));

        container.read(authStateProvider.notifier).logout();

        expect(notificationCount, equals(2));
      });
    });

    group('Provider 永続化', () {
      test('authStateProvider は keepAlive が有効であること', () {
        final container = createTestContainer();

        container.read(authStateProvider.notifier).login(
              userId: 'test-user',
              email: 'test@example.com',
              token: 'test-token',
              refreshToken: 'test-refresh-token',
            );

        // 通常の参照を取得後も状態が保持されることを確認
        expect(
          container.read(authStateProvider).isAuthenticated,
          isTrue,
        );

        container.dispose();
      });
    });
  });
}
