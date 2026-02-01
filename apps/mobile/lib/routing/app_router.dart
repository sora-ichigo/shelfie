/// App router configuration using go_router.
library;

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/auth/auth_state.dart';

import 'package:shelfie/core/constants/legal_urls.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/features/account/application/account_notifier.dart';
import 'package:shelfie/features/account/presentation/account_screen.dart';
import 'package:shelfie/features/account/presentation/password_settings_screen.dart';
import 'package:shelfie/features/account/presentation/profile_edit_screen.dart';
import 'package:shelfie/features/book_detail/presentation/book_detail_screen.dart';
import 'package:shelfie/features/book_list/presentation/book_list_detail_screen.dart';
import 'package:shelfie/features/book_list/presentation/book_list_edit_screen.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart'
    show BookSource;
import 'package:shelfie/features/book_search/presentation/isbn_scan_screen.dart';
import 'package:shelfie/features/book_search/presentation/search_screen.dart';
import 'package:shelfie/features/book_shelf/presentation/book_shelf_screen.dart';
import 'package:shelfie/features/login/presentation/login_screen.dart';
import 'package:shelfie/features/registration/presentation/registration_screen.dart';
import 'package:shelfie/features/welcome/presentation/welcome_screen.dart';

part 'app_router.g.dart';

/// ナビゲーションバーの非表示状態を管理する Provider
///
/// 検索画面でフォーカスが当たっている間は true に設定される。
final navBarHiddenProvider = StateProvider<bool>((ref) => false);

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
  static String bookDetail({required String bookId, required BookSource source}) {
    return '/books/$bookId?source=${source.name}';
  }

  /// 検索画面（クエリパラメータ付き）
  static String searchWithQuery({required String query}) =>
      '$searchTab?q=${Uri.encodeComponent(query)}';

  /// リスト詳細画面パスを生成
  static String bookListDetail({required int listId}) => '/lists/$listId';

  /// リスト作成画面
  static const bookListCreate = '/lists/new';

  /// リスト編集画面パスを生成
  static String bookListEdit({required int listId}) => '/lists/$listId/edit';
}

/// 本詳細画面のパラメータ
class BookDetailParams {
  const BookDetailParams({required this.bookId, required this.source});

  /// GoRouterState から BookDetailParams を生成
  factory BookDetailParams.fromState({
    required Map<String, String> pathParameters,
    Map<String, String>? queryParameters,
  }) {
    return BookDetailParams(
      bookId: pathParameters['bookId'] ?? '',
      source: queryParameters?['source'] ?? 'rakuten',
    );
  }

  final String bookId;
  final String source;
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

/// リスト画面のパラメータ
class BookListParams {
  const BookListParams({required this.listId});

  /// GoRouterState から BookListParams を生成
  factory BookListParams.fromState({
    required Map<String, String> pathParameters,
  }) {
    return BookListParams(
      listId: int.tryParse(pathParameters['listId'] ?? '0') ?? 0,
    );
  }

  final int listId;
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
GoRouter appRouter(Ref ref) {
  final authState = ref.watch(authStateProvider);
  final authChangeNotifier = AuthChangeNotifier(ref);

  ref.onDispose(authChangeNotifier.dispose);

  return GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: kDebugMode,
    refreshListenable: authChangeNotifier,
    redirect: (context, state) => guardRoute(
      authState: authState,
      state: state,
    ),
    onException: (context, state, router) {
      router.go(AppRoutes.error);
    },
    routes: _buildRoutes(),
  );
}

/// 認証ガード（テスト用に公開）
///
/// 認証状態に基づいてルートをリダイレクトする。
/// - 未認証時: 保護されたルートからウェルカム画面へリダイレクト
/// - 認証済み時: ウェルカム/認証ルートからホームへリダイレクト
String? guardRoute({
  required AuthStateData authState,
  required GoRouterState state,
}) {
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
            : BookSource.rakuten;
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
        ),
      ],
    ),

    // リスト作成画面（タブバーなし）
    GoRoute(
      path: AppRoutes.bookListCreate,
      pageBuilder: (context, state) => const CupertinoPage(
        child: BookListEditScreen(),
      ),
    ),

    // ISBN スキャン画面（タブバーなし）
    GoRoute(
      path: AppRoutes.isbnScan,
      pageBuilder: (context, state) => const CupertinoPage(
        fullscreenDialog: true,
        child: ISBNScanScreen(),
      ),
    ),

    // リスト詳細画面（タブバーなし）
    GoRoute(
      path: '/lists/:listId',
      pageBuilder: (context, state) {
        final params = BookListParams.fromState(
          pathParameters: state.pathParameters,
        );
        return CupertinoPage(
          child: BookListDetailScreen(listId: params.listId),
        );
      },
      routes: [
        // リスト編集画面（サブルート）
        GoRoute(
          path: 'edit',
          pageBuilder: (context, state) {
            final params = BookListParams.fromState(
              pathParameters: state.pathParameters,
            );
            return CupertinoPage(
              child: BookListEditScreen(listId: params.listId),
            );
          },
        ),
      ],
    ),
  ];
}

/// メインシェル（タブバー）
///
/// ShellRoute のビルダーとして使用され、プラットフォーム適応型ナビゲーションを提供する。
/// AdaptiveScaffold + AdaptiveBottomNavigationBar を使用し、
/// プラットフォーム判定は adaptive_platform_ui に完全委譲する。
class _MainShell extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = _calculateSelectedIndex(context);
    final isNavBarHidden = ref.watch(navBarHiddenProvider);

    void onTap(int index) {
      switch (index) {
        case 0:
          context.go(AppRoutes.homeTab);
        case 1:
          context.go(AppRoutes.searchTab);
      }
    }

    final navBar = AdaptiveBottomNavigationBar(
      selectedIndex: selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      cupertinoTabBar: CupertinoTabBar(
        currentIndex: selectedIndex,
        onTap: onTap,
        activeColor: Colors.white,
        inactiveColor: Colors.white70,
        backgroundColor: AppColors.dark.background,
        border: const Border(),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book),
            label: 'ライブラリ',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'さがす',
          ),
        ],
      ),
      onTap: onTap,
      items: const [
        AdaptiveNavigationDestination(
          icon: 'book.fill',
          label: 'ライブラリ',
        ),
        AdaptiveNavigationDestination(
          icon: 'magnifyingglass',
          label: 'さがす',
        ),
      ],
    );

    return AdaptiveScaffold(
      minimizeBehavior: TabBarMinimizeBehavior.never,
      body: Material(
        type: MaterialType.transparency,
        child: child,
      ),
      bottomNavigationBar: isNavBarHidden ? null : navBar,
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
