/// App router configuration using go_router.
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/auth/session_validator.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/widgets/screen_header.dart';
import 'package:shelfie/features/book_detail/presentation/book_detail_screen.dart';
import 'package:shelfie/features/book_search/presentation/isbn_scan_screen.dart';
import 'package:shelfie/features/book_search/presentation/search_screen.dart';
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

  /// エラー画面
  static const error = '/error';

  /// ISBN スキャン画面
  static const isbnScan = '/search/isbn-scan';

  /// 本詳細画面パスを生成
  static String bookDetail({required String bookId}) => '/books/$bookId';

  /// 検索画面（クエリパラメータ付き）
  static String searchWithQuery({required String query}) =>
      '$searchTab?q=${Uri.encodeComponent(query)}';
}

/// 本詳細画面のパラメータ
class BookDetailParams {
  const BookDetailParams({required this.bookId});

  /// GoRouterState から BookDetailParams を生成
  factory BookDetailParams.fromState({
    required Map<String, String> pathParameters,
  }) {
    return BookDetailParams(
      bookId: pathParameters['bookId'] ?? '',
    );
  }

  final String bookId;
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
GoRouter appRouter(AppRouterRef ref) {
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
      builder: (context, state) => const WelcomeScreen(),
    ),

    // ログイン画面
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),

    // 新規登録画面
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegistrationScreen(),
    ),

    // エラー画面
    GoRoute(
      path: AppRoutes.error,
      builder: (context, state) => const _ErrorScreen(),
    ),

    // アカウント画面（タブバーなし）
    GoRoute(
      path: AppRoutes.account,
      builder: (context, state) => const _AccountScreen(),
    ),

    // メインシェル（タブナビゲーション）
    ShellRoute(
      builder: (context, state, child) => _MainShell(child: child),
      routes: [
        // ホーム（本棚）
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: _HomeScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.homeTab,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: _HomeScreen(),
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
        // 本詳細
        GoRoute(
          path: '/books/:bookId',
          builder: (context, state) {
            final params = BookDetailParams.fromState(
              pathParameters: state.pathParameters,
            );
            return BookDetailScreen(bookId: params.bookId);
          },
        ),
      ],
    ),
  ];
}

/// プレースホルダー: メインシェル（タブバー）
class _MainShell extends StatefulWidget {
  const _MainShell({required this.child});

  final Widget child;

  @override
  State<_MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<_MainShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:
              context.go(AppRoutes.homeTab);
            case 1:
              context.go(AppRoutes.searchTab);
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.auto_stories_outlined),
            activeIcon: _ActiveTabIcon(
              icon: Icons.auto_stories,
              indicatorColor:
                  Theme.of(context).extension<AppColors>()?.brandPrimary ??
                      const Color(0xFF4FD1C5),
            ),
            label: '本棚',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            activeIcon: _ActiveTabIcon(
              icon: Icons.search,
              indicatorColor:
                  Theme.of(context).extension<AppColors>()?.brandPrimary ??
                      const Color(0xFF4FD1C5),
            ),
            label: '検索',
          ),
        ],
      ),
    );
  }
}

/// アクティブタブのアイコン（上部インジケーター付き）
class _ActiveTabIcon extends StatelessWidget {
  const _ActiveTabIcon({
    required this.icon,
    required this.indicatorColor,
  });

  final IconData icon;
  final Color indicatorColor;

  @override
  Widget build(BuildContext context) {
    final iconSize = Theme.of(context)
            .bottomNavigationBarTheme
            .selectedIconTheme
            ?.size ??
        32;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Icon(icon, size: iconSize),
        Positioned(
          top: -8,
          child: Container(
            width: iconSize,
            height: 3,
            decoration: BoxDecoration(
              color: indicatorColor,
              borderRadius: BorderRadius.circular(1.5),
            ),
          ),
        ),
      ],
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

/// プレースホルダー: ホーム画面（本棚）
class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenHeader(
            title: '本棚',
            onProfileTap: () => context.push(AppRoutes.account),
          ),
          const Expanded(
            child: Center(child: Text('本棚コンテンツ')),
          ),
        ],
      ),
    );
  }
}

/// プレースホルダー: アカウント画面
class _AccountScreen extends StatelessWidget {
  const _AccountScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アカウント'),
      ),
      body: const Center(child: Text('アカウント設定')),
    );
  }
}

