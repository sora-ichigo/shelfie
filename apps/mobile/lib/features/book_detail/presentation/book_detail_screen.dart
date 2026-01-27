import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/error_view.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/features/book_detail/application/book_detail_notifier.dart';
import 'package:shelfie/features/book_detail/domain/book_detail.dart';
import 'package:shelfie/features/book_detail/presentation/services/share_service.dart';
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
import 'package:url_launcher/url_launcher.dart';

/// 本詳細画面
///
/// 書籍の詳細情報を表示し、本棚への追加・読書記録の管理機能を提供する。
class BookDetailScreen extends ConsumerStatefulWidget {
  const BookDetailScreen({
    required this.bookId,
    this.source,
    super.key,
  });

  final String bookId;
  final BookSource? source;

  @override
  ConsumerState<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends ConsumerState<BookDetailScreen> {
  bool _isAddingToShelf = false;
  bool _isRemovingFromShelf = false;
  Color? _dominantColor;
  String? _extractedThumbnailUrl;
  bool _hasAddedToRecentBooks = false;

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
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.xs),
            child: IconButton(
              icon: const Icon(Icons.share),
              onPressed: _onSharePressed,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          _buildBackgroundGradient(),
          state.when(
            data: (bookDetail) => _buildContent(bookDetail),
            loading: () => const LoadingIndicator(fullScreen: true),
            error: (error, _) => _buildErrorView(error),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundGradient() {
    final theme = Theme.of(context);
    final gradientColor = _dominantColor ?? Colors.black;

    return Positioned.fill(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0.8, -0.3),
            radius: 1.5,
            colors: [
              gradientColor.withOpacity(0.2),
              theme.colorScheme.surface,
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _extractDominantColor(String? thumbnailUrl) async {
    if (thumbnailUrl == null || thumbnailUrl == _extractedThumbnailUrl) {
      return;
    }

    _extractedThumbnailUrl = thumbnailUrl;

    try {
      final paletteGenerator = await PaletteGenerator.fromImageProvider(
        NetworkImage(thumbnailUrl),
        size: const Size(100, 150),
        maximumColorCount: 10,
      );

      if (!mounted) return;

      final color = paletteGenerator.dominantColor?.color ??
          paletteGenerator.vibrantColor?.color ??
          paletteGenerator.mutedColor?.color;

      if (color != null) {
        setState(() {
          _dominantColor = color;
        });
      }
    } catch (e) {
      debugPrint('Failed to extract color from $thumbnailUrl: $e');
    }
  }

  Widget _buildContent(BookDetail? bookDetail) {
    if (bookDetail == null) {
      return const LoadingIndicator(fullScreen: true);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _extractDominantColor(bookDetail.thumbnailUrl);
      _addToRecentBooks(bookDetail);
    });

    final shelfEntry = ref.watch(
      shelfStateProvider.select((s) => s[widget.bookId]),
    );
    final isInShelf = shelfEntry != null;

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top +
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
        onAddToListPressed: isInShelf ? () => _onAddToListPressed(shelfEntry!) : null,
        onLinkTap: _onLinkTap,
        headerBottomSlot: isInShelf
            ? Column(
                children: [
                  ReadingRecordSection(
                    shelfEntry: shelfEntry,
                    onStatusTap: _onStatusTap,
                    onRatingTap: _onRatingTap,
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
    );
  }

  Widget _buildErrorView(Object error) {
    final failure =
        error is Failure ? error : UnexpectedFailure(message: error.toString());

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

  Future<void> _onSharePressed() async {
    final state = ref.read(bookDetailNotifierProvider(widget.bookId));
    final bookDetail = state.value;
    if (bookDetail == null) return;

    final shareService = ref.read(shareServiceProvider);
    await shareService.shareBook(
      title: bookDetail.title,
      url: bookDetail.amazonUrl ?? bookDetail.rakutenBooksUrl,
    );
  }

  Future<void> _onAddToShelfPressed() async {
    if (_isAddingToShelf) return;

    final selectedStatus = await showAddToShelfModal(context: context);
    if (selectedStatus == null || !mounted) return;

    setState(() {
      _isAddingToShelf = true;
    });

    final result = await ref
        .read(bookDetailNotifierProvider(widget.bookId).notifier)
        .addToShelf(readingStatus: selectedStatus);

    if (!mounted) return;

    setState(() {
      _isAddingToShelf = false;
    });

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.userMessage),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      },
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('「${selectedStatus.displayName}」で登録しました')),
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

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.userMessage),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      },
      (_) {},
    );
  }

  void _onStatusTap() {
    final shelfEntry = ref.read(shelfStateProvider)[widget.bookId];
    if (shelfEntry == null) return;

    showReadingStatusModal(
      context: context,
      currentStatus: shelfEntry.readingStatus,
      userBookId: shelfEntry.userBookId,
      externalId: widget.bookId,
    );
  }

  void _onNoteTap() {
    final shelfEntry = ref.read(shelfStateProvider)[widget.bookId];
    if (shelfEntry == null) return;

    showReadingNoteModal(
      context: context,
      currentNote: shelfEntry.note,
      userBookId: shelfEntry.userBookId,
      externalId: widget.bookId,
    );
  }

  void _onRatingTap() {
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

    ref.read(recentBooksNotifierProvider.notifier).addRecentBook(
      bookId: bookDetail.id,
      title: bookDetail.title,
      authors: bookDetail.authors,
      coverImageUrl: bookDetail.thumbnailUrl,
      source: widget.source?.name,
    );
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(failure.userMessage),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          },
          (_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('リストに追加しました')),
            );
          },
        );
      },
    );
  }
}
