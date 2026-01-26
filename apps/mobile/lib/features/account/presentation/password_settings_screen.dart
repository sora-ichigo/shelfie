import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/features/account/application/password_form_state.dart';
import 'package:shelfie/features/account/application/password_settings_notifier.dart';
import 'package:shelfie/features/account/presentation/widgets/password_change_form.dart';
import 'package:shelfie/features/account/presentation/widgets/password_reset_section.dart';

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
    final formNotifier = ref.read(passwordFormStateProvider.notifier);
    final colors = Theme.of(context).extension<AppColors>();

    final isLoading = settingsState is PasswordSettingsLoading;
    final isSaveEnabled = formNotifier.isValid && !isLoading;

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'パスワードを変更',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        const PasswordChangeForm(),
                        const SizedBox(height: AppSpacing.xl),
                        Divider(color: colors?.overlay),
                        const SizedBox(height: AppSpacing.xl),
                        Text(
                          'パスワードを忘れた場合',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        PasswordResetSection(
                          onSendResetEmail: () {
                            ref
                                .read(passwordSettingsNotifierProvider.notifier)
                                .sendPasswordResetEmail();
                          },
                          isLoading: isLoading,
                        ),
                        const SizedBox(height: AppSpacing.xxl),
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

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colors?.overlay ?? Colors.transparent,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: onClose,
            child: Text(
              'キャンセル',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colors?.foregroundMuted,
              ),
            ),
          ),
          Text(
            'パスワード設定',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: isSaveEnabled ? onSave : null,
            child: Text(
              '保存',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: isSaveEnabled
                    ? colors?.accent
                    : colors?.foregroundMuted.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
