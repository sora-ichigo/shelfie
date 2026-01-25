import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/error_view.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/features/account/application/account_notifier.dart';
import 'package:shelfie/features/account/presentation/widgets/account_menu_section.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_card.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({
    required this.onNavigateToProfileEdit,
    required this.onNavigateToPremium,
    required this.onNavigateToNotifications,
    required this.onNavigateToPassword,
    required this.onNavigateToTheme,
    this.onClose,
    super.key,
  });

  final VoidCallback onNavigateToProfileEdit;
  final VoidCallback onNavigateToPremium;
  final VoidCallback onNavigateToNotifications;
  final VoidCallback onNavigateToPassword;
  final VoidCallback onNavigateToTheme;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountState = ref.watch(accountNotifierProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: onClose ?? () => Navigator.of(context).pop(),
        ),
      ),
      body: accountState.when(
        data: (profile) => SingleChildScrollView(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top +
                kToolbarHeight +
                AppSpacing.md,
            left: AppSpacing.md,
            right: AppSpacing.md,
            bottom: AppSpacing.xxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'アカウント',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: AppSpacing.lg),
              ProfileCard(profile: profile),
              const SizedBox(height: AppSpacing.lg),
              AccountMenuSection(
                title: 'アカウント',
                items: [
                  AccountMenuItem(
                    title: 'プロフィール編集',
                    onTap: onNavigateToProfileEdit,
                    icon: Icons.person_outline,
                  ),
                  AccountMenuItem(
                    title: 'プレミアムプラン',
                    onTap: onNavigateToPremium,
                    icon: Icons.star_outline,
                    badge: 'PRO',
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              AccountMenuSection(
                title: '設定',
                items: [
                  AccountMenuItem(
                    title: '通知設定',
                    onTap: onNavigateToNotifications,
                    icon: Icons.notifications_outlined,
                  ),
                  AccountMenuItem(
                    title: 'パスワード設定',
                    onTap: onNavigateToPassword,
                    icon: Icons.lock_outline,
                  ),
                  AccountMenuItem(
                    title: 'テーマ',
                    onTap: onNavigateToTheme,
                    icon: Icons.palette_outlined,
                    badge: 'ダーク',
                  ),
                ],
              ),
            ],
          ),
        ),
        loading: () => const LoadingIndicator(fullScreen: true),
        error: (error, stack) => ErrorView(
          failure: _toFailure(error),
          onRetry: () => ref.invalidate(accountNotifierProvider),
        ),
      ),
    );
  }

  Failure _toFailure(Object error) {
    if (error is Failure) {
      return error;
    }
    return UnexpectedFailure(
      message: error.toString(),
    );
  }
}
