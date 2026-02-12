import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/state/follow_version.dart';
import 'package:shelfie/features/follow/data/follow_repository.dart';
import 'package:shelfie/features/follow/domain/follow_counts.dart';

part 'follow_counts_notifier.g.dart';

@riverpod
class FollowCountsNotifier extends _$FollowCountsNotifier {
  @override
  Future<FollowCounts> build(int userId) async {
    ref.watch(followVersionProvider);

    final repo = ref.read(followRepositoryProvider);
    final result = await repo.getFollowCounts(userId: userId);

    return result.fold(
      (failure) => throw failure,
      (counts) => counts,
    );
  }
}
