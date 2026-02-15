import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/book_search/domain/author_count.dart';

/// 本棚の著者を横スクロールチップで表示するセクション
///
/// ユーザーの本棚にある著者を冊数順で横スクロール表示し、
/// タップで該当著者の検索を実行する。
class AuthorChipsSection extends StatelessWidget {
  const AuthorChipsSection({
    required this.authors,
    required this.onAuthorTap,
    super.key,
  });

  final List<AuthorCount> authors;
  final void Function(String authorName) onAuthorTap;

  @override
  Widget build(BuildContext context) {
    if (authors.isEmpty) {
      return const SizedBox.shrink();
    }

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
            'あなたの著者',
            style: theme.textTheme.titleMedium,
          ),
        ),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            itemCount: authors.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.xs),
            itemBuilder: (context, index) {
              final author = authors[index];
              return _AuthorChip(
                author: author,
                onTap: () => onAuthorTap(author.name),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _AuthorChip extends StatelessWidget {
  const _AuthorChip({
    required this.author,
    required this.onTap,
  });

  final AuthorCount author;
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                author.name,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: appColors.textPrimary,
                ),
              ),
              const SizedBox(width: AppSpacing.xxs),
              Text(
                '${author.count}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: appColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
