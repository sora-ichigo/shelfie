import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/core/state/book_list_version.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/core/widgets/app_snack_bar.dart';
import 'package:shelfie/core/widgets/edit_screen_header.dart';
import 'package:shelfie/core/widgets/form_fields.dart';
import 'package:shelfie/core/widgets/loading_indicator.dart';
import 'package:shelfie/features/book_list/application/book_list_notifier.dart';
import 'package:shelfie/features/book_list/application/book_list_state.dart';
import 'package:shelfie/features/book_list/data/book_list_repository.dart';
import 'package:shelfie/features/book_list/domain/book_list.dart';

class BookListEditScreen extends ConsumerStatefulWidget {
  const BookListEditScreen({required this.listId, super.key});

  final int listId;

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

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _titleController.addListener(_onTitleChanged);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _loadListData();
    });
  }

  void _loadListData() {
    ref.read(bookListDetailNotifierProvider(widget.listId).notifier).loadDetail();
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
    final detailState = ref.watch(bookListDetailNotifierProvider(widget.listId));

    return switch (detailState) {
      BookListDetailInitial() || BookListDetailLoading() => _buildLoadingScreen(),
      BookListDetailLoaded(:final list) => _buildEditForm(theme, appColors, list),
      BookListDetailError(:final failure) => _buildErrorScreen(failure.userMessage),
    };
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

  Widget _buildEditForm(ThemeData theme, AppColors appColors, BookListDetail loadedDetail) {
    if (_loadedList == null) {
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
                  title: 'リスト編集',
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
                          _buildTitleField(),
                          const SizedBox(height: AppSpacing.md),
                          _buildDescriptionField(),
                          const SizedBox(height: AppSpacing.xl),
                          _buildDeleteButton(appColors),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (_isSaving)
              ColoredBox(
                color: appColors.overlayLegacy.withOpacity(0.3),
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

  Widget _buildDeleteButton(AppColors appColors) {
    return TextButton(
      onPressed: _isSaving ? null : _onDelete,
      child: Text(
        'リストを削除',
        style: TextStyle(color: appColors.destructiveLegacy),
      ),
    );
  }

  Future<void> _onSave() async {
    if (!_canSave) return;

    setState(() => _isSaving = true);

    final repository = ref.read(bookListRepositoryProvider);
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    final result = await repository.updateBookList(
      listId: widget.listId,
      title: title,
      description: description.isEmpty ? null : description,
    );

    if (!mounted) return;

    await result.fold(
      (failure) async {
        setState(() => _isSaving = false);
        AppSnackBar.show(context, message: failure.userMessage, type: AppSnackBarType.error);
      },
      (bookList) async {
        if (mounted) {
          ref.read(bookListVersionProvider.notifier).increment();
          if (mounted) {
            Navigator.of(context).pop(bookList);
          }
        }
      },
    );
  }

  Future<void> _onDelete() async {
    final dialogResult = await showOkCancelAlertDialog(
      context: context,
      title: 'リストを削除',
      message: 'このリストを削除しますか？この操作は取り消せません。',
      okLabel: '削除',
      cancelLabel: 'キャンセル',
      isDestructiveAction: true,
    );

    if (dialogResult != OkCancelResult.ok || !mounted) return;

    setState(() => _isSaving = true);

    final repository = ref.read(bookListRepositoryProvider);
    final result = await repository.deleteBookList(listId: widget.listId);

    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() => _isSaving = false);
        AppSnackBar.show(
          context,
          message: failure.userMessage,
          type: AppSnackBarType.error,
        );
      },
      (_) {
        ref.read(bookListVersionProvider.notifier).increment();
        Navigator.of(context).pop(null);
      },
    );
  }
}
