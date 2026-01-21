import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/registration/application/registration_form_state.dart';

class RegistrationSubmitButton extends ConsumerWidget {
  const RegistrationSubmitButton({
    required this.onPressed,
    super.key,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(registrationFormStateProvider);
    final isValid = ref.read(registrationFormStateProvider.notifier).isValid;
    final isEnabled = isValid && onPressed != null;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton(
        onPressed: isEnabled ? onPressed : null,
        style: FilledButton.styleFrom(
          backgroundColor: Colors.white,
          disabledBackgroundColor: Colors.white.withOpacity(0.5),
          foregroundColor: Colors.black,
          disabledForegroundColor: Colors.black.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.xl),
          ),
        ),
        child: Text(
          'アカウントを作成',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: isEnabled ? Colors.black : Colors.black.withOpacity(0.5),
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
