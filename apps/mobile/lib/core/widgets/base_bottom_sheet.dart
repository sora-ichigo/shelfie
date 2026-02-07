import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

/// 共通のボトムシート基本レイアウト
///
/// ドラッグハンドル、タイトル、コンテンツを統一されたスタイルで表示する。
/// アプリ内の全てのボトムシートで使用することで、一貫したUIを提供する。
class BaseBottomSheet extends StatelessWidget {
  const BaseBottomSheet({
    required this.title,
    required this.child,
    super.key,
  });

  /// ボトムシートのタイトル
  final String title;

  /// ボトムシートのコンテンツ
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final appColors = theme.extension<AppColors>()!;

    return SafeArea(
      child: Padding(
        padding: AppSpacing.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDragHandle(theme),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: appColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildDragHandle(ThemeData theme) {
    final appColors = theme.extension<AppColors>()!;

    return Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: appColors.inactive,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
