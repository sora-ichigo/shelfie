import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

/// バーコードスキャン機能を目立たせるプロモーションカード
///
/// さがす画面の初期表示時に、QR/バーコードスキャン機能の
/// 存在を明示的にアピールするカード型 UI。
class ScanPromotionCard extends StatelessWidget {
  const ScanPromotionCard({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Material(
        color: appColors.surface,
        borderRadius: AppRadius.circular(AppRadius.lg),
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.circular(AppRadius.lg),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              borderRadius: AppRadius.circular(AppRadius.lg),
              border: Border.all(color: appColors.border),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: appColors.primary.withOpacity(0.15),
                    borderRadius: AppRadius.circular(AppRadius.md),
                  ),
                  child: Icon(
                    Icons.qr_code_scanner,
                    color: appColors.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'バーコードで本をスキャン',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: appColors.textPrimary,
                        ),
                      ),
                      Text(
                        'カメラをかざすだけで登録',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: appColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: appColors.inactive,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
