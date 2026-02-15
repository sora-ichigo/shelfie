import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_colors.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    required this.onChanged,
    required this.onScanPressed,
    super.key,
    this.controller,
    this.focusNode,
    this.onSubmitted,
    this.showCancelButton = false,
    this.onCancelPressed,
    this.hintText = '書籍を検索...',
  });

  final void Function(String) onChanged;
  final VoidCallback onScanPressed;
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
                  cursorColor: appColors.primaryLegacy,
                  style: TextStyle(color: appColors.textPrimaryLegacy),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(color: appColors.inactiveLegacy),
                    prefixIcon: Icon(Icons.search, color: appColors.inactiveLegacy),
                    suffixIcon: value.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear, color: appColors.inactiveLegacy),
                            onPressed: () {
                              controller?.clear();
                              onChanged('');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: appColors.surfaceLegacy,
                    border: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(color: appColors.borderLegacy),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(color: appColors.primaryLegacy),
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
                          style: TextStyle(color: appColors.textSecondaryLegacy),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: AppSpacing.xs),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: onScanPressed,
                          borderRadius: borderRadius,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: AppSpacing.xs,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.camera_alt_outlined, color: appColors.textPrimaryLegacy),
                                Text(
                                  'バーコード',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: appColors.textSecondaryLegacy,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
