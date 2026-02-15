import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/graphql/__generated__/schema.schema.gql.dart';
import 'package:shelfie/core/state/shelf_version.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_repository.dart';

part 'reading_status_counts_notifier.g.dart';

@riverpod
class ReadingStatusCountsNotifier extends _$ReadingStatusCountsNotifier {
  Map<ReadingStatus, int>? _cachedCounts;

  @override
  Map<ReadingStatus, int> build() {
    ref.watch(shelfVersionProvider);

    final cached = _cachedCounts;
    if (cached != null) {
      Future.microtask(_loadCounts);
      return cached;
    }

    Future.microtask(_loadCounts);
    return {};
  }

  Future<void> refresh() async {
    await _loadCounts();
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
    final newCounts = Map.fromEntries(entries);
    _cachedCounts = newCounts;
    state = newCounts;
  }
}
