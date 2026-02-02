import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/constants/legal_urls.dart';
import 'package:shelfie/features/welcome/presentation/widgets/welcome_background.dart';
import 'package:shelfie/features/welcome/presentation/widgets/welcome_content.dart';
import 'package:shelfie/routing/app_router.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          const WelcomeBackground(),
          SafeArea(
            child: WelcomeContent(
              onLoginPressed: () => _onLoginPressed(context),
              onRegisterPressed: () => _onRegisterPressed(context),
              onGuestModePressed: () => _onGuestModePressed(context, ref),
              onTermsPressed: () => _onTermsPressed(context),
              onPrivacyPressed: () => _onPrivacyPressed(context),
            ),
          ),
        ],
      ),
    );
  }

  void _onLoginPressed(BuildContext context) {
    context.push(AppRoutes.login);
  }

  void _onRegisterPressed(BuildContext context) {
    context.push(AppRoutes.register);
  }

  void _onTermsPressed(BuildContext context) {
    LegalUrls.openTermsOfService();
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

  void _onPrivacyPressed(BuildContext context) {
    LegalUrls.openPrivacyPolicy();
  }
}
