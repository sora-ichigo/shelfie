import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_spacing.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    required this.onChanged,
    required this.onScanPressed,
    super.key,
    this.controller,
    this.focusNode,
  });

  final void Function(String) onChanged;
  final VoidCallback onScanPressed;
  final TextEditingController? controller;
  final FocusNode? focusNode;

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
                  decoration: InputDecoration(
                    hintText: '書籍を検索...',
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
          const SizedBox(width: AppSpacing.xs),
          IconButton(
            onPressed: onScanPressed,
            icon: const Icon(Icons.qr_code_scanner),
            tooltip: 'ISBNスキャン',
          ),
        ],
      ),
    );
  }
}
