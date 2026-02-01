import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/routing/app_router.dart';

class MockGoRouterState extends Mock implements GoRouterState {}

void main() {
  setUpAll(() {
    registerFallbackValue(Uri.parse('/'));
  });

  group('guardRoute', () {
    late MockGoRouterState mockState;

    setUp(() {
      mockState = MockGoRouterState();
    });

    test('未認証 + ルートパス (/) -> /welcome へリダイレクト', () {
      const authState = AuthStateData();
      when(() => mockState.matchedLocation).thenReturn('/');

      final result = guardRoute(authState: authState, state: mockState);

      expect(result, equals(AppRoutes.welcome));
    });

    test('未認証 + /welcome -> リダイレクトなし (null)', () {
      const authState = AuthStateData();
      when(() => mockState.matchedLocation).thenReturn('/welcome');

      final result = guardRoute(authState: authState, state: mockState);

      expect(result, isNull);
    });

    test('認証済み + /welcome -> / へリダイレクト', () {
      const authState = AuthStateData(
        isAuthenticated: true,
        userId: 'user-123',
        email: 'test@example.com',
        token: 'token-123',
      );
      when(() => mockState.matchedLocation).thenReturn('/welcome');

      final result = guardRoute(authState: authState, state: mockState);

      expect(result, equals(AppRoutes.home));
    });

    test('認証済み + ルートパス (/) -> リダイレクトなし (null)', () {
      const authState = AuthStateData(
        isAuthenticated: true,
        userId: 'user-123',
        email: 'test@example.com',
        token: 'token-123',
      );
      when(() => mockState.matchedLocation).thenReturn('/');

      final result = guardRoute(authState: authState, state: mockState);

      expect(result, isNull);
    });

    test('未認証 + /auth/login -> リダイレクトなし (null)', () {
      const authState = AuthStateData();
      when(() => mockState.matchedLocation).thenReturn('/auth/login');

      final result = guardRoute(authState: authState, state: mockState);

      expect(result, isNull);
    });

    test('認証済み + /auth/login -> / へリダイレクト', () {
      const authState = AuthStateData(
        isAuthenticated: true,
        userId: 'user-123',
        email: 'test@example.com',
        token: 'token-123',
      );
      when(() => mockState.matchedLocation).thenReturn('/auth/login');

      final result = guardRoute(authState: authState, state: mockState);

      expect(result, equals(AppRoutes.home));
    });
  });
}
