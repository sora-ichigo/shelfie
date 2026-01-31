import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/book_search/domain/search_history_entry.dart';

class SearchHistorySection extends StatelessWidget {
  const SearchHistorySection({
    required this.entries,
    required this.onHistorySelected,
    required this.onHistoryDeleted,
    required this.onClearAll,
    super.key,
  });

  final List<SearchHistoryEntry> entries;
  final void Function(String query) onHistorySelected;
  final void Function(String query) onHistoryDeleted;
  final VoidCallback onClearAll;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.md,
            right: AppSpacing.md,
            top: AppSpacing.sm,
            bottom: AppSpacing.xs,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.history,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    '最近の検索',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              TextButton(
                onPressed: onClearAll,
                child: Text(
                  'すべて削除',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom +
                  kBottomNavigationBarHeight,
            ),
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              return Dismissible(
                key: Key(entry.query),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: AppSpacing.md),
                  color: Theme.of(context).colorScheme.error,
                  child: Icon(
                    Icons.delete_outline,
                    color: Theme.of(context).colorScheme.onError,
                  ),
                ),
                onDismissed: (_) => onHistoryDeleted(entry.query),
                child: _SearchHistoryListItem(
                  entry: entry,
                  onTap: () => onHistorySelected(entry.query),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SearchHistoryListItem extends StatelessWidget {
  const _SearchHistoryListItem({
    required this.entry,
    required this.onTap,
  });

  final SearchHistoryEntry entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
      ),
      title: Text(
        entry.query,
        style: Theme.of(context).textTheme.bodyMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onTap,
    );
  }
}
