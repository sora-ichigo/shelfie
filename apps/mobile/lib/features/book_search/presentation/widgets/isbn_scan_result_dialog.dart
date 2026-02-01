import 'dart:async';

import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_icon_size.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/theme/app_typography.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_search/application/book_search_notifier.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/book_quick_actions_modal.dart';
import 'package:shelfie/routing/app_router.dart';

class ISBNScanResultDialog extends ConsumerStatefulWidget {
  const ISBNScanResultDialog({
    required this.isbn,
    super.key,
  });

  final String isbn;

  static Future<bool?> show(BuildContext context, String isbn) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) => ISBNScanResultDialog(isbn: isbn),
    );
  }

  @override
  ConsumerState<ISBNScanResultDialog> createState() =>
      _ISBNScanResultDialogState();
}

class _ISBNScanResultDialogState extends ConsumerState<ISBNScanResultDialog> {
  Book? _book;
  bool _isLoading = true;
  bool _isAddingToShelf = false;
  String? _errorMessage;
  ReadingStatus _selectedStatus = ReadingStatus.backlog;
  int? _selectedRating;

  @override
  void initState() {
    super.initState();
    _searchBook();
  }

  Future<void> _searchBook() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final repository = ref.read(bookSearchRepositoryProvider);
    final result = await repository.searchBookByISBN(isbn: widget.isbn);

    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() {
          _isLoading = false;
          _errorMessage = '検索中にエラーが発生しました';
        });
      },
      (book) {
        if (book != null) {
          final shelfEntry = ref.read(shelfStateProvider)[book.id];
          if (shelfEntry != null) {
            _showExistingBookActions(book, shelfEntry);
            return;
          }
        }

        setState(() {
          _isLoading = false;
          _book = book;
          if (book == null) {
            _errorMessage = '書籍が見つかりませんでした';
          }
        });
      },
    );
  }

  void _showExistingBookActions(Book book, ShelfEntry shelfEntry) {
    final shelfBookItem = ShelfBookItem(
      userBookId: shelfEntry.userBookId,
      externalId: book.id,
      title: book.title,
      authors: book.authors,
      source: book.source,
      addedAt: shelfEntry.addedAt,
      coverImageUrl: book.coverImageUrl,
    );

    Navigator.pop(context);
    showBookQuickActionsModal(
      context: context,
      ref: ref,
      book: shelfBookItem,
      shelfEntry: shelfEntry,
    );
  }

  Future<void> _addToShelf() async {
    final book = _book;
    if (book == null) return;

    setState(() {
      _isAddingToShelf = true;
    });

    final result = await ref
        .read(bookSearchNotifierProvider.notifier)
        .addToShelf(book, readingStatus: _selectedStatus);

    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() {
          _isAddingToShelf = false;
        });
        AdaptiveSnackBar.show(
          context,
          message: failure.userMessage,
          type: AdaptiveSnackBarType.error,
        );
      },
      (_) {
        if (_selectedRating != null) {
          unawaited(
            ref.read(shelfStateProvider.notifier).updateRatingWithApi(
                  externalId: book.id,
                  rating: _selectedRating,
                ),
          );
        }
        AdaptiveSnackBar.show(
          context,
          message: '「${_selectedStatus.displayName}」で登録しました',
          type: AdaptiveSnackBarType.success,
        );
        Navigator.of(context).pop(true);
      },
    );
  }

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
            if (_isLoading)
              _buildLoadingState()
            else if (_errorMessage != null)
              _buildErrorState(theme)
            else if (_book != null) ...[
              _buildBookInfo(theme, appColors),
              const SizedBox(height: AppSpacing.lg),
              _buildReadingStatusSection(theme, appColors),
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                child: _selectedStatus == ReadingStatus.completed
                    ? _buildRatingSection(theme, appColors)
                    : const SizedBox.shrink(),
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            _buildActions(theme, appColors),
          ],
        ),
      ),
    );
  }

  Widget _buildDragHandle(ThemeData theme) {
    return Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const SizedBox(
      height: 200,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorState(ThemeData theme) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 48,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              _errorMessage!,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToBookDetail() {
    final book = _book;
    if (book == null) return;

    Navigator.pop(context);
    context.push(AppRoutes.bookDetail(bookId: book.id, source: book.source));
  }

  Widget _buildBookInfo(ThemeData theme, AppColors appColors) {
    final book = _book!;

    return GestureDetector(
      onTap: _navigateToBookDetail,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            child: SizedBox(
              width: 48,
              height: 72,
              child:
                  book.coverImageUrl != null && book.coverImageUrl!.isNotEmpty
                      ? Image.network(
                          book.coverImageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildImagePlaceholder(appColors),
                        )
                      : _buildImagePlaceholder(appColors),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  _formatAuthors(book.authors),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.captionSmall.copyWith(
                    color: appColors.foregroundMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder(AppColors appColors) {
    return ColoredBox(
      color: appColors.overlay,
      child: Center(
        child: Icon(
          Icons.book,
          size: AppIconSize.base,
          color: appColors.foregroundMuted,
        ),
      ),
    );
  }

  Widget _buildReadingStatusSection(ThemeData theme, AppColors appColors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '読書状態',
          style: theme.textTheme.labelMedium?.copyWith(
            color: appColors.foregroundMuted,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _buildStatusButton(theme, ReadingStatus.interested),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: _buildStatusButton(theme, ReadingStatus.backlog),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: _buildStatusButton(theme, ReadingStatus.reading),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: _buildStatusButton(theme, ReadingStatus.completed),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusButton(ThemeData theme, ReadingStatus status) {
    final isSelected = _selectedStatus == status;
    final statusColor = _getStatusColor(status);

    return InkWell(
      onTap: _isAddingToShelf
          ? null
          : () {
              unawaited(HapticFeedback.selectionClick());
              setState(() {
                _selectedStatus = status;
                if (status != ReadingStatus.completed) {
                  _selectedRating = null;
                }
              });
            },
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        decoration: BoxDecoration(
          color: isSelected
              ? statusColor.withOpacity(0.3)
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(
            color: isSelected ? statusColor : Colors.white.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            status.displayName,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: isSelected ? statusColor : const Color(0xFF99A1AF),
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(ReadingStatus status) {
    return switch (status) {
      ReadingStatus.backlog => const Color(0xFFFFB74D),
      ReadingStatus.reading => const Color(0xFF64B5F6),
      ReadingStatus.completed => const Color(0xFF81C784),
      ReadingStatus.interested => const Color(0xFFE091D6),
    };
  }

  Widget _buildRatingSection(ThemeData theme, AppColors appColors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.lg),
        Text(
          '評価（任意）',
          style: theme.textTheme.labelMedium?.copyWith(
            color: appColors.foregroundMuted,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: List.generate(5, (index) {
            final starValue = index + 1;
            final isSelected =
                _selectedRating != null && _selectedRating! >= starValue;

            return GestureDetector(
              onTap: _isAddingToShelf
                  ? null
                  : () {
                      setState(() {
                        _selectedRating =
                            _selectedRating == starValue ? null : starValue;
                      });
                    },
              child: Padding(
                padding: const EdgeInsets.only(right: AppSpacing.xs),
                child: Icon(
                  isSelected ? Icons.star : Icons.star_border,
                  size: 32.0,
                  color: isSelected
                      ? appColors.accentSecondary
                      : theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildActions(ThemeData theme, AppColors appColors) {
    if (_isLoading) {
      return const SizedBox.shrink();
    }

    if (_errorMessage != null && _book == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('閉じる'),
          ),
          const SizedBox(width: AppSpacing.sm),
          FilledButton(
            onPressed: _searchBook,
            child: const Text('再試行'),
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed:
                  _isAddingToShelf ? null : () => Navigator.pop(context, false),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.1),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
              ),
              child: const Text('キャンセル'),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: SizedBox(
            height: 48,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [appColors.success, appColors.accent],
                ),
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: ElevatedButton(
                onPressed: _isAddingToShelf ? null : _addToShelf,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  disabledBackgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  disabledForegroundColor: Colors.white.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                ),
                child: _isAddingToShelf
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('登録'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _formatAuthors(List<String> authors) {
    if (authors.isEmpty) {
      return '著者不明';
    }
    return authors.join(', ');
  }
}
