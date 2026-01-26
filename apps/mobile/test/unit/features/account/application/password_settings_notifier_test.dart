import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/storage/secure_storage_service.dart';
import 'package:shelfie/features/account/application/password_form_state.dart';
import 'package:shelfie/features/account/application/password_settings_notifier.dart';
import 'package:shelfie/features/account/data/password_repository.dart';

class MockPasswordRepository extends Mock implements PasswordRepository {}

class MockSecureStorageService extends Mock implements SecureStorageService {}

void main() {
  late ProviderContainer container;
  late MockPasswordRepository mockRepository;
  late MockSecureStorageService mockStorageService;

  setUp(() {
    mockRepository = MockPasswordRepository();
    mockStorageService = MockSecureStorageService();

    when(() => mockStorageService.updateTokens(
          idToken: any(named: 'idToken'),
          refreshToken: any(named: 'refreshToken'),
        )).thenAnswer((_) async {});

    container = ProviderContainer(
      overrides: [
        passwordRepositoryProvider.overrideWithValue(mockRepository),
        secureStorageServiceProvider.overrideWithValue(mockStorageService),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('PasswordSettingsNotifier', () {
    group('初期状態', () {
      test('initial 状態で開始する', () {
        final state = container.read(passwordSettingsNotifierProvider);
        expect(state, isA<PasswordSettingsInitial>());
      });
    });

    group('changePassword', () {
      test('成功時に success 状態になる', () async {
        final formNotifier =
            container.read(passwordFormStateProvider.notifier);
        formNotifier.setCurrentPassword('oldPassword123');
        formNotifier.setNewPassword('newPassword123');
        formNotifier.setConfirmPassword('newPassword123');

        container.read(authStateProvider.notifier).state = const AuthStateData(
          isAuthenticated: true,
          email: 'test@example.com',
        );

        when(
          () => mockRepository.changePassword(
            email: any(named: 'email'),
            currentPassword: any(named: 'currentPassword'),
            newPassword: any(named: 'newPassword'),
          ),
        ).thenAnswer(
          (_) async => right(
            const PasswordChangeResult(
              idToken: 'new-id-token',
              refreshToken: 'new-refresh-token',
            ),
          ),
        );

        final notifier =
            container.read(passwordSettingsNotifierProvider.notifier);
        await notifier.changePassword();

        final state = container.read(passwordSettingsNotifierProvider);
        expect(state, isA<PasswordSettingsSuccess>());
        expect(
          (state as PasswordSettingsSuccess).message,
          contains('変更'),
        );
      });

      test('認証エラーの場合、error 状態になる', () async {
        final formNotifier =
            container.read(passwordFormStateProvider.notifier);
        formNotifier.setCurrentPassword('wrongPassword');
        formNotifier.setNewPassword('newPassword123');
        formNotifier.setConfirmPassword('newPassword123');

        container.read(authStateProvider.notifier).state = const AuthStateData(
          isAuthenticated: true,
          email: 'test@example.com',
        );

        when(
          () => mockRepository.changePassword(
            email: any(named: 'email'),
            currentPassword: any(named: 'currentPassword'),
            newPassword: any(named: 'newPassword'),
          ),
        ).thenAnswer(
          (_) async => left(
            const AuthFailure(message: '現在のパスワードが正しくありません'),
          ),
        );

        final notifier =
            container.read(passwordSettingsNotifierProvider.notifier);
        await notifier.changePassword();

        final state = container.read(passwordSettingsNotifierProvider);
        expect(state, isA<PasswordSettingsError>());
      });

      test('ネットワークエラーの場合、error 状態になる', () async {
        final formNotifier =
            container.read(passwordFormStateProvider.notifier);
        formNotifier.setCurrentPassword('oldPassword123');
        formNotifier.setNewPassword('newPassword123');
        formNotifier.setConfirmPassword('newPassword123');

        container.read(authStateProvider.notifier).state = const AuthStateData(
          isAuthenticated: true,
          email: 'test@example.com',
        );

        when(
          () => mockRepository.changePassword(
            email: any(named: 'email'),
            currentPassword: any(named: 'currentPassword'),
            newPassword: any(named: 'newPassword'),
          ),
        ).thenAnswer(
          (_) async => left(
            const NetworkFailure(message: 'ネットワークエラー'),
          ),
        );

        final notifier =
            container.read(passwordSettingsNotifierProvider.notifier);
        await notifier.changePassword();

        final state = container.read(passwordSettingsNotifierProvider);
        expect(state, isA<PasswordSettingsError>());
        final errorState = state as PasswordSettingsError;
        expect(errorState.failure, isA<NetworkFailure>());
      });

      test('未認証の場合、error 状態になる', () async {
        final formNotifier =
            container.read(passwordFormStateProvider.notifier);
        formNotifier.setCurrentPassword('oldPassword123');
        formNotifier.setNewPassword('newPassword123');
        formNotifier.setConfirmPassword('newPassword123');

        container.read(authStateProvider.notifier).state =
            const AuthStateData.initial();

        final notifier =
            container.read(passwordSettingsNotifierProvider.notifier);
        await notifier.changePassword();

        final state = container.read(passwordSettingsNotifierProvider);
        expect(state, isA<PasswordSettingsError>());
        final errorState = state as PasswordSettingsError;
        expect(errorState.failure, isA<AuthFailure>());
      });
    });

    group('sendPasswordResetEmail', () {
      test('成功時に success 状態になる', () async {
        container.read(authStateProvider.notifier).state = const AuthStateData(
          isAuthenticated: true,
          email: 'test@example.com',
        );

        when(
          () => mockRepository.sendPasswordResetEmail(
            email: any(named: 'email'),
          ),
        ).thenAnswer((_) async => right(unit));

        final notifier =
            container.read(passwordSettingsNotifierProvider.notifier);
        await notifier.sendPasswordResetEmail();

        final state = container.read(passwordSettingsNotifierProvider);
        expect(state, isA<PasswordSettingsSuccess>());
        expect(
          (state as PasswordSettingsSuccess).message,
          contains('メール'),
        );
      });

      test('エラーの場合、error 状態になる', () async {
        container.read(authStateProvider.notifier).state = const AuthStateData(
          isAuthenticated: true,
          email: 'test@example.com',
        );

        when(
          () => mockRepository.sendPasswordResetEmail(
            email: any(named: 'email'),
          ),
        ).thenAnswer(
          (_) async => left(
            const ServerFailure(message: 'サーバーエラー', code: 'INTERNAL_ERROR'),
          ),
        );

        final notifier =
            container.read(passwordSettingsNotifierProvider.notifier);
        await notifier.sendPasswordResetEmail();

        final state = container.read(passwordSettingsNotifierProvider);
        expect(state, isA<PasswordSettingsError>());
      });

      test('未認証の場合、error 状態になる', () async {
        container.read(authStateProvider.notifier).state =
            const AuthStateData.initial();

        final notifier =
            container.read(passwordSettingsNotifierProvider.notifier);
        await notifier.sendPasswordResetEmail();

        final state = container.read(passwordSettingsNotifierProvider);
        expect(state, isA<PasswordSettingsError>());
        final errorState = state as PasswordSettingsError;
        expect(errorState.failure, isA<AuthFailure>());
      });
    });

    group('reset', () {
      test('error 状態から initial 状態にリセットする', () async {
        container.read(authStateProvider.notifier).state =
            const AuthStateData.initial();

        final notifier =
            container.read(passwordSettingsNotifierProvider.notifier);
        await notifier.sendPasswordResetEmail();

        expect(
          container.read(passwordSettingsNotifierProvider),
          isA<PasswordSettingsError>(),
        );

        notifier.reset();

        expect(
          container.read(passwordSettingsNotifierProvider),
          isA<PasswordSettingsInitial>(),
        );
      });
    });
  });
}
