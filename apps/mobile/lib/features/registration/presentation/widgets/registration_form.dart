import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/registration/application/registration_form_state.dart';

class RegistrationForm extends ConsumerWidget {
  const RegistrationForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registrationFormStateProvider);
    final notifier = ref.read(registrationFormStateProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _EmailField(
          value: state.email,
          errorText: notifier.emailError,
          onChanged: notifier.updateEmail,
        ),
        const SizedBox(height: AppSpacing.md),
        _PasswordField(
          label: 'パスワード',
          hintText: '8文字以上',
          value: state.password,
          errorText: notifier.passwordError,
          isObscured: state.isPasswordObscured,
          onChanged: notifier.updatePassword,
          onToggleVisibility: notifier.togglePasswordVisibility,
        ),
        const SizedBox(height: AppSpacing.md),
        _PasswordField(
          label: 'パスワード（確認）',
          hintText: 'もう一度入力してください',
          value: state.passwordConfirmation,
          errorText: notifier.passwordConfirmationError,
          isObscured: state.isPasswordConfirmationObscured,
          onChanged: notifier.updatePasswordConfirmation,
          onToggleVisibility: notifier.togglePasswordConfirmationVisibility,
        ),
      ],
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({
    required this.value,
    required this.errorText,
    required this.onChanged,
  });

  final String value;
  final String? errorText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'メールアドレス',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors?.textPrimary ?? Colors.white,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextFormField(
          initialValue: value,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          onChanged: onChanged,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors?.textPrimary ?? Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'example@email.com',
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: colors?.textSecondary ?? const Color(0xFFA0A0A0),
            ),
            errorText: errorText,
            prefixIcon: Icon(
              Icons.email_outlined,
              color: colors?.textSecondary ?? const Color(0xFFA0A0A0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(
                color: colors?.textSecondary ?? const Color(0xFFA0A0A0),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(
                color: colors?.textSecondary ?? const Color(0xFFA0A0A0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(
                color: colors?.brandPrimary ?? const Color(0xFF4FD1C5),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(
                color: theme.colorScheme.error,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(
                color: theme.colorScheme.error,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.label,
    required this.hintText,
    required this.value,
    required this.errorText,
    required this.isObscured,
    required this.onChanged,
    required this.onToggleVisibility,
  });

  final String label;
  final String hintText;
  final String value;
  final String? errorText;
  final bool isObscured;
  final ValueChanged<String> onChanged;
  final VoidCallback onToggleVisibility;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors?.textPrimary ?? Colors.white,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextFormField(
          initialValue: value,
          obscureText: isObscured,
          autocorrect: false,
          enableSuggestions: false,
          onChanged: onChanged,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors?.textPrimary ?? Colors.white,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: colors?.textSecondary ?? const Color(0xFFA0A0A0),
            ),
            errorText: errorText,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: colors?.textSecondary ?? const Color(0xFFA0A0A0),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isObscured
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: colors?.textSecondary ?? const Color(0xFFA0A0A0),
              ),
              onPressed: onToggleVisibility,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(
                color: colors?.textSecondary ?? const Color(0xFFA0A0A0),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(
                color: colors?.textSecondary ?? const Color(0xFFA0A0A0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(
                color: colors?.brandPrimary ?? const Color(0xFF4FD1C5),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(
                color: theme.colorScheme.error,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(
                color: theme.colorScheme.error,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
