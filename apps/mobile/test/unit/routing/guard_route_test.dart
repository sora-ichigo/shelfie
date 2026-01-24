import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/auth/session_validator.dart';
import 'package:shelfie/routing/app_router.dart';

class MockGoRouterState extends Mock implements GoRouterState {}

class MockSessionValidator extends Mock implements SessionValidator {}

class MockAuthStateNotifier extends Mock implements AuthState {}

void main() {
  setUpAll(() {
    registerFallbackValue(Uri.parse('/'));
  });

  group('guardRoute', () {
    late MockGoRouterState mockState;
    late MockSessionValidator mockSessionValidator;
    late MockAuthStateNotifier mockAuthStateNotifier;

    setUp(() {
      mockState = MockGoRouterState();
      mockSessionValidator = MockSessionValidator();
      mockAuthStateNotifier = MockAuthStateNotifier();

      when(() => mockAuthStateNotifier.logout()).thenAnswer((_) async {});
    });

    test('未認証 + ルートパス (/) -> /welcome へリダイレクト', () async {
      const authState = AuthStateData();
      when(() => mockState.matchedLocation).thenReturn('/');

      final result = await guardRoute(
        authStateNotifier: mockAuthStateNotifier,
        authState: authState,
        state: mockState,
        sessionValidator: mockSessionValidator,
      );

      expect(result, equals(AppRoutes.welcome));
      verifyNever(() => mockSessionValidator.validate());
    });

    test('未認証 + /welcome -> リダイレクトなし (null)', () async {
      const authState = AuthStateData();
      when(() => mockState.matchedLocation).thenReturn('/welcome');

      final result = await guardRoute(
        authStateNotifier: mockAuthStateNotifier,
        authState: authState,
        state: mockState,
        sessionValidator: mockSessionValidator,
      );

      expect(result, isNull);
      verifyNever(() => mockSessionValidator.validate());
    });

    test('認証済み + /welcome -> / へリダイレクト', () async {
      const authState = AuthStateData(
        isAuthenticated: true,
        userId: 'user-123',
        email: 'test@example.com',
        token: 'token-123',
      );
      when(() => mockState.matchedLocation).thenReturn('/welcome');

      final result = await guardRoute(
        authStateNotifier: mockAuthStateNotifier,
        authState: authState,
        state: mockState,
        sessionValidator: mockSessionValidator,
      );

      expect(result, equals(AppRoutes.home));
      verifyNever(() => mockSessionValidator.validate());
    });

    test('認証済み + ルートパス (/) + セッション有効 -> リダイレクトなし (null)', () async {
      const authState = AuthStateData(
        isAuthenticated: true,
        userId: 'user-123',
        email: 'test@example.com',
        token: 'token-123',
      );
      when(() => mockState.matchedLocation).thenReturn('/');
      when(() => mockSessionValidator.validate()).thenAnswer(
        (_) async => const SessionValid(userId: 1, email: 'test@example.com'),
      );

      final result = await guardRoute(
        authStateNotifier: mockAuthStateNotifier,
        authState: authState,
        state: mockState,
        sessionValidator: mockSessionValidator,
      );

      expect(result, isNull);
      verify(() => mockSessionValidator.validate()).called(1);
    });

    test('認証済み + ルートパス (/) + セッション無効 -> ログアウトして /welcome へリダイレクト',
        () async {
      const authState = AuthStateData(
        isAuthenticated: true,
        userId: 'user-123',
        email: 'test@example.com',
        token: 'token-123',
      );
      when(() => mockState.matchedLocation).thenReturn('/');
      when(() => mockSessionValidator.validate()).thenAnswer(
        (_) async => const SessionInvalid(
          errorCode: 'TOKEN_EXPIRED',
          message: 'Token expired',
        ),
      );

      final result = await guardRoute(
        authStateNotifier: mockAuthStateNotifier,
        authState: authState,
        state: mockState,
        sessionValidator: mockSessionValidator,
      );

      expect(result, equals(AppRoutes.welcome));
      verify(() => mockSessionValidator.validate()).called(1);
      verify(() => mockAuthStateNotifier.logout()).called(1);
    });

    test('認証済み + ルートパス (/) + セッション検証失敗 -> リダイレクトなし（一時的エラーとして継続）',
        () async {
      const authState = AuthStateData(
        isAuthenticated: true,
        userId: 'user-123',
        email: 'test@example.com',
        token: 'token-123',
      );
      when(() => mockState.matchedLocation).thenReturn('/');
      when(() => mockSessionValidator.validate()).thenAnswer(
        (_) async => const SessionValidationFailed(message: 'Network error'),
      );

      final result = await guardRoute(
        authStateNotifier: mockAuthStateNotifier,
        authState: authState,
        state: mockState,
        sessionValidator: mockSessionValidator,
      );

      // ネットワークエラー等の一時的な失敗の場合は続行
      // （ログアウトしてしまうと UX が悪いため）
      expect(result, isNull);
      verify(() => mockSessionValidator.validate()).called(1);
      verifyNever(() => mockAuthStateNotifier.logout());
    });

    test('未認証 + /auth/login -> リダイレクトなし (null)', () async {
      const authState = AuthStateData();
      when(() => mockState.matchedLocation).thenReturn('/auth/login');

      final result = await guardRoute(
        authStateNotifier: mockAuthStateNotifier,
        authState: authState,
        state: mockState,
        sessionValidator: mockSessionValidator,
      );

      expect(result, isNull);
      verifyNever(() => mockSessionValidator.validate());
    });

    test('認証済み + /auth/login -> / へリダイレクト', () async {
      const authState = AuthStateData(
        isAuthenticated: true,
        userId: 'user-123',
        email: 'test@example.com',
        token: 'token-123',
      );
      when(() => mockState.matchedLocation).thenReturn('/auth/login');

      final result = await guardRoute(
        authStateNotifier: mockAuthStateNotifier,
        authState: authState,
        state: mockState,
        sessionValidator: mockSessionValidator,
      );

      expect(result, equals(AppRoutes.home));
      verifyNever(() => mockSessionValidator.validate());
    });
  });
}
