import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/form_fields.dart';
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
        EmailField(
          value: state.email,
          errorText: notifier.emailError,
          onChanged: notifier.updateEmail,
        ),
        const SizedBox(height: AppSpacing.md),
        PasswordField(
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
            color: colors?.primary ?? const Color(0xFF4FD1C5),
          ),
        ),
      ),
    );
  }
}
