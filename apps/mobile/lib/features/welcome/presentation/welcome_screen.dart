import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
              onTermsPressed: () => _onTermsPressed(context),
              onPrivacyPressed: () => _onPrivacyPressed(context),
            ),
          ),
        ],
      ),
    );
  }

  void _onLoginPressed(BuildContext context) {
    context.go(AppRoutes.login);
  }

  void _onRegisterPressed(BuildContext context) {
    context.go(AppRoutes.register);
  }

  void _onTermsPressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('利用規約ページは準備中です')),
    );
  }

  void _onPrivacyPressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('プライバシーポリシーページは準備中です')),
    );
  }
}
