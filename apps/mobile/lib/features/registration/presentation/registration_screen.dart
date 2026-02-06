import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/registration/application/registration_notifier.dart';
import 'package:shelfie/features/registration/presentation/widgets/registration_background.dart';
import 'package:shelfie/features/registration/presentation/widgets/registration_form.dart';
import 'package:shelfie/features/registration/presentation/widgets/registration_header.dart';
import 'package:shelfie/features/registration/presentation/widgets/registration_submit_button.dart';
import 'package:shelfie/routing/app_router.dart';

class RegistrationScreen extends ConsumerWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<RegistrationState>(
      registrationNotifierProvider,
      (previous, next) => _handleRegistrationState(context, ref, next),
    );

    final isLoading = ref.watch(
      registrationNotifierProvider.select(
        (state) => state is RegistrationStateLoading,
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          const RegistrationBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: AppSpacing.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RegistrationHeader(
                    onBackPressed: () => _onBackPressed(context),
                    onLoginPressed: () => _onLoginPressed(context),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const RegistrationForm(),
                  const SizedBox(height: AppSpacing.lg),
                  RegistrationSubmitButton(
                    onPressed:
                        isLoading ? null : () => _onSubmitPressed(context, ref),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _GuestModeLink(
                    onPressed: () => _onGuestModePressed(context, ref),
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            const ColoredBox(
              color: Colors.black26,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  void _handleRegistrationState(
    BuildContext context,
    WidgetRef ref,
    RegistrationState state,
  ) {
    switch (state) {
      case RegistrationStateSuccess(:final user):
        AdaptiveSnackBar.show(
          context,
          message: 'アカウントを作成しました: ${user.email}',
          type: AdaptiveSnackBarType.success,
        );
        // TODO(shelfie): ホーム画面への遷移
      case RegistrationStateError(:final message):
        AdaptiveSnackBar.show(
          context,
          message: message,
          type: AdaptiveSnackBarType.error,
        );
      case RegistrationStateInitial():
      case RegistrationStateLoading():
        break;
    }
  }

  void _onBackPressed(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/welcome');
    }
  }

  void _onSubmitPressed(BuildContext context, WidgetRef ref) {
    ref.read(registrationNotifierProvider.notifier).register();
  }

  Future<void> _onGuestModePressed(BuildContext context, WidgetRef ref) async {
    final authState = ref.read(authStateProvider);
    if (authState.isGuest) {
      if (context.mounted) context.pop();
      return;
    }
    await ref.read(authStateProvider.notifier).enterGuestMode();
    if (context.mounted) context.go(AppRoutes.searchTab);
  }

  void _onLoginPressed(BuildContext context) {
    context.push(AppRoutes.login);
  }

}

class _GuestModeLink extends StatelessWidget {
  const _GuestModeLink({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();
    final mutedColor = colors?.textSecondary ?? const Color(0xFFA0A0A0);

    return Center(
      child: GestureDetector(
        onTap: onPressed,
        child: Text(
          '登録せずに利用',
          style: theme.textTheme.bodySmall?.copyWith(color: mutedColor),
        ),
      ),
    );
  }
}
