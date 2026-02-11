import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';
import 'package:shelfie/features/account/presentation/profile_screen.dart';
import 'package:shelfie/features/profile/application/profile_notifier.dart';
import 'package:shelfie/features/profile/presentation/profile_header.dart';
import 'package:shelfie/features/profile/presentation/reading_stats_section.dart';

void main() {
  UserProfile createTestProfile() {
    return UserProfile(
      id: 1,
      email: 'test@example.com',
      name: 'Test User',
      avatarUrl: 'https://example.com/avatar.png',
      username: '@testuser',
      bookCount: 15,
      readingCount: 3,
      backlogCount: 5,
      completedCount: 6,
      interestedCount: 1,
      readingStartYear: 2020,
      readingStartMonth: 1,
      createdAt: DateTime(2020, 1, 1),
    );
  }

  Widget buildProfileScreen({
    required List<Override> overrides,
    GoRouter? router,
  }) {
    final goRouter = router ??
        GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const ProfileScreen(),
            ),
            GoRoute(
              path: '/account',
              builder: (context, state) =>
                  const Scaffold(body: Text('Account Screen')),
            ),
          ],
        );

    return ProviderScope(
      overrides: overrides,
      child: MaterialApp.router(
        theme: AppTheme.dark(),
        routerConfig: goRouter,
      ),
    );
  }

  group('ProfileScreen', () {
    testWidgets('ローディング中にインジケーターが表示される', (tester) async {
      await tester.pumpWidget(
        buildProfileScreen(
          overrides: [
            authStateProvider.overrideWith(
              () => _AuthenticatedAuthState(),
            ),
            profileNotifierProvider.overrideWith(
              () => _LoadingProfileNotifier(),
            ),
          ],
        ),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('データ取得後にヘッダーと統計セクションが表示される', (tester) async {
      final profile = createTestProfile();

      await tester.pumpWidget(
        buildProfileScreen(
          overrides: [
            authStateProvider.overrideWith(
              () => _AuthenticatedAuthState(),
            ),
            profileNotifierProvider.overrideWith(
              () => _DataProfileNotifier(profile),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ProfileHeader), findsOneWidget);
      expect(find.byType(ReadingStatsSection), findsOneWidget);
      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('@testuser'), findsOneWidget);
      expect(find.text('6'), findsOneWidget);
      expect(find.text('読了'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('読書中'), findsOneWidget);
    });

    testWidgets('設定アイコンが表示される', (tester) async {
      final profile = createTestProfile();

      await tester.pumpWidget(
        buildProfileScreen(
          overrides: [
            authStateProvider.overrideWith(
              () => _AuthenticatedAuthState(),
            ),
            profileNotifierProvider.overrideWith(
              () => _DataProfileNotifier(profile),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('設定アイコンタップで /account へ遷移する', (tester) async {
      final profile = createTestProfile();

      await tester.pumpWidget(
        buildProfileScreen(
          overrides: [
            authStateProvider.overrideWith(
              () => _AuthenticatedAuthState(),
            ),
            profileNotifierProvider.overrideWith(
              () => _DataProfileNotifier(profile),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();

      expect(find.text('Account Screen'), findsOneWidget);
    });

    testWidgets('エラー時にエラー表示がされる', (tester) async {
      await tester.pumpWidget(
        buildProfileScreen(
          overrides: [
            authStateProvider.overrideWith(
              () => _AuthenticatedAuthState(),
            ),
            profileNotifierProvider.overrideWith(
              () => _ErrorProfileNotifier(),
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.text('プロフィールの取得に失敗しました'), findsOneWidget);
    });
  });
}

class _AuthenticatedAuthState extends AuthState {
  @override
  AuthStateData build() {
    return const AuthStateData(isAuthenticated: true);
  }
}

class _LoadingProfileNotifier extends ProfileNotifier {
  @override
  Future<UserProfile> build() {
    return Completer<UserProfile>().future;
  }
}

class _DataProfileNotifier extends ProfileNotifier {
  _DataProfileNotifier(this._profile);

  final UserProfile _profile;

  @override
  Future<UserProfile> build() async => _profile;
}

class _ErrorProfileNotifier extends ProfileNotifier {
  @override
  Future<UserProfile> build() async {
    throw const ServerFailure(message: 'Server error', code: 'SERVER_ERROR');
  }
}
