import 'dart:async';

import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shelfie/core/auth/auth_state.dart';
import 'package:shelfie/core/auth/guest_login_prompt.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_icon_size.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/error_view.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/features/book_detail/application/book_detail_notifier.dart';
import 'package:shelfie/features/book_detail/domain/book_detail.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_detail/presentation/utils/gradient_color_matcher.dart';
import 'package:shelfie/features/book_detail/presentation/widgets/book_info_section.dart';
import 'package:shelfie/features/book_detail/presentation/widgets/rating_modal.dart';
import 'package:shelfie/features/book_detail/presentation/widgets/reading_note_modal.dart';
import 'package:shelfie/features/book_detail/presentation/widgets/reading_note_section.dart';
import 'package:shelfie/features/book_detail/presentation/widgets/reading_record_section.dart';
import 'package:shelfie/features/book_detail/presentation/widgets/reading_status_modal.dart';
import 'package:shelfie/features/book_list/data/book_list_repository.dart';
import 'package:shelfie/features/book_list/presentation/widgets/list_selector_modal.dart';
import 'package:shelfie/features/book_search/application/recent_books_notifier.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart'
    show BookSource;
import 'package:shelfie/features/book_share/presentation/share_card_screen.dart';
import 'package:url_launcher/url_launcher.dart';

/// 本詳細画面
///
/// 書籍の詳細情報を表示し、本棚への追加・読書記録の管理機能を提供する。
class BookDetailScreen extends ConsumerStatefulWidget {
  const BookDetailScreen({
    required this.bookId,
    required this.source,
    super.key,
  });

  final String bookId;
  final BookSource source;

  @override
  ConsumerState<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends ConsumerState<BookDetailScreen> {
  bool _isAddingToShelf = false;
  bool _isRemovingFromShelf = false;
  bool _hasAddedToRecentBooks = false;
  Color? _gradientColor;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(bookDetailNotifierProvider(widget.bookId).notifier)
          .loadBookDetail(source: widget.source);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bookDetailNotifierProvider(widget.bookId));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          _buildShareButton(),
          _buildMoreMenu(),
        ],
      ),
      body: state.when(
        data: (bookDetail) => _buildContent(bookDetail),
        loading: () => const LoadingIndicator(fullScreen: true),
        error: (error, _) => _buildErrorView(error),
      ),
    );
  }

  Widget _buildContent(BookDetail? bookDetail) {
    if (bookDetail == null) {
      return const LoadingIndicator(fullScreen: true);
    }

    if (!_hasExtractedColor) {
      final cached = getCachedGradientColor(bookDetail.thumbnailUrl);
      if (cached != null) {
        _gradientColor = cached;
        _hasExtractedColor = true;
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addToRecentBooks(bookDetail);
      _extractGradientColor(bookDetail.thumbnailUrl);
    });

    final isGuest = ref.watch(authStateProvider.select((s) => s.isGuest));

    final shelfEntry = isGuest
        ? null
        : ref.watch(shelfStateProvider.select((s) => s[widget.bookId]));
    final isInShelf = shelfEntry != null;

    final theme = Theme.of(context);
    final accentColor = _gradientColor ?? theme.colorScheme.surface;
    final gradientHeight =
        MediaQuery.of(context).padding.top +
        kToolbarHeight +
        AppSpacing.md +
        240 +
        40;

    return SingleChildScrollView(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: gradientHeight,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [accentColor, accentColor, theme.colorScheme.surface],
                  stops: const [0.0, 0.2, 1.0],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top:
                  MediaQuery.of(context).padding.top +
                  kToolbarHeight +
                  AppSpacing.md,
              left: AppSpacing.md,
              right: AppSpacing.md,
              bottom: AppSpacing.xxl,
            ),
            child: BookInfoSection(
              bookDetail: bookDetail,
              isInShelf: isInShelf,
              isAddingToShelf: _isAddingToShelf,
              isRemovingFromShelf: _isRemovingFromShelf,
              onAddToShelfPressed: _onAddToShelfPressed,
              onRemoveFromShelfPressed: _onRemoveFromShelfPressed,
              onLinkTap: _onLinkTap,
              headerBottomSlot: isInShelf
                  ? Column(
                      children: [
                        ReadingRecordSection(
                          shelfEntry: shelfEntry,
                          onStatusTap: _onStatusTap,
                          onRatingTap: _onRatingTap,
                          onCompletedAtTap: shelfEntry.isCompleted
                              ? _onCompletedAtSelected
                              : null,
                          onStartedAtTap:
                              shelfEntry.readingStatus == ReadingStatus.reading ||
                                  shelfEntry.isCompleted
                              ? _onStartedAtSelected
                              : null,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        ReadingNoteSection(
                          shelfEntry: shelfEntry,
                          onNoteTap: _onNoteTap,
                        ),
                      ],
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(Object error) {
    final failure = error is Failure
        ? error
        : UnexpectedFailure(message: error.toString());

    return Center(
      child: Padding(
        padding: AppSpacing.horizontal(AppSpacing.md),
        child: ErrorView(
          failure: failure,
          onRetry: _onRetry,
          retryButtonText: '再試行',
        ),
      ),
    );
  }

  Widget _buildShareButton() {
    final shelfEntry = ref.watch(
      shelfStateProvider.select((s) => s[widget.bookId]),
    );
    if (shelfEntry == null || !shelfEntry.isCompleted) {
      return const SizedBox.shrink();
    }

    return IconButton(
      icon: const Icon(Icons.share),
      onPressed: () => _navigateToShare(),
    );
  }

  void _navigateToShare() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => ShareCardScreen(externalId: widget.bookId),
      ),
    );
  }

  Widget _buildMoreMenu() {
    return IconButton(
      icon: const Icon(Icons.more_vert),
      onPressed: _showMoreBottomSheet,
    );
  }

  void _showMoreBottomSheet() {
    unawaited(HapticFeedback.mediumImpact());

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) => _BookDetailMoreSheet(
        bookId: widget.bookId,
        onAddToListPressed: _onAddToListPressed,
      ),
    );
  }

  bool get _isGuest => ref.read(authStateProvider).isGuest;

  Future<void> _onAddToShelfPressed() async {
    if (_isGuest) {
      showGuestLoginSnackBar(context);
      return;
    }
    if (_isAddingToShelf) return;

    final addResult = await showAddToShelfModal(context: context);
    if (addResult == null || !mounted) return;

    setState(() {
      _isAddingToShelf = true;
    });

    final result = await ref
        .read(bookDetailNotifierProvider(widget.bookId).notifier)
        .addToShelf(readingStatus: addResult.status);

    if (!mounted) return;

    setState(() {
      _isAddingToShelf = false;
    });

    result.fold(
      (failure) {
        AdaptiveSnackBar.show(
          context,
          message: failure.userMessage,
          type: AdaptiveSnackBarType.error,
        );
      },
      (_) {
        if (addResult.rating != null) {
          final shelfEntry = ref.read(shelfStateProvider)[widget.bookId];
          if (shelfEntry != null) {
            unawaited(
              ref
                  .read(bookDetailNotifierProvider(widget.bookId).notifier)
                  .updateRating(
                    userBookId: shelfEntry.userBookId,
                    rating: addResult.rating,
                  ),
            );
          }
        }
        AdaptiveSnackBar.show(
          context,
          message: '「${addResult.status.displayName}」で登録しました',
          type: AdaptiveSnackBarType.success,
        );
      },
    );
  }

  Future<void> _onRemoveFromShelfPressed() async {
    if (_isRemovingFromShelf) return;

    setState(() {
      _isRemovingFromShelf = true;
    });

    final result = await ref
        .read(bookDetailNotifierProvider(widget.bookId).notifier)
        .removeFromShelf();

    if (!mounted) return;

    setState(() {
      _isRemovingFromShelf = false;
    });

    result.fold((failure) {
      AdaptiveSnackBar.show(
        context,
        message: failure.userMessage,
        type: AdaptiveSnackBarType.error,
      );
    }, (_) {});
  }

  Future<void> _onStatusTap() async {
    if (_isGuest) {
      showGuestLoginSnackBar(context);
      return;
    }
    final shelfEntry = ref.read(shelfStateProvider)[widget.bookId];
    if (shelfEntry == null) return;

    final previousStatus = shelfEntry.readingStatus;

    final newStatus = await showReadingStatusModal(
      context: context,
      currentStatus: shelfEntry.readingStatus,
      userBookId: shelfEntry.userBookId,
      externalId: widget.bookId,
    );

    if (!mounted) return;
    if (newStatus == ReadingStatus.completed &&
        previousStatus != ReadingStatus.completed) {
      AdaptiveSnackBar.show(
        context,
        message: '読了おめでとうございます！シェアしませんか？',
        type: AdaptiveSnackBarType.success,
        action: 'シェア',
        onActionPressed: _navigateToShare,
      );
    }
  }

  void _onNoteTap() {
    if (_isGuest) {
      showGuestLoginSnackBar(context);
      return;
    }
    final shelfEntry = ref.read(shelfStateProvider)[widget.bookId];
    if (shelfEntry == null) return;

    showReadingNoteModal(
      context: context,
      currentNote: shelfEntry.note,
      userBookId: shelfEntry.userBookId,
      externalId: widget.bookId,
    );
  }

  Future<void> _onCompletedAtSelected(DateTime selectedDate) async {
    if (_isGuest) {
      showGuestLoginSnackBar(context);
      return;
    }
    final shelfEntry = ref.read(shelfStateProvider)[widget.bookId];
    if (shelfEntry == null) return;

    final result = await ref
        .read(bookDetailNotifierProvider(widget.bookId).notifier)
        .updateCompletedAt(
          userBookId: shelfEntry.userBookId,
          completedAt: selectedDate,
        );

    if (!mounted) return;

    result.fold(
      (failure) {
        AdaptiveSnackBar.show(
          context,
          message: failure.userMessage,
          type: AdaptiveSnackBarType.error,
        );
      },
      (_) {
        AdaptiveSnackBar.show(
          context,
          message: '読了日を更新しました',
          type: AdaptiveSnackBarType.success,
        );
      },
    );
  }

  Future<void> _onStartedAtSelected(DateTime selectedDate) async {
    if (_isGuest) {
      showGuestLoginSnackBar(context);
      return;
    }
    final shelfEntry = ref.read(shelfStateProvider)[widget.bookId];
    if (shelfEntry == null) return;

    final result = await ref
        .read(bookDetailNotifierProvider(widget.bookId).notifier)
        .updateStartedAt(
          userBookId: shelfEntry.userBookId,
          startedAt: selectedDate,
        );

    if (!mounted) return;

    result.fold(
      (failure) {
        AdaptiveSnackBar.show(
          context,
          message: failure.userMessage,
          type: AdaptiveSnackBarType.error,
        );
      },
      (_) {
        AdaptiveSnackBar.show(
          context,
          message: '読書開始日を更新しました',
          type: AdaptiveSnackBarType.success,
        );
      },
    );
  }

  void _onRatingTap() {
    if (_isGuest) {
      showGuestLoginSnackBar(context);
      return;
    }
    final shelfEntry = ref.read(shelfStateProvider)[widget.bookId];
    if (shelfEntry == null) return;

    showRatingModal(
      context: context,
      currentRating: shelfEntry.rating,
      userBookId: shelfEntry.userBookId,
      externalId: widget.bookId,
    );
  }

  Future<void> _onLinkTap(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _onRetry() {
    ref
        .read(bookDetailNotifierProvider(widget.bookId).notifier)
        .loadBookDetail(source: widget.source);
  }

  void _addToRecentBooks(BookDetail bookDetail) {
    if (_hasAddedToRecentBooks) return;
    _hasAddedToRecentBooks = true;

    ref
        .read(recentBooksNotifierProvider.notifier)
        .addRecentBook(
          bookId: bookDetail.id,
          title: bookDetail.title,
          authors: bookDetail.authors,
          coverImageUrl: bookDetail.thumbnailUrl,
          source: widget.source.name,
        );
  }

  bool _hasExtractedColor = false;

  Future<void> _extractGradientColor(String? thumbnailUrl) async {
    if (_hasExtractedColor) return;
    _hasExtractedColor = true;

    final color = await extractGradientColor(thumbnailUrl);
    if (!mounted) return;
    setState(() {
      _gradientColor = color;
    });
  }

  void _onAddToListPressed(ShelfEntry shelfEntry) {
    showListSelectorModal(
      context: context,
      userBookId: shelfEntry.userBookId,
      onListSelected: (listId) async {
        final repository = ref.read(bookListRepositoryProvider);
        final result = await repository.addBookToList(
          listId: listId,
          userBookId: shelfEntry.userBookId,
        );

        if (!mounted) return;

        result.fold(
          (failure) {
            AdaptiveSnackBar.show(
              context,
              message: failure.userMessage,
              type: AdaptiveSnackBarType.error,
            );
          },
          (_) {
            AdaptiveSnackBar.show(
              context,
              message: 'リストに追加しました',
              type: AdaptiveSnackBarType.success,
            );
          },
        );
      },
    );
  }
}

class _BookDetailMoreSheet extends ConsumerWidget {
  const _BookDetailMoreSheet({
    required this.bookId,
    required this.onAddToListPressed,
  });

  final String bookId;
  final void Function(ShelfEntry) onAddToListPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;
    final shelfEntry = ref.watch(shelfStateProvider.select((s) => s[bookId]));
    final isInShelf = shelfEntry != null;

    return SafeArea(
      child: Padding(
        padding: AppSpacing.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDragHandle(theme),
            const SizedBox(height: AppSpacing.md),
            _buildActionItem(
              context: context,
              theme: theme,
              appColors: appColors,
              icon: Icons.playlist_add,
              label: 'リストに追加',
              enabled: isInShelf,
              onTap: isInShelf
                  ? () {
                      unawaited(HapticFeedback.selectionClick());
                      Navigator.pop(context);
                      onAddToListPressed(shelfEntry);
                    }
                  : null,
            ),
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

  Widget _buildActionItem({
    required BuildContext context,
    required ThemeData theme,
    required AppColors appColors,
    required IconData icon,
    required String label,
    required bool enabled,
    VoidCallback? onTap,
  }) {
    final color = enabled ? appColors.foreground : appColors.foregroundMuted;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: AppIconSize.base),
            const SizedBox(width: AppSpacing.md),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
