import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/form_fields.dart';
import 'package:shelfie/features/account/application/password_form_state.dart';

class PasswordChangeForm extends ConsumerWidget {
  const PasswordChangeForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(passwordFormStateProvider);
    final formNotifier = ref.read(passwordFormStateProvider.notifier);
    final colors = Theme.of(context).extension<AppColors>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PasswordField(
          label: '現在のパスワード',
          hintText: '現在のパスワードを入力',
          value: formState.currentPassword,
          isObscured: formState.isCurrentPasswordObscured,
          errorText: formState.currentPasswordError,
          onChanged: formNotifier.setCurrentPassword,
          onToggleVisibility: formNotifier.toggleCurrentPasswordVisibility,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: AppSpacing.md),
        PasswordField(
          label: '新しいパスワード',
          hintText: '新しいパスワードを入力',
          value: formState.newPassword,
          isObscured: formState.isNewPasswordObscured,
          errorText: formState.newPasswordError,
          onChanged: formNotifier.setNewPassword,
          onToggleVisibility: formNotifier.toggleNewPasswordVisibility,
          textInputAction: TextInputAction.next,
        ),
        if (formState.newPasswordError == null) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(
            '8文字以上、英字と数字を含む',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colors?.textSecondary,
                ),
          ),
        ],
        const SizedBox(height: AppSpacing.md),
        PasswordField(
          label: '新しいパスワード（確認）',
          hintText: 'もう一度入力してください',
          value: formState.confirmPassword,
          isObscured: formState.isConfirmPasswordObscured,
          errorText: formState.confirmPasswordError,
          onChanged: formNotifier.setConfirmPassword,
          onToggleVisibility: formNotifier.toggleConfirmPasswordVisibility,
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'パスワードを変更すると、すべてのデバイスで再ログインが必要になります。',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colors?.textSecondary,
              ),
        ),
      ],
    );
  }
}
