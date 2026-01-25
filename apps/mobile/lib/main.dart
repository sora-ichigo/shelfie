import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shelfie/app/app.dart';
import 'package:shelfie/app/providers.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/features/book_search/data/recent_books_repository.dart';
import 'package:shelfie/features/book_search/data/search_history_repository.dart';

/// アプリケーションのエントリポイント
///
/// 初期化処理の順序:
/// 1. Hive の初期化（ローカルストレージ）
/// 2. ErrorHandler の初期化（runZonedGuarded 内で実行）
/// 3. ProviderScope でアプリをラップして起動
///
/// runZonedGuarded を使用して、未処理の非同期エラーをキャッチする。
void main() {
  runZonedGuarded(
    () async {
      // Flutter バインディングの初期化
      WidgetsFlutterBinding.ensureInitialized();

      // Google Fonts のランタイムフェッチを無効化（バンドルされたフォントを使用）
      GoogleFonts.config.allowRuntimeFetching = false;

      // Hive の初期化（オフラインキャッシュ用）
      await Hive.initFlutter();

      // 検索履歴・最近チェックした本用の Hive Box をオープン
      await Future.wait([
        Hive.openBox<Map<dynamic, dynamic>>(searchHistoryBoxName),
        Hive.openBox<Map<dynamic, dynamic>>(recentBooksBoxName),
      ]);

      // アプリを ProviderScope でラップして起動
      runApp(
        const ProviderScope(
          child: _AppInitializer(),
        ),
      );
    },
    (error, stackTrace) {
      // 未処理のエラーをログ出力
      // ErrorHandler は ProviderScope 内で初期化されるため、
      // ここでは直接アクセスできない
      debugPrint('[FATAL] Unhandled error: $error');
      debugPrint(stackTrace.toString());
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
