import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/widgets/empty_state.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_shelf/application/status_section_notifier.dart';
import 'package:shelfie/features/book_shelf/application/status_section_state.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/status_section.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/status_section_list.dart';

import '../../../../helpers/test_helpers.dart';

class _TestStatusSectionNotifier extends StatusSectionNotifier {
  _TestStatusSectionNotifier(this._initialState);

  final StatusSectionState _initialState;

  @override
  StatusSectionState build(ReadingStatus status) => _initialState;

  @override
  Future<void> initialize() async {}

  @override
  Future<void> loadMore() async {}

  @override
  Future<void> refresh() async {}

  @override
  void removeBook(String externalId) {}

  @override
  Future<void> retry() async {}
}

const _emptyLoaded = StatusSectionState.loaded(
  books: [],
  totalCount: 0,
  hasMore: false,
  isLoadingMore: false,
);

ShelfBookItem _createBook(int id) {
  return ShelfBookItem(
    userBookId: id,
    externalId: 'book-$id',
    title: 'Book $id',
    authors: ['Author $id'],
    addedAt: DateTime(2025, 1, 1),
  );
}

StatusSectionState _loadedState({
  int count = 3,
  int totalCount = 3,
  bool hasMore = false,
}) {
  return StatusSectionState.loaded(
    books: List.generate(count, (i) => _createBook(i + 1)),
    totalCount: totalCount,
    hasMore: hasMore,
    isLoadingMore: false,
  );
}

Widget _buildTestWidget({
  required Map<ReadingStatus, StatusSectionState> states,
  void Function(ShelfBookItem)? onBookTap,
  void Function(ShelfBookItem)? onBookLongPress,
  VoidCallback? onAddBookPressed,
}) {
  final overrides = <Override>[];

  for (final status in ReadingStatus.values) {
    final state = states[status] ?? _emptyLoaded;
    overrides.add(
      statusSectionNotifierProvider(status).overrideWith(
        () => _TestStatusSectionNotifier(state),
      ),
    );
  }

  return buildTestWidget(
    overrides: overrides,
    child: StatusSectionList(
      onBookTap: onBookTap ?? (_) {},
      onBookLongPress: onBookLongPress ?? (_) {},
      onAddBookPressed: onAddBookPressed,
    ),
  );
}

void main() {
  group('StatusSectionList', () {
    group('表示順', () {
      testWidgets('先頭2セクションが読書中→気になるの順で表示される', (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(
            states: {
              ReadingStatus.reading: _loadedState(count: 1, totalCount: 1),
              ReadingStatus.backlog: _loadedState(count: 1, totalCount: 1),
              ReadingStatus.completed: _loadedState(count: 1, totalCount: 1),
              ReadingStatus.interested: _loadedState(count: 1, totalCount: 1),
            },
          ),
        );
        await tester.pumpAndSettle();

        // viewport内で確認可能な先頭セクションの順序を検証
        expect(find.text('読書中'), findsOneWidget);
        expect(find.text('気になる'), findsOneWidget);

        // 読書中が気になるより上に表示されることを確認
        final readingOffset = tester.getTopLeft(find.text('読書中'));
        final interestedOffset = tester.getTopLeft(find.text('気になる'));
        expect(readingOffset.dy, lessThan(interestedOffset.dy));
      });

      testWidgets('一部のセクションのみ存在する場合も順序が保持される', (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(
            states: {
              ReadingStatus.completed: _loadedState(count: 1, totalCount: 1),
              ReadingStatus.reading: _loadedState(count: 1, totalCount: 1),
            },
          ),
        );
        await tester.pumpAndSettle();

        final sections = tester.widgetList<StatusSection>(
          find.byType(StatusSection),
        );
        final statusOrder = sections.map((s) => s.status).toList();

        expect(statusOrder, [
          ReadingStatus.reading,
          ReadingStatus.completed,
        ]);
      });

      testWidgets('読書中のセクションは積読の前に表示される（completedなし）',
          (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(
            states: {
              ReadingStatus.backlog: _loadedState(count: 1, totalCount: 1),
              ReadingStatus.reading: _loadedState(count: 1, totalCount: 1),
            },
          ),
        );
        await tester.pumpAndSettle();

        final sections = tester.widgetList<StatusSection>(
          find.byType(StatusSection),
        );
        final statusOrder = sections.map((s) => s.status).toList();

        expect(statusOrder, [
          ReadingStatus.reading,
          ReadingStatus.backlog,
        ]);
      });
    });

    group('空セクション非表示', () {
      testWidgets('totalCount が 0 の loaded セクションは表示されない',
          (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(
            states: {
              ReadingStatus.reading: _loadedState(count: 1, totalCount: 1),
              ReadingStatus.backlog: _emptyLoaded,
              ReadingStatus.completed: _loadedState(count: 1, totalCount: 1),
            },
          ),
        );
        await tester.pumpAndSettle();

        final sections = tester.widgetList<StatusSection>(
          find.byType(StatusSection),
        );
        final statusOrder = sections.map((s) => s.status).toList();

        expect(statusOrder, [
          ReadingStatus.reading,
          ReadingStatus.completed,
        ]);
        expect(statusOrder, isNot(contains(ReadingStatus.backlog)));
      });

      testWidgets('loading 状態のセクションは表示される', (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(
            states: {
              ReadingStatus.reading: const StatusSectionState.loading(),
              ReadingStatus.backlog: _loadedState(count: 1, totalCount: 1),
            },
          ),
        );
        await tester.pump();

        final sections = tester.widgetList<StatusSection>(
          find.byType(StatusSection),
        );
        expect(sections.length, 2);
      });

      testWidgets('error 状態のセクションは表示される', (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(
            states: {
              ReadingStatus.reading: const StatusSectionState.error(
                failure: ServerFailure(
                  message: 'エラー',
                  code: 'SERVER_ERROR',
                ),
              ),
              ReadingStatus.backlog: _loadedState(count: 1, totalCount: 1),
            },
          ),
        );
        await tester.pumpAndSettle();

        final sections = tester.widgetList<StatusSection>(
          find.byType(StatusSection),
        );
        expect(sections.length, 2);
      });
    });

    group('ヘッダー表示', () {
      testWidgets('セクションヘッダーにステータス名と件数が表示される', (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(
            states: {
              ReadingStatus.reading: _loadedState(count: 3, totalCount: 5),
            },
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('読書中'), findsOneWidget);
        expect(find.text('5'), findsOneWidget);
      });

      testWidgets('2セクションのヘッダーがそれぞれ正しく表示される', (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(
            states: {
              ReadingStatus.reading: _loadedState(count: 1, totalCount: 1),
              ReadingStatus.backlog: _loadedState(count: 1, totalCount: 2),
            },
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('読書中'), findsOneWidget);
        expect(find.text('積読'), findsOneWidget);
        expect(find.text('1'), findsOneWidget);
        expect(find.text('2'), findsOneWidget);
      });
    });

    group('エラーリトライ', () {
      testWidgets('エラー状態で再試行ボタンとエラーメッセージが表示される', (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(
            states: {
              ReadingStatus.reading: const StatusSectionState.error(
                failure: NetworkFailure(message: 'ネットワークエラー'),
              ),
            },
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('再試行'), findsOneWidget);
        expect(find.text('ネットワーク接続を確認してください'), findsOneWidget);
      });
    });

    group('空状態表示', () {
      testWidgets('全セクションが空の場合 EmptyState が表示される', (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(
            states: {
              ReadingStatus.reading: _emptyLoaded,
              ReadingStatus.backlog: _emptyLoaded,
              ReadingStatus.completed: _emptyLoaded,
              ReadingStatus.dropped: _emptyLoaded,
            },
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(EmptyState), findsOneWidget);
        expect(find.byIcon(Icons.auto_stories_outlined), findsOneWidget);
        expect(find.text('本を追加してみましょう'), findsOneWidget);
      });

      testWidgets('全セクションが空の場合「本を追加」ボタンが表示される',
          (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(
            states: {
              ReadingStatus.reading: _emptyLoaded,
              ReadingStatus.backlog: _emptyLoaded,
              ReadingStatus.completed: _emptyLoaded,
              ReadingStatus.dropped: _emptyLoaded,
            },
            onAddBookPressed: () {},
          ),
        );
        await tester.pumpAndSettle();

        expect(
          find.widgetWithText(ElevatedButton, '本を追加'),
          findsOneWidget,
        );
      });

      testWidgets('「本を追加」ボタンをタップすると onAddBookPressed が呼ばれる',
          (tester) async {
        var called = false;
        await tester.pumpWidget(
          _buildTestWidget(
            states: {
              ReadingStatus.reading: _emptyLoaded,
              ReadingStatus.backlog: _emptyLoaded,
              ReadingStatus.completed: _emptyLoaded,
              ReadingStatus.dropped: _emptyLoaded,
            },
            onAddBookPressed: () {
              called = true;
            },
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.widgetWithText(ElevatedButton, '本を追加'));
        await tester.pumpAndSettle();

        expect(called, isTrue);
      });

      testWidgets('一部セクションにデータがある場合は EmptyState を表示しない',
          (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(
            states: {
              ReadingStatus.reading: _loadedState(count: 1, totalCount: 1),
              ReadingStatus.backlog: _emptyLoaded,
              ReadingStatus.completed: _emptyLoaded,
              ReadingStatus.dropped: _emptyLoaded,
            },
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(EmptyState), findsNothing);
        expect(find.byType(StatusSection), findsOneWidget);
      });
    });

    group('セクション独立性', () {
      testWidgets('あるセクションがエラーでも他のセクションは正常に表示される',
          (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(
            states: {
              ReadingStatus.reading: _loadedState(count: 1, totalCount: 1),
              ReadingStatus.backlog: const StatusSectionState.error(
                failure: ServerFailure(
                  message: 'サーバーエラー',
                  code: 'SERVER_ERROR',
                ),
              ),
            },
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('読書中'), findsOneWidget);
        expect(find.text('サーバーエラーが発生しました'), findsOneWidget);
        expect(find.text('再試行'), findsOneWidget);
      });

      testWidgets('あるセクションがloading中でも他のセクションは表示される',
          (tester) async {
        await tester.pumpWidget(
          _buildTestWidget(
            states: {
              ReadingStatus.reading: const StatusSectionState.loading(),
              ReadingStatus.completed: _loadedState(count: 1, totalCount: 1),
            },
          ),
        );
        await tester.pump();

        final sections = tester.widgetList<StatusSection>(
          find.byType(StatusSection),
        );
        expect(sections.length, 2);
      });
    });
  });
}
