import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shelfie/app/app.dart';
import 'package:shelfie/app/providers.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/auth/session_validator.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/features/book_search/data/recent_books_repository.dart';
import 'package:shelfie/features/book_search/data/search_history_repository.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_settings_repository.dart';
import 'package:shelfie/features/push_notification/application/foreground_notification_handler.dart';
import 'package:shelfie/features/push_notification/application/push_notification_initializer.dart';
import 'package:shelfie/firebase_options.dart';

const _sentryDsn =
    'https://6aa9de3b859cc4bf651d397f4d7c8409@o4510782375395328.ingest.us.sentry.io/4510785500348416';

/// アプリケーションのエントリポイント
///
/// 初期化処理の順序:
/// 1. Sentry の初期化（本番環境でエラー監視）
/// 2. Hive の初期化（ローカルストレージ）
/// 3. ErrorHandler の初期化
/// 4. ProviderScope でアプリをラップして起動
Future<void> main() async {
  if (kReleaseMode) {
    await SentryFlutter.init(
      (options) {
        options.dsn = _sentryDsn;
        options.tracesSampleRate = 0.2;
        options.environment = 'production';
        options.enableAutoSessionTracking = true;
        options.attachThreads = true;
        options.enableAutoNativeBreadcrumbs = true;
      },
      appRunner: () => _initAndRunApp(),
    );
  } else {
    await _initAndRunApp();
  }
}

Future<void> _initAndRunApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  GoogleFonts.config.allowRuntimeFetching = false;

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: AppColors.dark.background,
    ),
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();

  await Future.wait([
    Hive.openBox<Map<dynamic, dynamic>>(searchHistoryBoxName),
    Hive.openBox<Map<dynamic, dynamic>>(recentBooksBoxName),
    Hive.openBox<String>(bookShelfSettingsBoxName),
  ]);

  runApp(
    const ProviderScope(
      child: _AppInitializer(),
    ),
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

    // プッシュ通知の初期化
    await _initializePushNotifications();

    // セキュアストレージから認証状態を復元
    await ref.read(authStateProvider.notifier).restoreSession();

    if (mounted) {
      setState(() {
        _initialized = true;
      });
      _validateSessionInBackground();
    }
  }

  Future<void> _initializePushNotifications() async {
    try {
      final localNotifications = FlutterLocalNotificationsPlugin();
      final messaging = FirebaseMessaging.instance;

      final initializer = PushNotificationInitializer(
        messaging: messaging,
        localNotifications: localNotifications,
      );
      await initializer.initialize();

      final foregroundHandler = ForegroundNotificationHandler(
        localNotifications: localNotifications,
      );
      foregroundHandler.handleForegroundMessage(
        FirebaseMessaging.onMessage,
      );
    } catch (e) {
      debugPrint('[PushNotification] Initialization failed: $e');
    }
  }

  void _validateSessionInBackground() {
    final authState = ref.read(authStateProvider);
    if (!authState.isAuthenticated) return;

    final sessionValidator = ref.read(sessionValidatorProvider);
    sessionValidator.validate().then((result) {
      if (!mounted) return;
      if (result is SessionInvalid) {
        ref.read(authStateProvider.notifier).logout();
      }
    });
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
