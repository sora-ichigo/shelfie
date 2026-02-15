import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/app_snack_bar.dart';
import 'package:shelfie/core/widgets/edit_screen_header.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/features/account/application/password_form_state.dart';
import 'package:shelfie/features/account/application/password_settings_notifier.dart';
import 'package:shelfie/features/account/presentation/widgets/password_change_form.dart';

class PasswordSettingsScreen extends ConsumerWidget {
  const PasswordSettingsScreen({
    required this.onClose,
    required this.onSaveSuccess,
    super.key,
  });

  final VoidCallback onClose;
  final VoidCallback onSaveSuccess;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    final settingsState = ref.watch(passwordSettingsNotifierProvider);
    final formState = ref.watch(passwordFormStateProvider);

    final isLoading = settingsState is PasswordSettingsLoading;
    final isFormValid = formState.currentPassword.isNotEmpty &&
        formState.newPassword.isNotEmpty &&
        formState.confirmPassword.isNotEmpty &&
        formState.currentPasswordError == null &&
        formState.newPasswordError == null &&
        formState.confirmPasswordError == null;
    final isSaveEnabled = isFormValid && !isLoading;

    ref.listen<PasswordSettingsState>(
      passwordSettingsNotifierProvider,
      (previous, next) {
        if (next is PasswordSettingsSuccess) {
          AppSnackBar.show(
            context,
            message: next.message,
            type: AppSnackBarType.success,
          );
          if (next.message.contains('変更')) {
            onSaveSuccess();
          }
        } else if (next is PasswordSettingsError) {
          AppSnackBar.show(
            context,
            message: next.failure.userMessage,
            type: AppSnackBarType.error,
          );
        }
      },
    );

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                EditScreenHeader(
                  title: 'パスワード設定',
                  onClose: onClose,
                  onSave: () {
                    ref
                        .read(passwordSettingsNotifierProvider.notifier)
                        .changePassword();
                  },
                  isSaveEnabled: isSaveEnabled,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      children: [
                        const SizedBox(height: AppSpacing.md),
                        const PasswordChangeForm(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (isLoading)
              ColoredBox(
                color: appColors.overlayLegacy.withOpacity(0.3),
                child: const LoadingIndicator(fullScreen: true),
              ),
          ],
        ),
      ),
    );
  }
}
