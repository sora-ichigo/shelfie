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

    group('ゲストモード', () {
      const guestState = AuthStateData(isGuest: true);

      test('ゲスト + / -> リダイレクトなし', () {
        when(() => mockState.matchedLocation).thenReturn('/');
        final result = guardRoute(authState: guestState, state: mockState);
        expect(result, isNull);
      });

      test('ゲスト + /home -> リダイレクトなし', () {
        when(() => mockState.matchedLocation).thenReturn('/home');
        final result = guardRoute(authState: guestState, state: mockState);
        expect(result, isNull);
      });

      test('ゲスト + /search -> リダイレクトなし', () {
        when(() => mockState.matchedLocation).thenReturn('/search');
        final result = guardRoute(authState: guestState, state: mockState);
        expect(result, isNull);
      });

      test('ゲスト + /books/book-123 -> リダイレクトなし', () {
        when(() => mockState.matchedLocation).thenReturn('/books/book-123');
        final result = guardRoute(authState: guestState, state: mockState);
        expect(result, isNull);
      });

      test('ゲスト + /welcome -> リダイレクトなし', () {
        when(() => mockState.matchedLocation).thenReturn('/welcome');
        final result = guardRoute(authState: guestState, state: mockState);
        expect(result, isNull);
      });

      test('ゲスト + /auth/login -> リダイレクトなし', () {
        when(() => mockState.matchedLocation).thenReturn('/auth/login');
        final result = guardRoute(authState: guestState, state: mockState);
        expect(result, isNull);
      });

      test('ゲスト + /auth/register -> リダイレクトなし', () {
        when(() => mockState.matchedLocation).thenReturn('/auth/register');
        final result = guardRoute(authState: guestState, state: mockState);
        expect(result, isNull);
      });

      test('ゲスト + /account -> リダイレクトなし', () {
        when(() => mockState.matchedLocation).thenReturn('/account');
        final result = guardRoute(authState: guestState, state: mockState);
        expect(result, isNull);
      });

      test('ゲスト + /account/edit -> /welcome へリダイレクト', () {
        when(() => mockState.matchedLocation).thenReturn('/account/edit');
        final result = guardRoute(authState: guestState, state: mockState);
        expect(result, equals(AppRoutes.welcome));
      });

      test('ゲスト + /lists/1 -> /welcome へリダイレクト', () {
        when(() => mockState.matchedLocation).thenReturn('/lists/1');
        final result = guardRoute(authState: guestState, state: mockState);
        expect(result, equals(AppRoutes.welcome));
      });

      test('ゲスト + /lists/new -> /welcome へリダイレクト', () {
        when(() => mockState.matchedLocation).thenReturn('/lists/new');
        final result = guardRoute(authState: guestState, state: mockState);
        expect(result, equals(AppRoutes.welcome));
      });

      test('ゲスト + /search/isbn-scan -> リダイレクトなし', () {
        when(() => mockState.matchedLocation).thenReturn('/search/isbn-scan');
        final result = guardRoute(authState: guestState, state: mockState);
        expect(result, isNull);
      });
    });
  });
}
