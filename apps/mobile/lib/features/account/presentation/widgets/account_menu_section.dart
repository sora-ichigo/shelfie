import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

class AccountMenuItem {
  const AccountMenuItem({
    required this.title,
    required this.onTap,
    this.icon,
    this.badge,
  });

  final String title;
  final VoidCallback onTap;
  final IconData? icon;
  final String? badge;
}

class AccountMenuSection extends StatelessWidget {
  const AccountMenuSection({
    required this.title,
    required this.items,
    super.key,
  });

  final String title;
  final List<AccountMenuItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          child: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              color: colors?.textSecondary ?? const Color(0xFFA0A0A0),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            color: colors?.surfaceElevated ?? const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(AppSpacing.sm),
          ),
          child: Column(
            children: [
              for (var i = 0; i < items.length; i++) ...[
                _MenuItemTile(
                  item: items[i],
                  showDivider: i < items.length - 1,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _MenuItemTile extends StatelessWidget {
  const _MenuItemTile({
    required this.item,
    required this.showDivider,
  });

  final AccountMenuItem item;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>();

    return Column(
      children: [
        InkWell(
          onTap: item.onTap,
          borderRadius: BorderRadius.circular(AppSpacing.sm),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              children: [
                if (item.icon != null) ...[
                  Icon(
                    item.icon,
                    color: colors?.textPrimary ?? Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                ],
                Expanded(
                  child: Text(
                    item.title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colors?.textPrimary ?? Colors.white,
                    ),
                  ),
                ),
                if (item.badge != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs,
                      vertical: AppSpacing.xxs,
                    ),
                    decoration: BoxDecoration(
                      color: (colors?.brandPrimary ?? const Color(0xFF4FD1C5))
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(AppSpacing.xxs),
                    ),
                    child: Text(
                      item.badge!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors?.brandPrimary ?? const Color(0xFF4FD1C5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                ],
                Icon(
                  Icons.chevron_right,
                  color: colors?.textSecondary ?? const Color(0xFFA0A0A0),
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            indent: item.icon != null ? AppSpacing.md + 24 + AppSpacing.sm : AppSpacing.md,
            endIndent: AppSpacing.md,
            color: colors?.surfaceOverlay ?? const Color(0x4D000000),
          ),
      ],
    );
  }
}
