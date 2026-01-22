import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/book_search/application/book_search_notifier.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart';
import 'package:shelfie/features/book_search/domain/isbn_extractor.dart';

/// ISBN スキャン結果ダイアログ
///
/// スキャンした ISBN から書籍を検索し、結果を表示する。
/// 書籍が見つかった場合は本棚への追加ボタンを表示する。
class ISBNScanResultDialog extends ConsumerStatefulWidget {
  const ISBNScanResultDialog({
    required this.isbn,
    super.key,
  });

  final String isbn;

  /// ダイアログを表示するヘルパーメソッド
  static Future<bool?> show(BuildContext context, String isbn) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
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

  Future<void> _addToShelf() async {
    final book = _book;
    if (book == null) return;

    setState(() {
      _isAddingToShelf = true;
    });

    final result =
        await ref.read(bookSearchNotifierProvider.notifier).addToShelf(book);

    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() {
          _isAddingToShelf = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.userMessage),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      },
      (userBook) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('「${book.title}」を本棚に追加しました'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: AppSpacing.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDragHandle(theme),
              const SizedBox(height: AppSpacing.md),
              _buildISBNHeader(theme),
              const SizedBox(height: AppSpacing.lg),
              if (_isLoading)
                _buildLoadingState()
              else if (_errorMessage != null)
                _buildErrorState(theme)
              else if (_book != null)
                _buildBookDetails(theme),
              const SizedBox(height: AppSpacing.lg),
              _buildActions(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDragHandle(ThemeData theme) {
    return Center(
      child: Container(
        width: 32,
        height: 4,
        decoration: BoxDecoration(
          color: theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildISBNHeader(ThemeData theme) {
    return Row(
      children: [
        Icon(
          Icons.qr_code_scanner,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          'ISBN: ${ISBNExtractor.formatISBN(widget.isbn)}',
          style: theme.textTheme.titleMedium?.copyWith(
            fontFamily: 'monospace',
          ),
        ),
      ],
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

  Widget _buildBookDetails(ThemeData theme) {
    final book = _book!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCoverImage(theme, book),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book.title,
                style: theme.textTheme.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                _formatAuthors(book.authors),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (book.publisher != null) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  book.publisher!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              if (book.publishedDate != null) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  book.publishedDate!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCoverImage(ThemeData theme, Book book) {
    const imageWidth = 80.0;
    const imageHeight = 120.0;

    if (book.coverImageUrl != null && book.coverImageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          book.coverImageUrl!,
          width: imageWidth,
          height: imageHeight,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              _buildPlaceholder(theme, imageWidth, imageHeight),
        ),
      );
    }
    return _buildPlaceholder(theme, imageWidth, imageHeight);
  }

  Widget _buildPlaceholder(ThemeData theme, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.book,
        size: 32,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildActions(ThemeData theme) {
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
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('キャンセル'),
        ),
        const SizedBox(width: AppSpacing.sm),
        FilledButton(
          onPressed: _isAddingToShelf ? null : _addToShelf,
          child: _isAddingToShelf
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('本棚に追加'),
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
