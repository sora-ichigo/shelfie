import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/core/state/shelf_version.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_repository.dart';

part 'reading_status_counts_notifier.g.dart';

@riverpod
class ReadingStatusCountsNotifier extends _$ReadingStatusCountsNotifier {
  @override
  Map<ReadingStatus, int> build() {
    ref.watch(shelfVersionProvider);
    Future.microtask(_loadCounts);
    return {};
  }

  Future<void> _loadCounts() async {
    final repository = ref.read(bookShelfRepositoryProvider);

    final statuses = ReadingStatus.values;
    final gStatuses = {
      ReadingStatus.reading: GReadingStatus.READING,
      ReadingStatus.backlog: GReadingStatus.BACKLOG,
      ReadingStatus.completed: GReadingStatus.COMPLETED,
      ReadingStatus.interested: GReadingStatus.INTERESTED,
    };

    final futures = statuses.map((status) async {
      final result = await repository.getMyShelf(
        readingStatus: gStatuses[status],
        limit: 0,
        offset: 0,
      );
      return MapEntry(
        status,
        result.fold((_) => 0, (data) => data.totalCount),
      );
    });

    final entries = await Future.wait(futures);
    state = Map.fromEntries(entries);
  }
}
