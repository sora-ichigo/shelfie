import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shelfie/app/app.dart';
import 'package:shelfie/app/providers.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/features/book_search/data/recent_books_repository.dart';
import 'package:shelfie/features/book_search/data/search_history_repository.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_settings_repository.dart';

/// Sentry DSN（--dart-define で渡す）
const _sentryDsn = String.fromEnvironment('SENTRY_DSN');

/// アプリケーションのエントリポイント
///
/// 初期化処理の順序:
/// 1. Sentry の初期化（本番環境でエラー監視）
/// 2. Hive の初期化（ローカルストレージ）
/// 3. ErrorHandler の初期化
/// 4. ProviderScope でアプリをラップして起動
Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = _sentryDsn.isNotEmpty ? _sentryDsn : null;
      options.tracesSampleRate = kReleaseMode ? 0.2 : 1.0;
      options.environment = kReleaseMode ? 'production' : 'development';
      options.enableAutoSessionTracking = true;
      options.attachThreads = true;
      options.enableAutoNativeBreadcrumbs = true;
    },
    appRunner: () async {
      // Google Fonts のランタイムフェッチを無効化（バンドルされたフォントを使用）
      GoogleFonts.config.allowRuntimeFetching = false;

      // Hive の初期化（オフラインキャッシュ用）
      await Hive.initFlutter();

      // 各種 Hive Box をオープン
      await Future.wait([
        Hive.openBox<Map<dynamic, dynamic>>(searchHistoryBoxName),
        Hive.openBox<Map<dynamic, dynamic>>(recentBooksBoxName),
        Hive.openBox<String>(bookShelfSettingsBoxName),
      ]);

      // アプリを ProviderScope でラップして起動
      runApp(
        const ProviderScope(
          child: _AppInitializer(),
        ),
      );
    },
  );
}

/// アプリ初期化用のウィジェット
///
/// ProviderScope 内で ErrorHandler を初期化し、
/// その後 ShelfieApp をビルドする。
class _AppInitializer extends ConsumerStatefulWidget {
  const _AppInitializer();

  @override
  ConsumerState<_AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends ConsumerState<_AppInitializer> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // ErrorHandler を初期化して、
    // FlutterError.onError と PlatformDispatcher.instance.onError を設定
    ref.read(errorHandlerProvider).initialize();

    // セキュアストレージから認証状態を復元
    await ref.read(authStateProvider.notifier).restoreSession();

    if (mounted) {
      setState(() {
        _initialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return const ShelfieApp();
  }
}
