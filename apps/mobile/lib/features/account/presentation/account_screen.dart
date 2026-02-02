import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/error_view.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/features/account/application/account_notifier.dart';
import 'package:shelfie/features/account/presentation/widgets/account_menu_section.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_card.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({
    required this.onNavigateToProfileEdit,
    required this.onNavigateToPassword,
    required this.onNavigateToTerms,
    required this.onNavigateToPrivacy,
    required this.onLogout,
    required this.onDeleteAccount,
    this.onClose,
    super.key,
  });

  final VoidCallback onNavigateToProfileEdit;
  final VoidCallback onNavigateToPassword;
  final VoidCallback onNavigateToTerms;
  final VoidCallback onNavigateToPrivacy;
  final VoidCallback onLogout;
  final VoidCallback onDeleteAccount;
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
                title: '設定',
                items: [
                  AccountMenuItem(
                    title: 'プロフィール編集',
                    onTap: onNavigateToProfileEdit,
                    icon: Icons.person_outline,
                  ),
                  AccountMenuItem(
                    title: 'パスワード設定',
                    onTap: onNavigateToPassword,
                    icon: Icons.lock_outline,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              AccountMenuSection(
                title: '詳細',
                items: [
                  AccountMenuItem(
                    title: '利用規約',
                    onTap: onNavigateToTerms,
                    icon: Icons.description_outlined,
                  ),
                  AccountMenuItem(
                    title: 'プライバシーポリシー',
                    onTap: onNavigateToPrivacy,
                    icon: Icons.privacy_tip_outlined,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              _LogoutButton(onLogout: onLogout),
              const SizedBox(height: AppSpacing.md),
              _DeleteAccountButton(onDeleteAccount: onDeleteAccount),
              const SizedBox(height: AppSpacing.xl),
              const _AppInfoFooter(),
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

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({required this.onLogout});

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        onPressed: onLogout,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.1),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: const Icon(Icons.logout, size: 20, color: Colors.white),
        label: const Text('ログアウト'),
      ),
    );
  }
}

class _DeleteAccountButton extends StatelessWidget {
  const _DeleteAccountButton({required this.onDeleteAccount});

  final VoidCallback onDeleteAccount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: TextButton(
        onPressed: onDeleteAccount,
        style: TextButton.styleFrom(
          foregroundColor: Colors.red.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text('退会する'),
      ),
    );
  }
}

class _AppInfoFooter extends StatefulWidget {
  const _AppInfoFooter();

  @override
  State<_AppInfoFooter> createState() => _AppInfoFooterState();
}

class _AppInfoFooterState extends State<_AppInfoFooter> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _version = 'v${packageInfo.version} (${packageInfo.buildNumber})';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();

    return Center(
      child: Column(
        children: [
          Text(
            'Shelfie $_version',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors?.foregroundMuted ?? const Color(0xFFA0A0A0),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                Color(0xFF00D492),
                Color(0xFF00D5BE),
                Color(0xFF00D3F2),
              ],
              stops: [0.0, 0.5, 1.0],
            ).createShader(bounds),
            child: Text(
              'Shelfie',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '読書家のための本棚',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors?.foregroundMuted ?? const Color(0xFFA0A0A0),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '© ${DateTime.now().year} sora ichigo',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors?.foregroundMuted ?? const Color(0xFFA0A0A0),
            ),
          ),
        ],
      ),
    );
  }
}
