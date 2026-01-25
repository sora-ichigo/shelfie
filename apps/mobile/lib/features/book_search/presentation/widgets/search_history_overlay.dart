import 'package:flutter/material.dart';
import 'package:shelfie/core/theme/app_spacing.dart';
import 'package:shelfie/features/book_search/domain/search_history_entry.dart';

/// 検索履歴候補をオーバーレイとして表示する UI コンポーネント
///
/// 検索フィールドの下にオーバーレイとして履歴候補を表示する。
/// 履歴が空の場合は何も表示しない。
/// 左スワイプで個別削除、「すべて削除」で全削除が可能。
class SearchHistoryOverlay extends StatelessWidget {
  const SearchHistoryOverlay({
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '検索履歴',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
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
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
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
                child: _SearchHistoryItem(
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

class _SearchHistoryItem extends StatelessWidget {
  const _SearchHistoryItem({
    required this.entry,
    required this.onTap,
  });

  final SearchHistoryEntry entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Icon(
        Icons.history,
        size: 20,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
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
