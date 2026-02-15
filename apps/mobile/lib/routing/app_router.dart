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
import 'package:shelfie/core/constants/legal_urls.dart';
import 'package:shelfie/core/state/profile_version.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/widgets/add_book_bottom_sheet.dart';
import 'package:shelfie/features/account/application/account_notifier.dart';
import 'package:shelfie/features/account/data/account_repository.dart';
import 'package:shelfie/features/account/presentation/account_screen.dart';
import 'package:shelfie/features/account/presentation/password_settings_screen.dart';
import 'package:shelfie/features/account/presentation/profile_edit_screen.dart';
import 'package:shelfie/features/account/presentation/profile_screen.dart';
import 'package:shelfie/features/book_detail/presentation/book_detail_screen.dart';
import 'package:shelfie/features/book_list/presentation/book_list_detail_screen.dart';
import 'package:shelfie/features/book_list/presentation/book_list_edit_screen.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart'
    show BookSource;
import 'package:shelfie/features/book_search/presentation/isbn_scan_screen.dart';
import 'package:shelfie/features/book_search/presentation/search_screen.dart'
    show SearchScreen, searchAutoFocusProvider;
import 'package:shelfie/features/book_search/presentation/widgets/isbn_scan_result_dialog.dart';
import 'package:shelfie/features/follow/data/follow_repository.dart';
import 'package:shelfie/features/follow/domain/follow_list_type.dart';
import 'package:shelfie/features/follow/domain/user_profile_model.dart';
import 'package:shelfie/features/follow/presentation/follow_list_screen.dart';
import 'package:shelfie/features/follow/presentation/user_profile_screen.dart';
import 'package:shelfie/features/login/presentation/login_screen.dart';
import 'package:shelfie/features/notification/application/unread_notification_count.dart';
import 'package:shelfie/features/notification/presentation/notification_screen.dart';
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

  /// 検索タブ
  static const searchTab = '/search';

  /// プロフィール画面（タブ）
  static const profileTab = '/profile';

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
  static String bookDetail({
    required String bookId,
    required BookSource source,
  }) {
    return '/books/$bookId?source=${source.name}';
  }

  /// 検索画面（クエリパラメータ付き）
  static String searchWithQuery({required String query}) =>
      '$searchTab?q=${Uri.encodeComponent(query)}';

  /// リスト詳細画面パスを生成
  static String bookListDetail({required int listId}) => '/lists/$listId';

  /// リスト編集画面パスを生成
  static String bookListEdit({required int listId}) => '/lists/$listId/edit';

  /// お知らせタブ
  static const notificationsTab = '/notifications';

  /// フォロー/フォロワー一覧画面パスを生成
  static String followList({required int userId, required String type}) =>
      '/users/$userId/$type';

  /// 他ユーザープロフィール画面パスを生成
  static String userProfile({required String handle}) => '/u/$handle';
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
  const SearchParams({this.query = '', this.page = 1});

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
    redirect: (context, state) =>
        guardRoute(authState: authState, state: state),
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
  final isGuest = authState.isGuest;
  final currentLocation = state.matchedLocation;
  final isAuthRoute = currentLocation.startsWith('/auth');
  final isWelcomeRoute = currentLocation == AppRoutes.welcome;
  final isPublicProfileRoute = currentLocation.startsWith('/u/');

  // 認証済みかつ（認証ルート または ウェルカム） -> ホームへ
  if (isAuthenticated && (isAuthRoute || isWelcomeRoute)) {
    return AppRoutes.home;
  }

  // ゲストモード時のルート判定
  if (isGuest) {
    final isGuestAllowed =
        currentLocation == '/' ||
        currentLocation == AppRoutes.searchTab ||
        currentLocation == AppRoutes.isbnScan ||
        currentLocation.startsWith('/books/') ||
        currentLocation == AppRoutes.profileTab ||
        currentLocation == AppRoutes.notificationsTab ||
        currentLocation == AppRoutes.account ||
        isPublicProfileRoute ||
        isWelcomeRoute ||
        isAuthRoute;

    if (!isGuestAllowed) {
      return AppRoutes.welcome;
    }
    return null;
  }

  // 未認証かつ認証ルートでもウェルカムでもない -> ウェルカム画面へ
  if (!isAuthenticated && !isAuthRoute && !isWelcomeRoute &&
      !isPublicProfileRoute) {
    return AppRoutes.welcome;
  }

  return null;
}

/// ルート定義を構築
List<RouteBase> _buildRoutes() {
  return [
    // ウェルカム画面
    GoRoute(
      path: AppRoutes.welcome,
      pageBuilder: (context, state) =>
          const CupertinoPage(child: WelcomeScreen()),
    ),

    // ログイン画面
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (context, state) =>
          const CupertinoPage(child: LoginScreen()),
    ),

    // 新規登録画面
    GoRoute(
      path: AppRoutes.register,
      pageBuilder: (context, state) =>
          const CupertinoPage(child: RegistrationScreen()),
    ),

    // エラー画面
    GoRoute(
      path: AppRoutes.error,
      pageBuilder: (context, state) =>
          const CupertinoPage(child: _ErrorScreen()),
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
            onNavigateToInquiry: LegalUrls.openInquiryForm,
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
            onDeleteAccount: () async {
              final result = await showOkCancelAlertDialog(
                context: context,
                title: '退会する',
                message: '退会すると、すべてのデータが完全に削除されます。この操作は取り消せません。',
                okLabel: '退会する',
                cancelLabel: 'キャンセル',
                isDestructiveAction: true,
              );
              if (result == OkCancelResult.ok && context.mounted) {
                final repository = ref.read(accountRepositoryProvider);
                final deleteResult = await repository.deleteAccount();
                await deleteResult.fold(
                  (failure) async {
                    if (context.mounted) {
                      await showOkAlertDialog(
                        context: context,
                        title: 'エラー',
                        message: '退会処理に失敗しました。',
                      );
                    }
                  },
                  (_) async {
                    if (context.mounted) {
                      await ref.read(authStateProvider.notifier).logout();
                    }
                  },
                );
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
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          _MainShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.searchTab,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: SearchScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.notificationsTab,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: NotificationScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ProfileScreen()),
            ),
            GoRoute(
              path: AppRoutes.profileTab,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ProfileScreen()),
            ),
          ],
        ),
      ],
    ),

    // フォロー/フォロワー一覧画面（タブバーなし）
    GoRoute(
      path: '/users/:userId/following',
      pageBuilder: (context, state) {
        final userId =
            int.tryParse(state.pathParameters['userId'] ?? '0') ?? 0;
        return CupertinoPage(
          child: FollowListScreen(
            userId: userId,
            listType: FollowListType.following,
            onUserTap: (user) {
              if (user.handle != null) {
                context.push(AppRoutes.userProfile(handle: user.handle!));
              }
            },
          ),
        );
      },
    ),
    GoRoute(
      path: '/users/:userId/followers',
      pageBuilder: (context, state) {
        final userId =
            int.tryParse(state.pathParameters['userId'] ?? '0') ?? 0;
        return CupertinoPage(
          child: FollowListScreen(
            userId: userId,
            listType: FollowListType.followers,
            onUserTap: (user) {
              if (user.handle != null) {
                context.push(AppRoutes.userProfile(handle: user.handle!));
              }
            },
          ),
        );
      },
    ),

    // 他ユーザープロフィール画面（タブバーなし）
    GoRoute(
      path: '/u/:handle',
      pageBuilder: (context, state) {
        final handle = state.pathParameters['handle'] ?? '';
        return CupertinoPage(
          child: _UserProfileByHandleScreen(handle: handle),
        );
      },
    ),

    // ISBN スキャン画面（タブバーなし）
    GoRoute(
      path: AppRoutes.isbnScan,
      pageBuilder: (context, state) =>
          const CupertinoPage(fullscreenDialog: true, child: ISBNScanScreen()),
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
/// ShellRoute のビルダーとして使用され、CupertinoTabBar によるナビゲーションを提供する。
/// タブ構成: [検索(0), +追加(1:特殊), お知らせ(2), プロフィール(3)]
class _MainShell extends ConsumerWidget {
  const _MainShell({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const int _addButtonIndex = 1;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final branchIndex = navigationShell.currentIndex;
    final tabBarIndex = branchIndex >= _addButtonIndex
        ? branchIndex + 1
        : branchIndex;
    final appColors = Theme.of(context).extension<AppColors>()!;
    final unreadCount = ref.watch(unreadNotificationCountProvider);

    void onTap(int index) {
      if (index == _addButtonIndex) {
        () async {
          final option = await showAddBookBottomSheet(context: context);
          if (!context.mounted) return;
          switch (option) {
            case AddBookOption.search:
              context.go(AppRoutes.searchTab);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  ref.read(searchAutoFocusProvider.notifier).state = true;
                }
              });
            case AddBookOption.camera:
              final isbn = await context.push<String>(AppRoutes.isbnScan);
              if (isbn != null && context.mounted) {
                await ISBNScanResultDialog.show(context, isbn);
              }
            case null:
              break;
          }
        }();
        return;
      }
      final branch = index > _addButtonIndex ? index - 1 : index;
      navigationShell.goBranch(
        branch,
        initialLocation: branch == navigationShell.currentIndex,
      );
    }

    final badgeCount = unreadCount.valueOrNull ?? 0;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: appColors.backgroundLegacy,
      ),
      child: Scaffold(
        body: navigationShell,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: appColors.backgroundLegacy,
            border: Border(
              top: BorderSide(color: appColors.borderLegacy, width: 0.5),
            ),
          ),
          child: CupertinoTabBar(
            currentIndex: tabBarIndex,
            onTap: onTap,
            activeColor: appColors.textPrimaryLegacy,
            inactiveColor: appColors.textSecondaryLegacy,
            backgroundColor: appColors.backgroundLegacy,
            border: const Border(),
            items: [
              BottomNavigationBarItem(
                icon: const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Icon(CupertinoIcons.search),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Icon(
                    CupertinoIcons.search,
                    shadows: [Shadow(blurRadius: 3, color: appColors.textPrimaryLegacy)],
                  ),
                ),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Icon(CupertinoIcons.plus),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: _BellIcon(
                    icon: CupertinoIcons.bell,
                    badgeCount: badgeCount,
                    appColors: appColors,
                  ),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: _BellIcon(
                    icon: CupertinoIcons.bell_fill,
                    badgeCount: badgeCount,
                    appColors: appColors,
                    isActive: true,
                  ),
                ),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Icon(CupertinoIcons.person),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Icon(CupertinoIcons.person_fill),
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BellIcon extends StatelessWidget {
  const _BellIcon({
    required this.icon,
    required this.badgeCount,
    required this.appColors,
    this.isActive = false,
  });

  final IconData icon;
  final int badgeCount;
  final AppColors appColors;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(
          icon,
          shadows: isActive
              ? [Shadow(blurRadius: 3, color: appColors.textPrimaryLegacy)]
              : null,
        ),
        if (badgeCount > 0)
          Positioned(
            right: -6,
            top: -4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: appColors.destructiveLegacy,
                borderRadius: BorderRadius.circular(8),
              ),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 14),
              child: Text(
                badgeCount > 99 ? '99+' : '$badgeCount',
                style: TextStyle(
                  color: appColors.textPrimaryLegacy,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

/// handle からユーザープロフィールを取得して表示するラッパー
class _UserProfileByHandleScreen extends ConsumerWidget {
  const _UserProfileByHandleScreen({required this.handle});

  final String handle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;
    final profileAsync = ref.watch(_userProfileByHandleProvider(handle));

    return profileAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          surfaceTintColor: Colors.transparent,
          scrolledUnderElevation: 0,
        ),
        body: Center(
          child: Text(
            'ユーザーが見つかりません',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: appColors.textSecondaryLegacy,
            ),
          ),
        ),
      ),
      data: (profile) => UserProfileScreen(
        profile: profile,
        onFollowingTap: () => context.push(
          AppRoutes.followList(userId: profile.user.id, type: 'following'),
        ),
        onFollowersTap: () => context.push(
          AppRoutes.followList(userId: profile.user.id, type: 'followers'),
        ),
      ),
    );
  }
}

@riverpod
Future<UserProfileModel> _userProfileByHandle(
  Ref ref,
  String handle,
) async {
  ref.watch(profileVersionProvider);
  final repo = ref.read(followRepositoryProvider);
  final result = await repo.getUserProfile(handle: handle);
  return result.fold(
    (failure) => throw failure,
    (profile) => profile,
  );
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
