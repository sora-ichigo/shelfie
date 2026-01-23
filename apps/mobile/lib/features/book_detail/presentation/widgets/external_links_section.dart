import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

/// 外部リンクセクション
///
/// Amazon、公式サイトへのリンクを表示する。
class ExternalLinksSection extends StatelessWidget {
  const ExternalLinksSection({
    required this.onLinkTap,
    super.key,
    this.amazonUrl,
    this.infoLink,
  });

  final String? amazonUrl;
  final String? infoLink;
  final void Function(String url) onLinkTap;

  @override
  Widget build(BuildContext context) {
    if (amazonUrl == null && infoLink == null) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '購入・詳細',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        if (amazonUrl != null)
          _buildLinkButton(
            context,
            icon: Icons.shopping_cart_outlined,
            label: 'Amazonで見る',
            url: amazonUrl!,
          ),
        if (infoLink != null) ...[
          if (amazonUrl != null) const SizedBox(height: AppSpacing.xs),
          _buildLinkButton(
            context,
            icon: Icons.open_in_new,
            label: '公式サイトへ',
            url: infoLink!,
          ),
        ],
      ],
    );
  }

  Widget _buildLinkButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String url,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => onLinkTap(url),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: AppSpacing.all(AppSpacing.sm),
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.outline),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
