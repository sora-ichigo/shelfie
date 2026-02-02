import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/storage/secure_storage_service.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/core/widgets/screen_header.dart';
import 'package:shelfie/core/widgets/user_avatar.dart';
import 'package:shelfie/features/book_shelf/presentation/book_shelf_screen.dart';

import '../../../helpers/test_helpers.dart';

void main() {
  group('ゲストモード UI 制限', () {
    group('ScreenHeader', () {
      testWidgets('showAvatar: false でアバターアイコンが非表示', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.dark(),
            home: Scaffold(
              body: ScreenHeader(
                title: 'テスト',
                showAvatar: false,
              ),
            ),
          ),
        );

        expect(find.byType(UserAvatar), findsNothing);
        expect(find.text('テスト'), findsOneWidget);
      });

      testWidgets('showAvatar: true (デフォルト) でアバターアイコンが表示', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.dark(),
            home: Scaffold(
              body: ScreenHeader(
                title: 'テスト',
                onProfileTap: () {},
              ),
            ),
          ),
        );

        expect(find.byType(UserAvatar), findsOneWidget);
      });

      testWidgets('onProfileTap が null でも正常にレンダリングできる', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.dark(),
            home: Scaffold(
              body: ScreenHeader(
                title: 'テスト',
                showAvatar: true,
              ),
            ),
          ),
        );

        expect(find.text('テスト'), findsOneWidget);
        expect(find.byType(UserAvatar), findsOneWidget);
      });
    });

    group('BookShelfScreen ゲストモード', () {
      late MockSecureStorageService mockStorage;

      setUp(() {
        mockStorage = MockSecureStorageService();
        when(() => mockStorage.saveGuestMode(isGuest: any(named: 'isGuest')))
            .thenAnswer((_) async {});
        when(() => mockStorage.loadGuestMode())
            .thenAnswer((_) async => false);
        when(() => mockStorage.clearGuestMode()).thenAnswer((_) async {});
        when(() => mockStorage.saveAuthData(
              userId: any(named: 'userId'),
              email: any(named: 'email'),
              idToken: any(named: 'idToken'),
              refreshToken: any(named: 'refreshToken'),
            )).thenAnswer((_) async {});
        when(() => mockStorage.clearAuthData()).thenAnswer((_) async {});
        when(() => mockStorage.loadAuthData())
            .thenAnswer((_) async => null);
        when(() => mockStorage.updateTokens(
              idToken: any(named: 'idToken'),
              refreshToken: any(named: 'refreshToken'),
            )).thenAnswer((_) async {});
      });

      testWidgets('ゲストモード時にログイン促進メッセージが表示される', (tester) async {
        final container = createTestContainer(
          overrides: [
            secureStorageServiceProvider.overrideWithValue(mockStorage),
          ],
        );
        addTearDown(container.dispose);

        await container.read(authStateProvider.notifier).enterGuestMode();

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: MaterialApp(
              theme: AppTheme.dark(),
              home: const BookShelfScreen(),
            ),
          ),
        );
        await tester.pump();

        expect(
          find.text('ログインしてライブラリを利用しましょう'),
          findsOneWidget,
        );
      });

      testWidgets('ゲストモード時にログインボタンが表示される', (tester) async {
        final container = createTestContainer(
          overrides: [
            secureStorageServiceProvider.overrideWithValue(mockStorage),
          ],
        );
        addTearDown(container.dispose);

        await container.read(authStateProvider.notifier).enterGuestMode();

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: MaterialApp(
              theme: AppTheme.dark(),
              home: const BookShelfScreen(),
            ),
          ),
        );
        await tester.pump();

        expect(find.text('ログイン / 新規登録'), findsOneWidget);
        expect(find.byType(FilledButton), findsOneWidget);
      });

      testWidgets('ゲストモード時にアバターアイコンが非表示になる', (tester) async {
        final container = createTestContainer(
          overrides: [
            secureStorageServiceProvider.overrideWithValue(mockStorage),
          ],
        );
        addTearDown(container.dispose);

        await container.read(authStateProvider.notifier).enterGuestMode();

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: MaterialApp(
              theme: AppTheme.dark(),
              home: const BookShelfScreen(),
            ),
          ),
        );
        await tester.pump();

        expect(find.byType(UserAvatar), findsNothing);
      });

      testWidgets('ゲストモード時にライブラリアイコンが表示される', (tester) async {
        final container = createTestContainer(
          overrides: [
            secureStorageServiceProvider.overrideWithValue(mockStorage),
          ],
        );
        addTearDown(container.dispose);

        await container.read(authStateProvider.notifier).enterGuestMode();

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: MaterialApp(
              theme: AppTheme.dark(),
              home: const BookShelfScreen(),
            ),
          ),
        );
        await tester.pump();

        expect(find.byIcon(Icons.library_books_outlined), findsOneWidget);
      });
    });
  });
}
