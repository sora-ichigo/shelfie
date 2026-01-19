import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/welcome/presentation/widgets/legal_links.dart';
import 'package:shelfie/features/welcome/presentation/widgets/welcome_buttons.dart';
import 'package:shelfie/features/welcome/presentation/widgets/welcome_logo.dart';

class WelcomeContent extends StatelessWidget {
  const WelcomeContent({
    super.key,
    required this.onLoginPressed,
    required this.onRegisterPressed,
    required this.onTermsPressed,
    required this.onPrivacyPressed,
  });

  final VoidCallback onLoginPressed;
  final VoidCallback onRegisterPressed;
  final VoidCallback onTermsPressed;
  final VoidCallback onPrivacyPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 1),
                    const Expanded(
                      flex: 2,
                      child: Center(child: WelcomeLogo()),
                    ),
                    Column(
                      children: [
                        WelcomeButtons(
                          onLoginPressed: onLoginPressed,
                          onRegisterPressed: onRegisterPressed,
                        ),
                        SizedBox(height: AppSpacing.lg),
                        LegalLinks(
                          onTermsPressed: onTermsPressed,
                          onPrivacyPressed: onPrivacyPressed,
                        ),
                        SizedBox(height: AppSpacing.lg),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
