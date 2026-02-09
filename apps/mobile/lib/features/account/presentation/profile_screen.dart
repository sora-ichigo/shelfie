import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/screen_header.dart';
import 'package:shelfie/features/account/application/account_notifier.dart';
import 'package:shelfie/routing/app_router.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGuest = ref.watch(authStateProvider.select((s) => s.isGuest));
    final accountAsync = isGuest ? null : ref.watch(accountNotifierProvider);
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ScreenHeader(
              title: 'プロフィール',
              onProfileTap: () => context.push(AppRoutes.account),
              avatarUrl: accountAsync?.valueOrNull?.avatarUrl,
              isAvatarLoading: accountAsync?.isLoading ?? false,
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: AppSpacing.all(AppSpacing.lg),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.construction_outlined,
                        size: 64,
                        color: appColors.textSecondary,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'この機能は準備中です',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: appColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
