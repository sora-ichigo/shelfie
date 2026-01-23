import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    required this.title,
    required this.onProfileTap,
    super.key,
  });

  final String title;
  final VoidCallback onProfileTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.md,
        bottom: AppSpacing.xs,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          GestureDetector(
            onTap: onProfileTap,
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                gradient: AppColors.actionGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_outline,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
