import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';

class ProfileBookCard extends ConsumerWidget {
  const ProfileBookCard({
    required this.book,
    required this.onTap,
    this.onLongPress,
    super.key,
  });

  final ShelfBookItem book;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = Theme.of(context).extension<AppColors>()!;

    final shelfEntry = ref.watch(
      shelfStateProvider.select((s) => s[book.externalId]),
    );
    final rating = shelfEntry?.rating ?? book.rating ?? 0;

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: _buildCoverImage(appColors),
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          _buildRating(appColors, rating),
        ],
      ),
    );
  }

  Widget _buildCoverImage(AppColors appColors) {
    if (book.hasCoverImage) {
      return CachedNetworkImage(
        imageUrl: book.coverImageUrl!,
        fit: BoxFit.cover,
        width: double.infinity,
        placeholder: (context, url) => _buildPlaceholder(appColors),
        errorWidget: (context, url, error) => _buildPlaceholder(appColors),
      );
    }
    return _buildPlaceholder(appColors);
  }

  Widget _buildPlaceholder(AppColors appColors) {
    return ColoredBox(
      color: appColors.surfaceElevatedLegacy,
      child: Center(
        child: Icon(Icons.book, size: 32, color: appColors.textSecondaryLegacy),
      ),
    );
  }

  Widget _buildRating(AppColors appColors, int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final isFilled = index < rating;
        return Icon(
          Icons.star_rounded,
          size: 18,
          color: isFilled ? appColors.starLegacy : appColors.inactiveLegacy,
        );
      }),
    );
  }
}
