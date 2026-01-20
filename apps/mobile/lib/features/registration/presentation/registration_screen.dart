import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/registration/presentation/widgets/registration_background.dart';
import 'package:shelfie/features/registration/presentation/widgets/registration_form.dart';
import 'package:shelfie/features/registration/presentation/widgets/registration_header.dart';
import 'package:shelfie/features/registration/presentation/widgets/registration_legal_links.dart';
import 'package:shelfie/features/registration/presentation/widgets/registration_submit_button.dart';

class RegistrationScreen extends ConsumerWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  const RegistrationForm(),
                  const SizedBox(height: AppSpacing.lg),
                  RegistrationSubmitButton(
                    onPressed: () => _onSubmitPressed(context),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  RegistrationLegalLinks(
                    onTermsPressed: () => _onTermsPressed(context),
                    onPrivacyPressed: () => _onPrivacyPressed(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onBackPressed(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/welcome');
    }
  }

  void _onSubmitPressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('認証コードを送信しました（モック）')),
    );
  }

  void _onTermsPressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('準備中です')),
    );
  }

  void _onPrivacyPressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('準備中です')),
    );
  }
}
