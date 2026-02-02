import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/storage/secure_storage_service.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/welcome/presentation/welcome_screen.dart';
import 'package:shelfie/features/welcome/presentation/widgets/legal_links.dart';
import 'package:shelfie/features/welcome/presentation/widgets/welcome_background.dart';
import 'package:shelfie/features/welcome/presentation/widgets/welcome_buttons.dart';
import 'package:shelfie/features/welcome/presentation/widgets/welcome_logo.dart';

import '../../../helpers/test_helpers.dart';

void main() {
  group('WelcomeScreen', () {
    testWidgets('SafeArea が適用されている', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const WelcomeScreen(),
          ),
        ),
      );

      expect(find.byType(SafeArea), findsOneWidget);
    });

    testWidgets('背景が表示される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const WelcomeScreen(),
          ),
        ),
      );

      expect(find.byType(WelcomeBackground), findsOneWidget);
    });

    testWidgets('ロゴが表示される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const WelcomeScreen(),
          ),
        ),
      );

      expect(find.byType(WelcomeLogo), findsOneWidget);
    });

    testWidgets('ボタンが表示される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const WelcomeScreen(),
          ),
        ),
      );

      expect(find.byType(WelcomeButtons), findsOneWidget);
    });

    testWidgets('リンクが表示される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const WelcomeScreen(),
          ),
        ),
      );

      expect(find.byType(LegalLinks), findsOneWidget);
    });

    testWidgets('異なる画面サイズでレイアウトが崩れない', (tester) async {
      await tester.binding.setSurfaceSize(const Size(375, 667));

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const WelcomeScreen(),
          ),
        ),
      );

      expect(find.byType(WelcomeScreen), findsOneWidget);
      expect(find.byType(WelcomeLogo), findsOneWidget);
      expect(find.byType(WelcomeButtons), findsOneWidget);

      await tester.binding.setSurfaceSize(const Size(428, 926));

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const WelcomeScreen(),
          ),
        ),
      );

      expect(find.byType(WelcomeScreen), findsOneWidget);
      expect(find.byType(WelcomeLogo), findsOneWidget);
      expect(find.byType(WelcomeButtons), findsOneWidget);

      addTearDown(() => tester.binding.setSurfaceSize(null));
    });
  });

  group('WelcomeScreen ゲストモード', () {
    late MockSecureStorageService mockStorage;

    setUp(() {
      mockStorage = MockSecureStorageService();
      when(() => mockStorage.saveGuestMode(isGuest: any(named: 'isGuest')))
          .thenAnswer((_) async {});
      when(() => mockStorage.loadGuestMode()).thenAnswer((_) async => false);
      when(() => mockStorage.clearGuestMode()).thenAnswer((_) async {});
      when(() => mockStorage.saveAuthData(
            userId: any(named: 'userId'),
            email: any(named: 'email'),
            idToken: any(named: 'idToken'),
            refreshToken: any(named: 'refreshToken'),
          )).thenAnswer((_) async {});
      when(() => mockStorage.clearAuthData()).thenAnswer((_) async {});
      when(() => mockStorage.loadAuthData()).thenAnswer((_) async => null);
      when(() => mockStorage.updateTokens(
            idToken: any(named: 'idToken'),
            refreshToken: any(named: 'refreshToken'),
          )).thenAnswer((_) async {});
    });

    testWidgets('「アカウントなしで利用」リンクが表示される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            secureStorageServiceProvider.overrideWithValue(mockStorage),
          ],
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const WelcomeScreen(),
          ),
        ),
      );

      expect(find.text('アカウントなしで利用'), findsOneWidget);
    });

    testWidgets('「アカウントなしで利用」タップで enterGuestMode が呼ばれる',
        (tester) async {
      final container = createTestContainer(
        overrides: [
          secureStorageServiceProvider.overrideWithValue(mockStorage),
        ],
      );
      addTearDown(container.dispose);

      expect(container.read(authStateProvider).isGuest, isFalse);

      await container.read(authStateProvider.notifier).enterGuestMode();

      expect(container.read(authStateProvider).isGuest, isTrue);
      verify(() => mockStorage.saveGuestMode(isGuest: true)).called(1);
    });

    testWidgets('ログインボタンと新規登録ボタンは通常通り表示される', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            secureStorageServiceProvider.overrideWithValue(mockStorage),
          ],
          child: MaterialApp(
            theme: AppTheme.dark(),
            home: const WelcomeScreen(),
          ),
        ),
      );

      expect(find.text('ログイン'), findsOneWidget);
      expect(find.text('新規登録'), findsOneWidget);
      expect(find.text('アカウントなしで利用'), findsOneWidget);
    });
  });
}
