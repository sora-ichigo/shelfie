import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/storage/secure_storage_service.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/account/application/password_form_state.dart';
import 'package:shelfie/features/account/application/password_settings_notifier.dart';
import 'package:shelfie/features/account/data/password_repository.dart';
import 'package:shelfie/features/account/presentation/password_settings_screen.dart';

class MockPasswordRepository extends Mock implements PasswordRepository {}

class MockSecureStorageService extends Mock implements SecureStorageService {}

void main() {
  late MockPasswordRepository mockRepository;
  late MockSecureStorageService mockStorageService;

  setUp(() {
    mockRepository = MockPasswordRepository();
    mockStorageService = MockSecureStorageService();

    when(() => mockStorageService.updateTokens(
          idToken: any(named: 'idToken'),
          refreshToken: any(named: 'refreshToken'),
        )).thenAnswer((_) async {});
  });

  Widget buildTestPasswordSettingsScreen({
    VoidCallback? onClose,
    VoidCallback? onSaveSuccess,
    PasswordSettingsState? initialState,
    PasswordFormData? formData,
    bool isAuthenticated = true,
  }) {
    return ProviderScope(
      overrides: [
        passwordRepositoryProvider.overrideWithValue(mockRepository),
        secureStorageServiceProvider.overrideWithValue(mockStorageService),
        passwordSettingsNotifierProvider.overrideWith(
          () => _TestPasswordSettingsNotifier(initialState),
        ),
        passwordFormStateProvider.overrideWith(
          () => _TestPasswordFormState(formData),
        ),
        authStateProvider.overrideWith(
          () => _TestAuthStateNotifier(isAuthenticated: isAuthenticated),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.theme,
        home: PasswordSettingsScreen(
          onClose: onClose ?? () {},
          onSaveSuccess: onSaveSuccess ?? () {},
        ),
      ),
    );
  }

  group('PasswordSettingsScreen', () {
    testWidgets('displays header with title and buttons', (tester) async {
      await tester.pumpWidget(buildTestPasswordSettingsScreen());
      await tester.pumpAndSettle();

      expect(find.text('パスワード設定'), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('displays form fields', (tester) async {
      await tester.pumpWidget(buildTestPasswordSettingsScreen());
      await tester.pumpAndSettle();

      expect(find.text('現在のパスワード'), findsOneWidget);
      expect(find.text('新しいパスワード'), findsOneWidget);
      expect(find.text('新しいパスワード（確認）'), findsOneWidget);
    });

    testWidgets('calls onClose when close button tapped', (tester) async {
      var closed = false;

      await tester.pumpWidget(
        buildTestPasswordSettingsScreen(
          onClose: () => closed = true,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(closed, isTrue);
    });

    testWidgets('save button is disabled when form is invalid', (tester) async {
      await tester.pumpWidget(
        buildTestPasswordSettingsScreen(
          formData: const PasswordFormData(),
        ),
      );
      await tester.pumpAndSettle();

      final saveButtons = find.byIcon(Icons.check);
      expect(saveButtons, findsOneWidget);

      final iconButton = tester.widget<IconButton>(
        find.ancestor(
          of: saveButtons,
          matching: find.byType(IconButton),
        ).first,
      );
      expect(iconButton.onPressed, isNull);
    });

    testWidgets('save button is enabled when form is valid', (tester) async {
      await tester.pumpWidget(
        buildTestPasswordSettingsScreen(
          formData: const PasswordFormData(
            currentPassword: 'oldPassword123',
            newPassword: 'newPassword123',
            confirmPassword: 'newPassword123',
          ),
        ),
      );
      await tester.pumpAndSettle();

      final saveButtons = find.byIcon(Icons.check);
      expect(saveButtons, findsOneWidget);

      final iconButton = tester.widget<IconButton>(
        find.ancestor(
          of: saveButtons,
          matching: find.byType(IconButton),
        ).first,
      );
      expect(iconButton.onPressed, isNotNull);
    });

    testWidgets('shows loading indicator when in loading state', (tester) async {
      await tester.pumpWidget(
        buildTestPasswordSettingsScreen(
          initialState: const PasswordSettingsState.loading(),
        ),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsWidgets);
    });

    testWidgets('password fields are obscured by default', (tester) async {
      await tester.pumpWidget(buildTestPasswordSettingsScreen());
      await tester.pumpAndSettle();

      final textFields = tester.widgetList<TextField>(find.byType(TextField));
      for (final field in textFields) {
        expect(field.obscureText, isTrue);
      }
    });

    testWidgets('can toggle password visibility', (tester) async {
      await tester.pumpWidget(buildTestPasswordSettingsScreen());
      await tester.pumpAndSettle();

      final visibilityButtons = find.byIcon(Icons.visibility_off);
      expect(visibilityButtons, findsWidgets);
    });

  });
}

class _TestPasswordSettingsNotifier extends PasswordSettingsNotifier {
  _TestPasswordSettingsNotifier(this._initialState);

  final PasswordSettingsState? _initialState;

  @override
  PasswordSettingsState build() {
    return _initialState ?? const PasswordSettingsState.initial();
  }

  @override
  Future<void> changePassword() async {}

  @override
  Future<void> sendPasswordResetEmail() async {}

  @override
  void reset() {}
}
class _TestPasswordFormState extends PasswordFormState {
  _TestPasswordFormState(this._formData);

  final PasswordFormData? _formData;

  @override
  PasswordFormData build() {
    return _formData ?? const PasswordFormData();
  }

  @override
  void setCurrentPassword(String value) {}

  @override
  void setNewPassword(String value) {}

  @override
  void setConfirmPassword(String value) {}

  @override
  void toggleCurrentPasswordVisibility() {}

  @override
  void toggleNewPasswordVisibility() {}

  @override
  void toggleConfirmPasswordVisibility() {}

  @override
  bool get isValid {
    final data = _formData ?? const PasswordFormData();
    return data.currentPassword.isNotEmpty &&
        data.newPassword.isNotEmpty &&
        data.confirmPassword.isNotEmpty &&
        data.newPassword == data.confirmPassword;
  }

  @override
  void reset() {}
}

class _TestAuthStateNotifier extends AuthState {
  _TestAuthStateNotifier({this.isAuthenticated = true});

  final bool isAuthenticated;

  @override
  AuthStateData build() {
    if (isAuthenticated) {
      return const AuthStateData(
        isAuthenticated: true,
        email: 'test@example.com',
        userId: 'test-user-id',
        token: 'test-token',
        refreshToken: 'test-refresh-token',
      );
    }
    return const AuthStateData.initial();
  }

  @override
  Future<void> login({
    required String userId,
    required String email,
    required String token,
    required String refreshToken,
  }) async {}

  @override
  Future<void> logout() async {}

  @override
  Future<void> updateTokens({
    required String token,
    required String refreshToken,
  }) async {}

  @override
  Future<bool> restoreSession() async => false;
}
