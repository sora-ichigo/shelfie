import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
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
    final settingsState = ref.watch(passwordSettingsNotifierProvider);
    final formState = ref.watch(passwordFormStateProvider);
    final colors = Theme.of(context).extension<AppColors>();

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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.message),
              backgroundColor: colors?.accent ?? Colors.green,
            ),
          );
          if (next.message.contains('変更')) {
            onSaveSuccess();
          }
        } else if (next is PasswordSettingsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.failure.message),
              backgroundColor: colors?.error ?? Colors.red,
            ),
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
                _PasswordSettingsHeader(
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
                color: Colors.black.withOpacity(0.3),
                child: const LoadingIndicator(fullScreen: true),
              ),
          ],
        ),
      ),
    );
  }
}

class _PasswordSettingsHeader extends StatelessWidget {
  const _PasswordSettingsHeader({
    required this.onClose,
    required this.onSave,
    required this.isSaveEnabled,
  });

  final VoidCallback onClose;
  final VoidCallback onSave;
  final bool isSaveEnabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xs,
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: onClose,
          ),
          Expanded(
            child: Center(
              child: Text(
                'パスワード設定',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.check,
              color: isSaveEnabled ? colors?.accent : colors?.foregroundMuted,
            ),
            onPressed: isSaveEnabled ? onSave : null,
          ),
        ],
      ),
    );
  }
}
