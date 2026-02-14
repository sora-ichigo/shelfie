import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';

part 'user_profile_sort_option_notifier.g.dart';

@riverpod
class UserProfileSortOptionNotifier extends _$UserProfileSortOptionNotifier {
  @override
  SortOption build(int userId) {
    return SortOption.addedAtDesc;
  }

  // ignore: use_setters_to_change_properties
  void update(SortOption option) {
    state = option;
  }
}
