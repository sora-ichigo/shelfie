import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_radius.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/edit_screen_header.dart';
import 'package:shelfie/core/widgets/form_fields.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/features/book_list/application/book_list_notifier.dart';
import 'package:shelfie/features/book_list/application/book_list_state.dart';
import 'package:shelfie/features/book_list/data/book_list_repository.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';
import 'package:shelfie/features/book_list/presentation/widgets/book_selector_modal.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';

class BookListEditScreen extends ConsumerStatefulWidget {
  const BookListEditScreen({
    this.existingList,
    this.listId,
    super.key,
  });

  final BookList? existingList;

  final int? listId;

  bool get isEditing => existingList != null || listId != null;

  @override
  ConsumerState<BookListEditScreen> createState() => _BookListEditScreenState();
}

class _BookListEditScreenState extends ConsumerState<BookListEditScreen> {
  static const _titleMaxLength = 50;
  static const _descriptionMaxLength = 200;

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  bool _isSaving = false;
  String? _titleError;
  BookList? _loadedList;
  final List<ShelfBookItem> _selectedBooks = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.existingList?.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.existingList?.description ?? '',
    );
    _titleController.addListener(_onTitleChanged);

    if (widget.listId != null && widget.existingList == null) {
      _loadListData();
    }

    if (!widget.isEditing) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _onAddBooksPressed();
      });
    }
  }

  void _loadListData() {
    ref
        .read(bookListDetailNotifierProvider(widget.listId!).notifier)
        .loadDetail();
  }

  @override
  void dispose() {
    _titleController.removeListener(_onTitleChanged);
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onTitleChanged() {
    setState(() {
      if (_titleController.text.isEmpty && _titleError == null) {
        _titleError = 'タイトルを入力してください';
      } else if (_titleController.text.isNotEmpty && _titleError != null) {
        _titleError = null;
      }
    });
  }

  bool get _canSave => _titleController.text.isNotEmpty && !_isSaving;

  int? get _currentListId => widget.listId ?? widget.existingList?.id;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    if (widget.listId != null && widget.existingList == null) {
      final detailState =
          ref.watch(bookListDetailNotifierProvider(widget.listId!));

      return switch (detailState) {
        BookListDetailInitial() ||
        BookListDetailLoading() =>
          _buildLoadingScreen(),
        BookListDetailLoaded(:final list) =>
          _buildEditForm(theme, appColors, list),
        BookListDetailError(:final failure) =>
          _buildErrorScreen(failure.userMessage),
      };
    }

    return _buildEditForm(theme, appColors, null);
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            EditScreenHeader(
              title: 'リスト編集',
              onClose: () => Navigator.of(context).pop(),
              onSave: () {},
              isSaveEnabled: false,
            ),
            const Expanded(
              child: LoadingIndicator(fullScreen: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorScreen(String message) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            EditScreenHeader(
              title: 'リスト編集',
              onClose: () => Navigator.of(context).pop(),
              onSave: () {},
              isSaveEnabled: false,
            ),
            Expanded(
              child: Center(child: Text(message)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditForm(
      ThemeData theme, AppColors appColors, BookListDetail? loadedDetail) {
    if (loadedDetail != null && _loadedList == null) {
      _loadedList = BookList(
        id: loadedDetail.id,
        title: loadedDetail.title,
        description: loadedDetail.description,
        createdAt: loadedDetail.createdAt,
        updatedAt: loadedDetail.updatedAt,
      );
      _titleController.text = loadedDetail.title;
      _descriptionController.text = loadedDetail.description ?? '';
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                EditScreenHeader(
                  title: widget.isEditing ? 'リスト編集' : '新しいリスト',
                  onClose: () => Navigator.of(context).pop(),
                  onSave: _onSave,
                  isSaveEnabled: _canSave,
                ),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      padding: AppSpacing.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (!widget.isEditing) ...[
                            _buildBookSection(theme, appColors),
                            const SizedBox(height: AppSpacing.xl),
                          ],
                          _buildTitleField(),
                          const SizedBox(height: AppSpacing.md),
                          _buildDescriptionField(),
                          if (widget.isEditing) ...[
                            const SizedBox(height: AppSpacing.xl),
                            _buildDeleteButton(appColors),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (_isSaving)
              ColoredBox(
                color: Colors.black.withOpacity(0.3),
                child: const LoadingIndicator(fullScreen: true),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return LabeledTextField(
      key: const Key('title_field'),
      label: 'リスト名',
      controller: _titleController,
      maxLength: _titleMaxLength,
      hintText: '例: 今年読みたい本',
      errorText: _titleError,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _buildDescriptionField() {
    return LabeledTextField(
      key: const Key('description_field'),
      label: '説明（任意）',
      controller: _descriptionController,
      maxLength: _descriptionMaxLength,
      hintText: 'このリストについて説明を追加',
      maxLines: 4,
      textInputAction: TextInputAction.done,
    );
  }

  Widget _buildBookSection(ThemeData theme, AppColors appColors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '本（${_selectedBooks.length}冊）',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        if (_selectedBooks.isEmpty)
          _BookSectionEmptyCard(
            appColors: appColors,
            theme: theme,
            onAddPressed: _onAddBooksPressed,
          )
        else
          _buildSelectedBooksList(theme, appColors),
      ],
    );
  }

  Widget _buildSelectedBooksList(ThemeData theme, AppColors appColors) {
    return Column(
      children: [
        ..._selectedBooks.map(
          (book) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _SelectedBookListTile(
              book: book,
              appColors: appColors,
              theme: theme,
              onRemove: () => _onRemoveBook(book),
            ),
          ),
        ),
        TextButton.icon(
          onPressed: _onAddBooksPressed,
          icon: Icon(Icons.add, color: appColors.accent),
          label: Text(
            '本を追加',
            style: TextStyle(color: appColors.accent),
          ),
        ),
      ],
    );
  }

  void _onAddBooksPressed() {
    showBookSelectorModal(
      context: context,
      existingUserBookIds: const [],
      initialSelectedUserBookIds:
          _selectedBooks.map((b) => b.userBookId).toList(),
      onBookSelected: (book) {
        setState(() {
          _selectedBooks.add(book);
        });
      },
      onBookRemoved: (book) {
        setState(() {
          _selectedBooks.removeWhere((b) => b.userBookId == book.userBookId);
        });
      },
    );
  }

  void _onRemoveBook(ShelfBookItem book) {
    setState(() {
      _selectedBooks.removeWhere((b) => b.userBookId == book.userBookId);
    });
  }

  Widget _buildDeleteButton(AppColors appColors) {
    return TextButton(
      onPressed: _isSaving ? null : _onDelete,
      child: Text(
        'リストを削除',
        style: TextStyle(color: appColors.error),
      ),
    );
  }

  Future<void> _onSave() async {
    if (!_canSave) return;

    setState(() => _isSaving = true);

    final repository = ref.read(bookListRepositoryProvider);
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    final listId = _currentListId;
    final result = widget.isEditing && listId != null
        ? await repository.updateBookList(
            listId: listId,
            title: title,
            description: description.isEmpty ? null : description,
          )
        : await repository.createBookList(
            title: title,
            description: description.isEmpty ? null : description,
          );

    if (!mounted) return;

    await result.fold(
      (failure) async {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.userMessage)),
        );
      },
      (bookList) async {
        if (!widget.isEditing && _selectedBooks.isNotEmpty) {
          for (final book in _selectedBooks) {
            await repository.addBookToList(
              listId: bookList.id,
              userBookId: book.userBookId,
            );
          }
        }
        if (mounted) {
          await ref.read(bookListNotifierProvider.notifier).refresh();
          if (mounted) {
            Navigator.of(context).pop(bookList);
          }
        }
      },
    );
  }

  Future<void> _onDelete() async {
    final listId = _currentListId;
    if (listId == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('リストを削除'),
        content: const Text('このリストを削除しますか？この操作は取り消せません。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('削除'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    setState(() => _isSaving = true);

    final repository = ref.read(bookListRepositoryProvider);
    final result = await repository.deleteBookList(listId: listId);

    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.userMessage)),
        );
      },
      (_) {
        Navigator.of(context).pop(null);
      },
    );
  }
}

class _BookSectionEmptyCard extends StatelessWidget {
  const _BookSectionEmptyCard({
    required this.appColors,
    required this.theme,
    required this.onAddPressed,
  });

  final AppColors appColors;
  final ThemeData theme;
  final VoidCallback onAddPressed;

  static const _iconBackgroundColor = Color(0xFF1E2939);
  static const _accentTeal = Color(0xFF00D5BE);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: appColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: _iconBackgroundColor,
            ),
            child: Icon(
              Icons.add,
              size: 32,
              color: appColors.foregroundMuted,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'このリストに本を追加しましょう',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: appColors.foregroundMuted,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextButton(
            onPressed: onAddPressed,
            child: const Text(
              '本を追加',
              style: TextStyle(color: _accentTeal),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectedBookListTile extends StatelessWidget {
  const _SelectedBookListTile({
    required this.book,
    required this.appColors,
    required this.theme,
    required this.onRemove,
  });

  final ShelfBookItem book;
  final AppColors appColors;
  final ThemeData theme;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: appColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            child: SizedBox(
              width: 36,
              height: 54,
              child: book.hasCoverImage
                  ? CachedNetworkImage(
                      imageUrl: book.coverImageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (_, __) =>
                          ColoredBox(color: appColors.surface),
                      errorWidget: (_, __, ___) =>
                          _CoverPlaceholder(appColors: appColors),
                    )
                  : _CoverPlaceholder(appColors: appColors),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium,
                ),
                Text(
                  book.authorsDisplay,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: appColors.foregroundMuted,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              color: appColors.foregroundMuted,
            ),
            onPressed: onRemove,
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
      color: appColors.foregroundMuted.withOpacity(0.1),
      child: Center(
        child: Icon(
          Icons.book,
          size: 20,
          color: appColors.foregroundMuted,
        ),
      ),
    );
  }
}
