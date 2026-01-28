import 'package:flutter/material.dart';
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
                  decoration: InputDecoration(
                    hintText: hintText,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: value.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              controller?.clear();
                              onChanged('');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: theme.colorScheme.surfaceContainerHighest,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.sm),
                      borderSide: BorderSide.none,
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
                          style: TextStyle(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
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
                          borderRadius: BorderRadius.circular(AppSpacing.sm),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: AppSpacing.xs,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.camera_alt_outlined),
                                Text(
                                  'バーコード',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
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
