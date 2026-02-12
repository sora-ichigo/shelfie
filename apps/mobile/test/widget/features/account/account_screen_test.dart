import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/account/application/account_notifier.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';
import 'package:shelfie/features/account/presentation/account_screen.dart';

void main() {
  final testProfile = UserProfile(
    id: 1,
    email: 'test@example.com',
    name: 'Test User',
    avatarUrl: null,
    handle: '@testuser',
    bookCount: 42,
    bio: null,
    instagramHandle: null,
    readingStartYear: 2020,
    readingStartMonth: 1,
    createdAt: DateTime(2023, 1, 1),
  );

  Widget buildTestAccountScreen({
    required AsyncValue<UserProfile> accountState,
    VoidCallback? onNavigateToProfileEdit,
    VoidCallback? onNavigateToPassword,
    VoidCallback? onNavigateToTerms,
    VoidCallback? onNavigateToPrivacy,
    VoidCallback? onNavigateToInquiry,
    VoidCallback? onLogout,
    VoidCallback? onDeleteAccount,
    VoidCallback? onClose,
  }) {
    return ProviderScope(
      overrides: [
        accountNotifierProvider.overrideWith(
          () => _TestAccountNotifier(accountState),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.theme,
        home: AccountScreen(
          onNavigateToProfileEdit: onNavigateToProfileEdit ?? () {},
          onNavigateToPassword: onNavigateToPassword ?? () {},
          onNavigateToTerms: onNavigateToTerms ?? () {},
          onNavigateToPrivacy: onNavigateToPrivacy ?? () {},
          onNavigateToInquiry: onNavigateToInquiry ?? () {},
          onLogout: onLogout ?? () {},
          onDeleteAccount: onDeleteAccount ?? () {},
          onClose: onClose,
        ),
      ),
    );
  }

  group('AccountScreen', () {
    testWidgets('displays back button in app bar', (tester) async {
      await tester.pumpWidget(
        buildTestAccountScreen(
          accountState: AsyncValue.data(testProfile),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);
    });

    testWidgets('displays profile card when data is loaded', (tester) async {
      await tester.pumpWidget(
        buildTestAccountScreen(
          accountState: AsyncValue.data(testProfile),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('42'), findsOneWidget);
      expect(find.text('2020/1'), findsOneWidget);
    });

    testWidgets(
      'displays loading indicator when loading',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              accountNotifierProvider.overrideWith(
                () => _LoadingAccountNotifier(),
              ),
            ],
            child: MaterialApp(
              theme: AppTheme.theme,
              home: AccountScreen(
                onNavigateToProfileEdit: () {},
                onNavigateToPassword: () {},
                onNavigateToTerms: () {},
                onNavigateToPrivacy: () {},
                onNavigateToInquiry: () {},
                onLogout: () {},
                onDeleteAccount: () {},
              ),
            ),
          ),
        );
        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
      skip: true,
    );

    testWidgets('displays error view when error occurs', (tester) async {
      await tester.pumpWidget(
        buildTestAccountScreen(
          accountState: AsyncValue.error(
            const UnexpectedFailure(message: 'Test error'),
            StackTrace.current,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('displays account menu section with profile edit',
        (tester) async {
      await tester.pumpWidget(
        buildTestAccountScreen(
          accountState: AsyncValue.data(testProfile),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('プロフィール編集'), findsOneWidget);
    });

    testWidgets('displays settings menu section', (tester) async {
      await tester.pumpWidget(
        buildTestAccountScreen(
          accountState: AsyncValue.data(testProfile),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('設定'), findsOneWidget);
      expect(find.text('パスワード設定'), findsOneWidget);
    });

    testWidgets('navigates to profile edit when tapped', (tester) async {
      var navigated = false;

      await tester.pumpWidget(
        buildTestAccountScreen(
          accountState: AsyncValue.data(testProfile),
          onNavigateToProfileEdit: () => navigated = true,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('プロフィール編集'));
      await tester.pumpAndSettle();

      expect(navigated, isTrue);
    });

    testWidgets('navigates to password when tapped', (tester) async {
      var navigated = false;

      await tester.pumpWidget(
        buildTestAccountScreen(
          accountState: AsyncValue.data(testProfile),
          onNavigateToPassword: () => navigated = true,
        ),
      );
      await tester.pumpAndSettle();

      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -100));
      await tester.pumpAndSettle();

      await tester.tap(find.text('パスワード設定'));
      await tester.pumpAndSettle();

      expect(navigated, isTrue);
    });

    testWidgets('displays chevron icons for all menu items', (tester) async {
      await tester.pumpWidget(
        buildTestAccountScreen(
          accountState: AsyncValue.data(testProfile),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.chevron_right), findsNWidgets(6));
    });

    testWidgets('calls onClose when back button is tapped', (tester) async {
      var closed = false;

      await tester.pumpWidget(
        buildTestAccountScreen(
          accountState: AsyncValue.data(testProfile),
          onClose: () => closed = true,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
      await tester.pumpAndSettle();

      expect(closed, isTrue);
    });
  });
}

class _TestAccountNotifier extends AccountNotifier {
  _TestAccountNotifier(this._initialState);

  final AsyncValue<UserProfile> _initialState;

  @override
  Future<UserProfile> build() async {
    if (_initialState is AsyncError) {
      final error = _initialState as AsyncError<UserProfile>;
      throw error.error;
    }
    return _initialState.value!;
  }

  @override
  Future<void> refresh() async {}
}

class _LoadingAccountNotifier extends AccountNotifier {
  @override
  Future<UserProfile> build() async {
    await Future<void>.delayed(const Duration(days: 365));
    throw Exception('Never completes');
  }

  @override
  Future<void> refresh() async {}
}
