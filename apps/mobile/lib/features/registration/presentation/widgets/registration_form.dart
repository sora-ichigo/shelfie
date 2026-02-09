import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/form_fields.dart';
import 'package:shelfie/features/registration/application/registration_form_state.dart';

class RegistrationForm extends ConsumerWidget {
  const RegistrationForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registrationFormStateProvider);
    final notifier = ref.read(registrationFormStateProvider.notifier);

    return AutofillGroup(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EmailField(
            value: state.email,
            errorText: notifier.emailError,
            onChanged: notifier.updateEmail,
          ),
          const SizedBox(height: AppSpacing.md),
          PasswordField(
            label: 'パスワード',
            hintText: '8文字以上',
            value: state.password,
            errorText: notifier.passwordError,
            isObscured: state.isPasswordObscured,
            onChanged: notifier.updatePassword,
            onToggleVisibility: notifier.togglePasswordVisibility,
            autofillHints: const [AutofillHints.newPassword],
          ),
          const SizedBox(height: AppSpacing.md),
          PasswordField(
            label: 'パスワード（確認）',
            hintText: 'もう一度入力してください',
            value: state.passwordConfirmation,
            errorText: notifier.passwordConfirmationError,
            isObscured: state.isPasswordConfirmationObscured,
            onChanged: notifier.updatePasswordConfirmation,
            onToggleVisibility: notifier.togglePasswordConfirmationVisibility,
            autofillHints: const [AutofillHints.newPassword],
          ),
        ],
      ),
    );
  }
}
