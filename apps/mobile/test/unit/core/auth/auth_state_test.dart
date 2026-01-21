import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/auth/auth_state.dart';

import '../../../helpers/test_helpers.dart';

void main() {
  setUpAll(registerTestFallbackValues);

  group('AuthStateData', () {
    test('initial 状態は未認証', () {
      const state = AuthStateData.initial();
      expect(state.isAuthenticated, isFalse);
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
      expect(state.userId, equals('user-123'));
      expect(state.email, equals('test@example.com'));
      expect(state.token, equals('test-token'));
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

    test('logout で未認証状態に戻る', () {
      final container = createTestContainer();
      addTearDown(container.dispose);

      container.read(authStateProvider.notifier).login(
            userId: 'user-123',
            email: 'test@example.com',
            token: 'test-token',
            refreshToken: 'test-refresh-token',
          );
      container.read(authStateProvider.notifier).logout();

      final state = container.read(authStateProvider);
      expect(state.isAuthenticated, isFalse);
      expect(state.userId, isNull);
      expect(state.email, isNull);
      expect(state.token, isNull);
    });

    test('状態変更時にリスナーが通知される', () {
      final container = createTestContainer();
      addTearDown(container.dispose);

      var notificationCount = 0;
      container.listen(authStateProvider, (previous, next) {
        notificationCount++;
      });

      container.read(authStateProvider.notifier).login(
            userId: 'user-123',
            email: 'test@example.com',
            token: 'test-token',
            refreshToken: 'test-refresh-token',
          );

      expect(notificationCount, equals(1));

      container.read(authStateProvider.notifier).logout();

      expect(notificationCount, equals(2));
    });
  });
}
