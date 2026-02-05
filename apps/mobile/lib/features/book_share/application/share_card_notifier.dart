import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shelfie/features/book_detail/application/book_detail_notifier.dart';
import 'package:shelfie/features/book_share/domain/share_card_data.dart';

part 'share_card_notifier.g.dart';

@riverpod
class ShareCardNotifier extends _$ShareCardNotifier {
  @override
  ShareCardState build(String externalId) {
    final bookDetail = ref.watch(
      bookDetailNotifierProvider(externalId).select((s) => s.valueOrNull),
    );

    final cardData = ShareCardData(
      title: bookDetail?.title ?? '',
      authors: bookDetail?.authors ?? [],
      thumbnailUrl: bookDetail?.thumbnailUrl,
    );

    return ShareCardState(cardData: cardData);
  }
}

@immutable
class ShareCardState {
  const ShareCardState({required this.cardData});

  final ShareCardData cardData;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ShareCardState) return false;
    return cardData == other.cardData;
  }

  @override
  int get hashCode => cardData.hashCode;
}
