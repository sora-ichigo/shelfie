import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/features/book_shelf/data/book_shelf_settings_repository.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';

part 'sort_option_notifier.g.dart';

@riverpod
class SortOptionNotifier extends _$SortOptionNotifier {
  @override
  SortOption build() {
    final repo = ref.read(bookShelfSettingsRepositoryProvider);
    return repo.getSortOption();
  }

  Future<void> update(SortOption option) async {
    state = option;
    final repo = ref.read(bookShelfSettingsRepositoryProvider);
    await repo.setSortOption(option);
  }
}
