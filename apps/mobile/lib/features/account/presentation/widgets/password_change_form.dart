import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
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
        _PasswordTextField(
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
        _PasswordTextField(
          label: '新しいパスワード',
          hintText: '新しいパスワードを入力',
          value: formState.newPassword,
          isObscured: formState.isNewPasswordObscured,
          errorText: formState.newPasswordError,
          onChanged: formNotifier.setNewPassword,
          onToggleVisibility: formNotifier.toggleNewPasswordVisibility,
          textInputAction: TextInputAction.next,
          helperText: '8文字以上、英字と数字を含む',
        ),
        const SizedBox(height: AppSpacing.md),
        _PasswordTextField(
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
                color: colors?.foregroundMuted,
              ),
        ),
      ],
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    required this.label,
    required this.hintText,
    required this.value,
    required this.isObscured,
    required this.onChanged,
    required this.onToggleVisibility,
    this.errorText,
    this.helperText,
    this.textInputAction,
  });

  final String label;
  final String hintText;
  final String value;
  final bool isObscured;
  final String? errorText;
  final String? helperText;
  final ValueChanged<String> onChanged;
  final VoidCallback onToggleVisibility;
  final TextInputAction? textInputAction;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(_PasswordTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextField(
          controller: _controller,
          obscureText: widget.isObscured,
          onChanged: widget.onChanged,
          textInputAction: widget.textInputAction,
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: theme.textTheme.bodyLarge?.copyWith(
              color: colors?.foregroundMuted,
            ),
            errorText: widget.errorText,
            helperText:
                widget.errorText == null ? widget.helperText : null,
            suffixIcon: IconButton(
              icon: Icon(
                widget.isObscured ? Icons.visibility_off : Icons.visibility,
                color: colors?.foregroundMuted,
              ),
              onPressed: widget.onToggleVisibility,
            ),
            filled: true,
            fillColor: colors?.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.sm),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.sm),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.sm),
              borderSide: BorderSide(
                color: colors?.accent ?? Colors.blue,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.sm),
              borderSide: BorderSide(
                color: colors?.error ?? Colors.red,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.sm),
              borderSide: BorderSide(
                color: colors?.error ?? Colors.red,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
          ),
        ),
      ],
    );
  }
}
