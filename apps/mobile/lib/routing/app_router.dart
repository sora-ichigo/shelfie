/// App router configuration using go_router.
library;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/features/login/presentation/login_screen.dart';
import 'package:shelfie/features/registration/presentation/registration_screen.dart';
import 'package:shelfie/features/welcome/presentation/welcome_screen.dart';

part 'app_router.g.dart';

/// 認証状態プロバイダのエイリアス
///
/// 短い名前でアクセスできるようにするためのエイリアス。
/// 生成されたプロバイダ名は authStateNotifierProvider だが、
/// より直感的な authStateProvider としてエクスポートする。
// ignore: non_constant_identifier_names
final authStateProvider = authStateNotifierProvider;

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

  /// プロファイルタブ
  static const profileTab = '/profile';

  /// エラー画面
  static const error = '/error';

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

/// 認証状態
@immutable
class AuthState {
  const AuthState({
    this.isAuthenticated = false,
    this.userId,
    this.token,
  });

  final bool isAuthenticated;
  final String? userId;
  final String? token;

  AuthState copyWith({
    bool? isAuthenticated,
    String? userId,
    String? token,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      userId: userId ?? this.userId,
      token: token ?? this.token,
    );
  }
}

/// 認証状態管理 Notifier
///
/// refreshListenable で使用するため、状態変更時に通知を行う。
@Riverpod(keepAlive: true)
class AuthStateNotifier extends _$AuthStateNotifier {
  @override
  AuthState build() {
    return const AuthState();
  }

  /// ログイン
  void login({required String userId, required String token}) {
    state = AuthState(
      isAuthenticated: true,
      userId: userId,
      token: token,
    );
  }

  /// ログアウト
  void logout() {
    state = const AuthState();
  }
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
/// - redirect で認証ガード
/// - ShellRoute でタブナビゲーション
@Riverpod(keepAlive: true)
GoRouter appRouter(AppRouterRef ref) {
  final authState = ref.watch(authStateProvider);
  final authChangeNotifier = AuthChangeNotifier(ref);

  ref.onDispose(authChangeNotifier.dispose);

  return GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: kDebugMode,
    refreshListenable: authChangeNotifier,
    redirect: (context, state) => _guardRoute(authState, state),
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
/// - 認証済み時: ウェルカム/認証ルートからホームへリダイレクト
String? _guardRoute(AuthState authState, GoRouterState state) {
  return guardRoute(authState, state);
}

/// 認証ガード（テスト用に公開）
String? guardRoute(AuthState authState, GoRouterState state) {
  final isAuthenticated = authState.isAuthenticated;
  final currentLocation = state.matchedLocation;
  final isAuthRoute = currentLocation.startsWith('/auth');
  final isWelcomeRoute = currentLocation == AppRoutes.welcome;

  // 未認証かつ認証ルートでもウェルカムでもない → ウェルカム画面へ
  if (!isAuthenticated && !isAuthRoute && !isWelcomeRoute) {
    return AppRoutes.welcome;
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

    // メインシェル（タブナビゲーション）
    ShellRoute(
      builder: (context, state, child) => _MainShell(child: child),
      routes: [
        // ホーム
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
          pageBuilder: (context, state) => NoTransitionPage(
            child: _SearchScreen(
              params: SearchParams.fromQueryParameters(
                queryParameters: state.uri.queryParameters,
              ),
            ),
          ),
        ),
        // プロファイル
        GoRoute(
          path: AppRoutes.profileTab,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: _ProfileScreen(),
          ),
        ),
        // 本詳細
        GoRoute(
          path: '/books/:bookId',
          builder: (context, state) => _BookDetailScreen(
            params: BookDetailParams.fromState(
              pathParameters: state.pathParameters,
            ),
          ),
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
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:
              context.go(AppRoutes.homeTab);
            case 1:
              context.go(AppRoutes.searchTab);
            case 2:
              context.go(AppRoutes.profileTab);
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
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

/// プレースホルダー: ホーム画面
class _HomeScreen extends StatelessWidget {
  const _HomeScreen();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Home'));
  }
}

/// プレースホルダー: 検索画面
class _SearchScreen extends StatelessWidget {
  const _SearchScreen({required this.params});

  final SearchParams params;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Search: ${params.query}, Page: ${params.page}'),
    );
  }
}

/// プレースホルダー: プロファイル画面
class _ProfileScreen extends StatelessWidget {
  const _ProfileScreen();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profile'));
  }
}

/// プレースホルダー: 本詳細画面
class _BookDetailScreen extends StatelessWidget {
  const _BookDetailScreen({required this.params});

  final BookDetailParams params;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book: ${params.bookId}')),
      body: Center(child: Text('Book ID: ${params.bookId}')),
    );
  }
}
