import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/features/account/application/account_notifier.dart';
import 'package:shelfie/features/book_detail/application/book_detail_notifier.dart';
import 'package:shelfie/features/book_share/domain/share_card_data.dart';
import 'package:shelfie/features/book_share/domain/share_card_level.dart';

part 'share_card_notifier.g.dart';

@riverpod
class ShareCardNotifier extends _$ShareCardNotifier {
  @override
  ShareCardState build(String externalId) {
    final bookDetail = ref.watch(
      bookDetailNotifierProvider(externalId).select((s) => s.valueOrNull),
    );
    final shelfEntry = ref.watch(
      shelfStateProvider.select((s) => s[externalId]),
    );
    final userProfile = ref.watch(
      accountNotifierProvider.select((s) => s.valueOrNull),
    );

    final availableLevels = _computeAvailableLevels(
      rating: shelfEntry?.rating,
      note: shelfEntry?.note,
    );

    final cardData = ShareCardData(
      title: bookDetail?.title ?? '',
      authors: bookDetail?.authors ?? [],
      thumbnailUrl: bookDetail?.thumbnailUrl,
      userName: userProfile?.name,
      avatarUrl: userProfile?.avatarUrl,
      rating: shelfEntry?.rating,
      completedAt: shelfEntry?.completedAt,
      note: shelfEntry?.note,
    );

    return ShareCardState(
      currentLevel: ShareCardLevel.simple,
      availableLevels: availableLevels,
      cardData: cardData,
    );
  }

  void changeLevel(ShareCardLevel level) {
    if (!state.availableLevels.contains(level)) return;
    state = state.copyWith(currentLevel: level);
  }

  static List<ShareCardLevel> _computeAvailableLevels({
    int? rating,
    String? note,
  }) {
    final levels = [ShareCardLevel.simple];
    if (rating != null) {
      levels.add(ShareCardLevel.profile);
    }
    if (rating != null && note != null && note.trim().isNotEmpty) {
      levels.add(ShareCardLevel.review);
    }
    return levels;
  }
}

@immutable
class ShareCardState {
  const ShareCardState({
    required this.currentLevel,
    required this.availableLevels,
    required this.cardData,
  });

  final ShareCardLevel currentLevel;
  final List<ShareCardLevel> availableLevels;
  final ShareCardData cardData;

  ShareCardState copyWith({
    ShareCardLevel? currentLevel,
    List<ShareCardLevel>? availableLevels,
    ShareCardData? cardData,
  }) {
    return ShareCardState(
      currentLevel: currentLevel ?? this.currentLevel,
      availableLevels: availableLevels ?? this.availableLevels,
      cardData: cardData ?? this.cardData,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ShareCardState) return false;
    return currentLevel == other.currentLevel &&
        _listEquals(availableLevels, other.availableLevels) &&
        cardData == other.cardData;
  }

  @override
  int get hashCode => Object.hash(
        currentLevel,
        Object.hashAll(availableLevels),
        cardData,
      );

  static bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
