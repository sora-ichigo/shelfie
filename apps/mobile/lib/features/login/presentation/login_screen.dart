import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/login/application/login_notifier.dart';
import 'package:shelfie/features/login/presentation/widgets/login_background.dart';
import 'package:shelfie/features/login/presentation/widgets/login_form.dart';
import 'package:shelfie/features/login/presentation/widgets/login_header.dart';
import 'package:shelfie/features/login/presentation/widgets/login_submit_button.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<LoginState>(
      loginNotifierProvider,
      (previous, next) => _handleLoginState(context, ref, next),
    );

    final isLoading = ref.watch(
      loginNotifierProvider.select(
        (state) => state is LoginStateLoading,
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          const LoginBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: AppSpacing.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoginHeader(
                    onBackPressed: () => _onBackPressed(context),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  LoginForm(
                    onForgotPasswordPressed: () =>
                        _onForgotPasswordPressed(context),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  LoginSubmitButton(
                    onPressed:
                        isLoading ? null : () => _onSubmitPressed(context, ref),
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

  void _handleLoginState(
    BuildContext context,
    WidgetRef ref,
    LoginState state,
  ) {
    switch (state) {
      case LoginStateSuccess(:final email):
        AdaptiveSnackBar.show(
          context,
          message: 'ログインしました: $email',
          type: AdaptiveSnackBarType.success,
        );
      case LoginStateError(:final message):
        AdaptiveSnackBar.show(
          context,
          message: message,
          type: AdaptiveSnackBarType.error,
        );
      case LoginStateInitial():
      case LoginStateLoading():
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
    ref.read(loginNotifierProvider.notifier).login();
  }

  void _onForgotPasswordPressed(BuildContext context) {
    AdaptiveSnackBar.show(
      context,
      message: '準備中です',
      type: AdaptiveSnackBarType.info,
    );
  }
}
