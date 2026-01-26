/// App router configuration using go_router.
library;

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/auth/session_validator.dart';
import 'package:shelfie/core/constants/legal_urls.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/features/account/application/account_notifier.dart';
import 'package:shelfie/features/account/presentation/account_screen.dart';
import 'package:shelfie/features/account/presentation/password_settings_screen.dart';
import 'package:shelfie/features/account/presentation/profile_edit_screen.dart';
import 'package:shelfie/features/book_detail/presentation/book_detail_screen.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart'
    show BookSource;
import 'package:shelfie/features/book_search/presentation/isbn_scan_screen.dart';
import 'package:shelfie/features/book_search/presentation/search_screen.dart';
import 'package:shelfie/features/book_shelf/presentation/book_shelf_screen.dart';
import 'package:shelfie/features/login/presentation/login_screen.dart';
import 'package:shelfie/features/registration/presentation/registration_screen.dart';
import 'package:shelfie/features/welcome/presentation/welcome_screen.dart';

part 'app_router.g.dart';

/// ルートパス定義
///
/// 全てのルートパスを一元管理し、型安全なナビゲーションを実現する。
abstract final class AppRoutes {
  /// ホーム画面
  static const home = '/';

  /// ウェルカム画面
  static const welcome = '/welcome';

  /// ログイン画面
  static const login = '/auth/login';

  /// 新規登録画面
  static const register = '/auth/register';

  /// ホームタブ
  static const homeTab = '/home';

  /// 検索タブ
  static const searchTab = '/search';

  /// アカウント画面
  static const account = '/account';

  /// プロフィール編集画面
  static const accountEdit = '/account/edit';

  /// パスワード設定画面
  static const accountPassword = '/account/password';

  /// エラー画面
  static const error = '/error';

  /// ISBN スキャン画面
  static const isbnScan = '/search/isbn-scan';

  /// 本詳細画面パスを生成
  static String bookDetail({required String bookId, BookSource? source}) {
    final path = '/books/$bookId';
    if (source != null) {
      return '$path?source=${source.name}';
    }
    return path;
  }

  /// 検索画面（クエリパラメータ付き）
  static String searchWithQuery({required String query}) =>
      '$searchTab?q=${Uri.encodeComponent(query)}';
}

/// 本詳細画面のパラメータ
class BookDetailParams {
  const BookDetailParams({required this.bookId, this.source});

  /// GoRouterState から BookDetailParams を生成
  factory BookDetailParams.fromState({
    required Map<String, String> pathParameters,
    Map<String, String>? queryParameters,
  }) {
    return BookDetailParams(
      bookId: pathParameters['bookId'] ?? '',
      source: queryParameters?['source'],
    );
  }

  final String bookId;
  final String? source;
}

/// 検索画面のパラメータ
class SearchParams {
  const SearchParams({
    this.query = '',
    this.page = 1,
  });

  /// クエリパラメータから SearchParams を生成
  factory SearchParams.fromQueryParameters({
    required Map<String, String> queryParameters,
  }) {
    return SearchParams(
      query: queryParameters['q'] ?? '',
      page: int.tryParse(queryParameters['page'] ?? '1') ?? 1,
    );
  }

  final String query;
  final int page;
}

/// 認証状態変更を監視するための ChangeNotifier ラッパー
///
/// GoRouter の refreshListenable は Listenable を必要とするため、
/// Riverpod の状態変更を Listenable として公開する。
class AuthChangeNotifier extends ChangeNotifier {
  AuthChangeNotifier(this._ref) {
    _ref.listen(authStateProvider, (_, __) {
      notifyListeners();
    });
  }

  final Ref _ref;
}

/// AppRouter Provider
///
/// go_router を使用したルーティング設定を提供する。
/// - 初期ルート: /
/// - デバッグモードでログ出力有効
/// - onException でエラーハンドリング
/// - redirect で認証ガード（me クエリでセッション検証）
/// - ShellRoute でタブナビゲーション
@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final authState = ref.watch(authStateProvider);
  final authStateNotifier = ref.read(authStateProvider.notifier);
  final authChangeNotifier = AuthChangeNotifier(ref);
  final sessionValidator = ref.watch(sessionValidatorProvider);

  ref.onDispose(authChangeNotifier.dispose);

  return GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: kDebugMode,
    refreshListenable: authChangeNotifier,
    redirect: (context, state) => _guardRoute(
      authState: authState,
      state: state,
      sessionValidator: sessionValidator,
      authStateNotifier: authStateNotifier,
    ),
    onException: (context, state, router) {
      router.go(AppRoutes.error);
    },
    routes: _buildRoutes(),
  );
}

/// 認証ガード
///
/// 認証状態に基づいてルートをリダイレクトする。
/// - 未認証時: 保護されたルートからウェルカム画面へリダイレクト
/// - 認証済み時: me クエリでセッションを検証し、無効ならログアウト
/// - セッション有効時: ウェルカム/認証ルートからホームへリダイレクト
Future<String?> _guardRoute({
  required AuthStateData authState,
  required GoRouterState state,
  required SessionValidator sessionValidator,
  required AuthState authStateNotifier,
}) async {
  return guardRoute(
    authState: authState,
    state: state,
    sessionValidator: sessionValidator,
    authStateNotifier: authStateNotifier,
  );
}

/// 認証ガード（テスト用に公開）
Future<String?> guardRoute({
  required AuthStateData authState,
  required GoRouterState state,
  required SessionValidator sessionValidator,
  required AuthState authStateNotifier,
}) async {
  final isAuthenticated = authState.isAuthenticated;
  final currentLocation = state.matchedLocation;
  final isAuthRoute = currentLocation.startsWith('/auth');
  final isWelcomeRoute = currentLocation == AppRoutes.welcome;

  // 未認証かつ認証ルートでもウェルカムでもない → ウェルカム画面へ
  if (!isAuthenticated && !isAuthRoute && !isWelcomeRoute) {
    return AppRoutes.welcome;
  }

  // 認証済みの場合、me クエリでセッションを検証
  if (isAuthenticated && !isAuthRoute && !isWelcomeRoute) {
    final result = await sessionValidator.validate();

    // セッションが明確に無効な場合のみログアウト
    if (result is SessionInvalid) {
      debugPrint('[guardRoute] Session invalid: ${result.message}');
      await authStateNotifier.logout();
      return AppRoutes.welcome;
    }

    // ネットワークエラーなどの場合は続行（一時的な問題の可能性）
    if (result is SessionValidationFailed) {
      debugPrint('[guardRoute] Session validation failed (continuing): ${result.message}');
    }
  }

  // 認証済みかつ（認証ルート または ウェルカム） → ホームへ
  if (isAuthenticated && (isAuthRoute || isWelcomeRoute)) {
    return AppRoutes.home;
  }

  return null;
}

/// ルート定義を構築
List<RouteBase> _buildRoutes() {
  return [
    // ウェルカム画面
    GoRoute(
      path: AppRoutes.welcome,
      pageBuilder: (context, state) => const CupertinoPage(
        child: WelcomeScreen(),
      ),
    ),

    // ログイン画面
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (context, state) => const CupertinoPage(
        child: LoginScreen(),
      ),
    ),

    // 新規登録画面
    GoRoute(
      path: AppRoutes.register,
      pageBuilder: (context, state) => const CupertinoPage(
        child: RegistrationScreen(),
      ),
    ),

    // エラー画面
    GoRoute(
      path: AppRoutes.error,
      pageBuilder: (context, state) => const CupertinoPage(
        child: _ErrorScreen(),
      ),
    ),

    // アカウント画面（タブバーなし）
    GoRoute(
      path: AppRoutes.account,
      pageBuilder: (context, state) => CupertinoPage(
        child: Consumer(
          builder: (context, ref, _) => AccountScreen(
            onClose: () => context.pop(),
            onNavigateToProfileEdit: () => context.push(AppRoutes.accountEdit),
            onNavigateToPassword: () => context.push(AppRoutes.accountPassword),
            onNavigateToTerms: LegalUrls.openTermsOfService,
            onNavigateToPrivacy: LegalUrls.openPrivacyPolicy,
            onLogout: () async {
              final result = await showOkCancelAlertDialog(
                context: context,
                title: 'ログアウト',
                message: 'ログアウトしますか？',
                okLabel: 'ログアウト',
                cancelLabel: 'キャンセル',
                isDestructiveAction: true,
              );
              if (result == OkCancelResult.ok && context.mounted) {
                await ref.read(authStateProvider.notifier).logout();
              }
            },
          ),
        ),
      ),
      routes: [
        GoRoute(
          path: 'edit',
          pageBuilder: (context, state) => CupertinoPage(
            child: Consumer(
              builder: (context, ref, _) {
                final accountState = ref.watch(accountNotifierProvider);
                return accountState.when(
                  data: (profile) => ProfileEditScreen(
                    initialProfile: profile,
                    onClose: () => context.pop(),
                    onSaveSuccess: () => context.pop(),
                  ),
                  loading: () => const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  ),
                  error: (error, stack) => Scaffold(
                    appBar: AppBar(title: const Text('エラー')),
                    body: Center(child: Text('$error')),
                  ),
                );
              },
            ),
          ),
        ),
        GoRoute(
          path: 'password',
          pageBuilder: (context, state) => CupertinoPage(
            child: PasswordSettingsScreen(
              onClose: () => context.pop(),
              onSaveSuccess: () => context.pop(),
            ),
          ),
        ),
      ],
    ),

    // 本詳細（タブバーなし）
    GoRoute(
      path: '/books/:bookId',
      pageBuilder: (context, state) {
        final params = BookDetailParams.fromState(
          pathParameters: state.pathParameters,
          queryParameters: state.uri.queryParameters,
        );
        final source = params.source == 'google'
            ? BookSource.google
            : params.source == 'rakuten'
                ? BookSource.rakuten
                : null;
        return CupertinoPage(
          child: BookDetailScreen(bookId: params.bookId, source: source),
        );
      },
    ),

    // メインシェル（タブナビゲーション）
    ShellRoute(
      builder: (context, state, child) => _MainShell(child: child),
      routes: [
        // ホーム（本棚）
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: BookShelfScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.homeTab,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: BookShelfScreen(),
          ),
        ),
        // 検索
        GoRoute(
          path: AppRoutes.searchTab,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SearchScreen(),
          ),
          routes: [
            // ISBN スキャン画面（モーダル）
            GoRoute(
              path: 'isbn-scan',
              pageBuilder: (context, state) => const MaterialPage(
                fullscreenDialog: true,
                child: ISBNScanScreen(),
              ),
            ),
          ],
        ),
      ],
    ),
  ];
}

/// メインシェル（タブバー）
///
/// ShellRoute のビルダーとして使用され、ボトムナビゲーションを提供する。
/// 現在のルートに基づいてタブの選択状態を管理する。
class _MainShell extends StatelessWidget {
  const _MainShell({required this.child});

  final Widget child;

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith(AppRoutes.searchTab)) {
      return 1;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: _AppTabBar(
        selectedIndex: selectedIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go(AppRoutes.homeTab);
            case 1:
              context.go(AppRoutes.searchTab);
          }
        },
      ),
    );
  }
}

class _AppTabBar extends StatelessWidget {
  const _AppTabBar({
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final appColors = Theme.of(context).extension<AppColors>()!;

    return Container(
      decoration: BoxDecoration(
        color: appColors.background,
        border: Border(
          top: BorderSide(color: appColors.surface, width: 0.5),
        ),
      ),
      padding: EdgeInsets.only(top: 12, bottom: bottomPadding + 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _TabItem(
            icon: CupertinoIcons.book,
            activeIcon: CupertinoIcons.book_fill,
            label: '本棚',
            isSelected: selectedIndex == 0,
            onTap: () => onTap(0),
          ),
          _TabItem(
            icon: CupertinoIcons.search,
            activeIcon: CupertinoIcons.search,
            label: '検索',
            isSelected: selectedIndex == 1,
            onTap: () => onTap(1),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final color = isSelected ? appColors.foreground : appColors.foregroundMuted;

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          onTap();
        },
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: 80,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSelected ? activeIcon : icon,
                color: color,
                size: 26,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// プレースホルダー: エラー画面
class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64),
            const SizedBox(height: 16),
            const Text('Page not found'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
