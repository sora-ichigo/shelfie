import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/book_list/data/book_list_repository.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';

class BookListEditScreen extends ConsumerStatefulWidget {
  const BookListEditScreen({
    this.existingList,
    super.key,
  });

  final BookList? existingList;

  bool get isEditing => existingList != null;

  @override
  ConsumerState<BookListEditScreen> createState() => _BookListEditScreenState();
}

class _BookListEditScreenState extends ConsumerState<BookListEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  bool _isSaving = false;
  String? _titleError;

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.isEditing ? 'リスト編集' : '新規リスト'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: AppSpacing.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTitleField(theme, appColors),
              const SizedBox(height: AppSpacing.md),
              _buildDescriptionField(theme, appColors),
              const SizedBox(height: AppSpacing.xl),
              _buildSaveButton(theme),
              if (widget.isEditing) ...[
                const SizedBox(height: AppSpacing.md),
                _buildDeleteButton(theme, appColors),
              ],
            ],
          ),
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

  Widget _buildSaveButton(ThemeData theme) {
    return ElevatedButton(
      onPressed: _canSave ? _onSave : null,
      child: _isSaving
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Text('保存'),
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

    final result = widget.isEditing
        ? await repository.updateBookList(
            listId: widget.existingList!.id,
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
    final result = await repository.deleteBookList(
      listId: widget.existingList!.id,
    );

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
