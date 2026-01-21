import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/login/application/login_form_state.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({
    required this.onForgotPasswordPressed,
    super.key,
  });

  final VoidCallback onForgotPasswordPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginFormStateProvider);
    final notifier = ref.read(loginFormStateProvider.notifier);

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
          value: state.password,
          isObscured: state.isPasswordObscured,
          onChanged: notifier.updatePassword,
          onToggleVisibility: notifier.togglePasswordVisibility,
        ),
        const SizedBox(height: AppSpacing.sm),
        _ForgotPasswordLink(onPressed: onForgotPasswordPressed),
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
    required this.value,
    required this.isObscured,
    required this.onChanged,
    required this.onToggleVisibility,
  });

  final String value;
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
          'パスワード',
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
            hintText: 'パスワードを入力',
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: colors?.textSecondary ?? const Color(0xFFA0A0A0),
            ),
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
          ),
        ),
      ],
    );
  }
}

class _ForgotPasswordLink extends StatelessWidget {
  const _ForgotPasswordLink({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();

    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: onPressed,
        child: Text(
          'パスワードを忘れた方',
          style: theme.textTheme.bodySmall?.copyWith(
            color: colors?.brandPrimary ?? const Color(0xFF4FD1C5),
          ),
        ),
      ),
    );
  }
}
