import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';

enum BookListCardVariant { vertical, horizontal }

class BookListCard extends StatelessWidget {
  const BookListCard._({
    required this.summary,
    required this.onTap,
    required this.variant,
  });

  factory BookListCard.vertical({
    required BookListSummary summary,
    required VoidCallback onTap,
  }) {
    return BookListCard._(
      summary: summary,
      onTap: onTap,
      variant: BookListCardVariant.vertical,
    );
  }

  factory BookListCard.horizontal({
    required BookListSummary summary,
    required VoidCallback onTap,
  }) {
    return BookListCard._(
      summary: summary,
      onTap: onTap,
      variant: BookListCardVariant.horizontal,
    );
  }

  final BookListSummary summary;
  final VoidCallback onTap;
  final BookListCardVariant variant;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: switch (variant) {
        BookListCardVariant.vertical => _VerticalLayout(summary: summary),
        BookListCardVariant.horizontal => _HorizontalLayout(summary: summary),
      },
    );
  }
}

class _VerticalLayout extends StatelessWidget {
  const _VerticalLayout({required this.summary});

  final BookListSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: summary.coverImages.isEmpty
                ? _CoverPlaceholder(appColors: appColors)
                : CoverCollage(coverImages: summary.coverImages),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          summary.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          '${summary.bookCount}冊',
          style: theme.textTheme.bodySmall?.copyWith(
            color: appColors.foregroundMuted,
          ),
        ),
        if (summary.description != null) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(
            summary.description!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: appColors.foregroundMuted,
            ),
          ),
        ],
      ],
    );
  }
}

class _HorizontalLayout extends StatelessWidget {
  const _HorizontalLayout({required this.summary});

  final BookListSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Row(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            child: summary.coverImages.isEmpty
                ? _CoverPlaceholder(appColors: appColors)
                : SingleCoverImage(imageUrl: summary.coverImages.first),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                summary.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                summary.description != null
                    ? '${summary.bookCount}冊 | ${summary.description}'
                    : '${summary.bookCount}冊',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: appColors.foregroundMuted,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Icon(
          Icons.chevron_right,
          color: appColors.foregroundMuted,
        ),
      ],
    );
  }
}

class _CoverPlaceholder extends StatelessWidget {
  const _CoverPlaceholder({required this.appColors});

  final AppColors appColors;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: appColors.surface,
      child: Center(
        child: Icon(
          Icons.collections_bookmark,
          size: 32,
          color: appColors.foregroundMuted,
        ),
      ),
    );
  }
}

class CoverCollage extends StatelessWidget {
  const CoverCollage({required this.coverImages, super.key});

  final List<String> coverImages;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    final images = coverImages.take(4).toList();
    final placeholderCount = 4 - images.length;

    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ...images.map(
          (url) => CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            placeholder: (context, url) => ColoredBox(
              color: appColors.surface,
            ),
            errorWidget: (context, url, error) => ColoredBox(
              color: appColors.surface,
              child: Icon(
                Icons.book,
                color: appColors.foregroundMuted,
              ),
            ),
          ),
        ),
        ...List.generate(
          placeholderCount,
          (_) => ColoredBox(color: appColors.surface),
        ),
      ],
    );
  }
}

class SingleCoverImage extends StatelessWidget {
  const SingleCoverImage({required this.imageUrl, super.key});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => ColoredBox(
        color: appColors.surface,
      ),
      errorWidget: (context, url, error) => ColoredBox(
        color: appColors.surface,
        child: Icon(
          Icons.book,
          color: appColors.foregroundMuted,
        ),
      ),
    );
  }
}
