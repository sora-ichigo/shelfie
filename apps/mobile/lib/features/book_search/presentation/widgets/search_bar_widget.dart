import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    required this.onChanged,
    super.key,
    this.controller,
    this.focusNode,
    this.onSubmitted,
    this.showCancelButton = false,
    this.onCancelPressed,
    this.hintText = '書籍を検索...',
  });

  final void Function(String) onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onSubmitted;
  final bool showCancelButton;
  final VoidCallback? onCancelPressed;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColors>()!;
    final borderRadius = BorderRadius.circular(AppSpacing.sm);

    return Container(
      padding: AppSpacing.horizontal(AppSpacing.md),
      child: Row(
        children: [
          Expanded(
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller ?? TextEditingController(),
              builder: (context, value, child) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  onChanged: onChanged,
                  onSubmitted: onSubmitted,
                  textInputAction: TextInputAction.search,
                  cursorColor: appColors.primary,
                  style: TextStyle(color: appColors.textPrimary),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(color: appColors.inactive),
                    prefixIcon: Icon(Icons.search, color: appColors.inactive),
                    suffixIcon: value.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear, color: appColors.inactive),
                            onPressed: () {
                              controller?.clear();
                              onChanged('');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: appColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(color: appColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(color: appColors.primary),
                    ),
                    contentPadding: AppSpacing.vertical(AppSpacing.sm),
                  ),
                );
              },
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: showCancelButton
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: AppSpacing.xs),
                      TextButton(
                        onPressed: onCancelPressed,
                        child: Text(
                          'キャンセル',
                          style: TextStyle(color: appColors.textSecondary),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
