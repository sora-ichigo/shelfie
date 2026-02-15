import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

/// ジャンルチップを表示するセクション
///
/// 定番ジャンルをチップで一覧表示し、タップで該当ジャンルの検索を実行する。
/// Wrap レイアウトで画面幅に応じて折り返す。
class GenreChipsSection extends StatelessWidget {
  const GenreChipsSection({
    required this.onGenreTap,
    super.key,
  });

  final void Function(String genre) onGenreTap;

  static const List<String> defaultGenres = [
    '小説',
    'ビジネス',
    'マンガ',
    'SF',
    '自己啓発',
    'エッセイ',
    'ミステリー',
    'ノンフィクション',
    'ファンタジー',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          child: Text(
            'ジャンルから探す',
            style: theme.textTheme.titleMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: defaultGenres
                .map((genre) => _GenreChip(
                      label: genre,
                      onTap: () => onGenreTap(genre),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _GenreChip extends StatelessWidget {
  const _GenreChip({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Material(
      color: appColors.surface,
      borderRadius: AppRadius.circular(AppRadius.full),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.circular(AppRadius.full),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            borderRadius: AppRadius.circular(AppRadius.full),
            border: Border.all(color: appColors.border),
          ),
          child: Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: appColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
