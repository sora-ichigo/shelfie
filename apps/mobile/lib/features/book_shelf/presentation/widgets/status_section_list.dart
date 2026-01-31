import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_shelf/application/status_section_notifier.dart';
import 'package:shelfie/features/book_shelf/application/status_section_state.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/status_section.dart';

/// 読書状態ごとのセクションを固定順で表示するリスト
///
/// 表示順: 読書中 → 積読 → 読了 → 読まない
/// 空のセクションは非表示にする
class StatusSectionList extends ConsumerWidget {
  const StatusSectionList({
    required this.onBookTap,
    required this.onBookLongPress,
    super.key,
  });

  final void Function(ShelfBookItem) onBookTap;
  final void Function(ShelfBookItem) onBookLongPress;

  /// セクションの表示順（固定）
  static const _sectionOrder = [
    ReadingStatus.reading,
    ReadingStatus.backlog,
    ReadingStatus.completed,
    ReadingStatus.dropped,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visibleSections = _sectionOrder.where((status) {
      final state = ref.watch(statusSectionNotifierProvider(status));
      return _isSectionVisible(state);
    }).toList();

    final bottomInset = MediaQuery.of(context).padding.bottom +
        kBottomNavigationBarHeight;

    return CustomScrollView(
      slivers: [
        for (final status in visibleSections)
          StatusSection(
            key: ValueKey(status),
            status: status,
            onBookTap: onBookTap,
            onBookLongPress: onBookLongPress,
          ),
        SliverToBoxAdapter(
          child: SizedBox(height: bottomInset),
        ),
      ],
    );
  }

  bool _isSectionVisible(StatusSectionState state) {
    return switch (state) {
      StatusSectionLoaded(:final totalCount) => totalCount > 0,
      StatusSectionLoading() => true,
      StatusSectionError() => true,
      StatusSectionInitial() => true,
    };
  }
}
