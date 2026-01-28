import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';

class BookListCard extends StatelessWidget {
  const BookListCard({
    required this.summary,
    required this.onTap,
    super.key,
  });

  final BookListSummary summary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: _CardContent(summary: summary),
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent({required this.summary});

  final BookListSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Container(
      decoration: BoxDecoration(
        color: appColors.surfaceCard,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: summary.coverImages.isEmpty
                  ? _CoverPlaceholder(appColors: appColors)
                  : CoverCollage(coverImages: summary.coverImages),
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
                  style: theme.textTheme.titleMedium?.copyWith(
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
            ),
          ),
        ],
      ),
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
