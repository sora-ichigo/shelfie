import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/book_detail/application/book_detail_notifier.dart';
import 'package:shelfie/features/book_detail/domain/book_detail.dart';
import 'package:shelfie/features/book_share/application/share_card_notifier.dart';

void main() {
  const externalId = 'book-123';

  BookDetail createBookDetail({
    String? thumbnailUrl = 'https://example.com/cover.jpg',
  }) {
    return BookDetail(
      id: externalId,
      title: 'テスト書籍',
      authors: ['著者A', '著者B'],
      thumbnailUrl: thumbnailUrl,
    );
  }

  Future<ProviderContainer> createContainer({
    required BookDetail bookDetail,
  }) async {
    final container = ProviderContainer(
      overrides: [
        bookDetailNotifierProvider(externalId)
            .overrideWith(() => _FakeBookDetailNotifier(bookDetail)),
      ],
    );

    await container.read(bookDetailNotifierProvider(externalId).future);
    container.read(shareCardNotifierProvider(externalId));

    return container;
  }

  group('ShareCardNotifier', () {
    group('カードデータの集約', () {
      test('BookDetail からカードデータが正しく集約される', () async {
        final container = await createContainer(
          bookDetail: createBookDetail(),
        );

        final state = container.read(
          shareCardNotifierProvider(externalId),
        );

        expect(state.cardData.title, 'テスト書籍');
        expect(state.cardData.authors, ['著者A', '著者B']);
        expect(
          state.cardData.thumbnailUrl,
          'https://example.com/cover.jpg',
        );
        container.dispose();
      });

      test('表紙画像が null の場合、thumbnailUrl が null になる', () async {
        final container = await createContainer(
          bookDetail: createBookDetail(thumbnailUrl: null),
        );

        final state = container.read(
          shareCardNotifierProvider(externalId),
        );

        expect(state.cardData.thumbnailUrl, isNull);
        container.dispose();
      });
    });
  });
}

class _FakeBookDetailNotifier extends BookDetailNotifier {
  _FakeBookDetailNotifier(this._bookDetail);
  final BookDetail _bookDetail;

  @override
  Future<BookDetail?> build(String externalId) async {
    return _bookDetail;
  }
}
