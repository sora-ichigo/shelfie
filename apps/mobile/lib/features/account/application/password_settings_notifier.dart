import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/features/account/application/password_form_state.dart';
import 'package:shelfie/features/account/data/password_repository.dart';

part 'password_settings_notifier.freezed.dart';
part 'password_settings_notifier.g.dart';

@freezed
sealed class PasswordSettingsState with _$PasswordSettingsState {
  const factory PasswordSettingsState.initial() = PasswordSettingsInitial;
  const factory PasswordSettingsState.loading() = PasswordSettingsLoading;
  const factory PasswordSettingsState.success({required String message}) =
      PasswordSettingsSuccess;
  const factory PasswordSettingsState.error({required Failure failure}) =
      PasswordSettingsError;
}

@riverpod
class PasswordSettingsNotifier extends _$PasswordSettingsNotifier {
  @override
  PasswordSettingsState build() {
    return const PasswordSettingsState.initial();
  }

  Future<void> changePassword() async {
    state = const PasswordSettingsState.loading();

    final authState = ref.read(authStateProvider);
    if (!authState.isAuthenticated || authState.email == null) {
      state = const PasswordSettingsState.error(
        failure: AuthFailure(message: '認証が必要です'),
      );
      return;
    }

    final formState = ref.read(passwordFormStateProvider);

    final repository = ref.read(passwordRepositoryProvider);
    final result = await repository.changePassword(
      email: authState.email!,
      currentPassword: formState.currentPassword,
      newPassword: formState.newPassword,
    );

    await result.fold(
      (failure) async {
        state = PasswordSettingsState.error(failure: failure);
      },
      (passwordChangeResult) async {
        await ref.read(authStateProvider.notifier).updateTokens(
              token: passwordChangeResult.idToken,
              refreshToken: passwordChangeResult.refreshToken,
            );

        ref.read(passwordFormStateProvider.notifier).reset();

        state = const PasswordSettingsState.success(
          message: 'パスワードを変更しました',
        );
      },
    );
  }

  Future<void> sendPasswordResetEmail() async {
    state = const PasswordSettingsState.loading();

    final authState = ref.read(authStateProvider);
    if (!authState.isAuthenticated || authState.email == null) {
      state = const PasswordSettingsState.error(
        failure: AuthFailure(message: '認証が必要です'),
      );
      return;
    }

    final repository = ref.read(passwordRepositoryProvider);
    final result = await repository.sendPasswordResetEmail(
      email: authState.email!,
    );

    result.fold(
      (failure) {
        state = PasswordSettingsState.error(failure: failure);
      },
      (_) {
        state = const PasswordSettingsState.success(
          message: 'パスワードリセットメールを送信しました',
        );
      },
    );
  }

  void reset() {
    state = const PasswordSettingsState.initial();
  }
}
