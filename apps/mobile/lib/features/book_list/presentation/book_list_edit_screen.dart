import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/edit_screen_header.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/features/book_list/application/book_list_notifier.dart';
import 'package:shelfie/features/book_list/application/book_list_state.dart';
import 'package:shelfie/features/book_list/data/book_list_repository.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';

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
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  bool _isSaving = false;
  String? _titleError;
  BookList? _loadedList;

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
  }

  void _loadListData() {
    ref.read(bookListDetailNotifierProvider(widget.listId!).notifier).loadDetail();
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
      final detailState = ref.watch(bookListDetailNotifierProvider(widget.listId!));

      return switch (detailState) {
        BookListDetailInitial() || BookListDetailLoading() => _buildLoadingScreen(),
        BookListDetailLoaded(:final list) => _buildEditForm(theme, appColors, list),
        BookListDetailError(:final failure) => _buildErrorScreen(failure.userMessage),
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

  Widget _buildEditForm(ThemeData theme, AppColors appColors, BookListDetail? loadedDetail) {
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
                          _buildTitleField(theme, appColors),
                          const SizedBox(height: AppSpacing.md),
                          _buildDescriptionField(theme, appColors),
                          if (widget.isEditing) ...[
                            const SizedBox(height: AppSpacing.xl),
                            _buildDeleteButton(theme, appColors),
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

  Widget _buildTitleField(ThemeData theme, AppColors appColors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'タイトル',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextFormField(
          key: const Key('title_field'),
          controller: _titleController,
          decoration: InputDecoration(
            hintText: 'リストのタイトルを入力',
            errorText: _titleError,
          ),
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }

  Widget _buildDescriptionField(ThemeData theme, AppColors appColors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '説明（任意）',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextFormField(
          key: const Key('description_field'),
          controller: _descriptionController,
          decoration: const InputDecoration(
            hintText: 'リストの説明を入力',
          ),
          maxLines: 3,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }

  Widget _buildDeleteButton(ThemeData theme, AppColors appColors) {
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

    result.fold(
      (failure) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.userMessage)),
        );
      },
      (bookList) {
        Navigator.of(context).pop(bookList);
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
