import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/features/account/application/account_notifier.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';
import 'package:shelfie/features/book_detail/application/book_detail_notifier.dart';
import 'package:shelfie/features/book_detail/domain/book_detail.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_share/application/share_card_notifier.dart';
import 'package:shelfie/features/book_share/domain/share_card_level.dart';

void main() {
  const externalId = 'book-123';
  final now = DateTime(2025, 1, 1);
  final completedAt = DateTime(2025, 1, 15);

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

  ShelfEntry createShelfEntry({
    int? rating,
    String? note,
    DateTime? completedAtOverride,
  }) {
    return ShelfEntry(
      userBookId: 1,
      externalId: externalId,
      readingStatus: ReadingStatus.completed,
      addedAt: now,
      completedAt: completedAtOverride ?? completedAt,
      rating: rating,
      note: note,
    );
  }

  UserProfile createUserProfile() {
    return UserProfile(
      id: 1,
      email: 'test@example.com',
      name: 'テストユーザー',
      avatarUrl: 'https://example.com/avatar.jpg',
      username: 'testuser',
      bookCount: 10,
      readingStartYear: 2024,
      readingStartMonth: 1,
      createdAt: now,
    );
  }

  Future<ProviderContainer> createContainer({
    required BookDetail bookDetail,
    required ShelfEntry shelfEntry,
    UserProfile? userProfile,
  }) async {
    final profile = userProfile ?? createUserProfile();
    final container = ProviderContainer(
      overrides: [
        bookDetailNotifierProvider(externalId)
            .overrideWith(() => _FakeBookDetailNotifier(bookDetail)),
        shelfStateProvider.overrideWith(() => _FakeShelfState({
              externalId: shelfEntry,
            })),
        accountNotifierProvider
            .overrideWith(() => _FakeAccountNotifier(profile)),
      ],
    );

    await container.read(bookDetailNotifierProvider(externalId).future);
    await container.read(accountNotifierProvider.future);
    container.read(shareCardNotifierProvider(externalId));

    return container;
  }

  group('ShareCardNotifier', () {
    group('利用可能レベルの判定', () {
      test('rating なし・note なしの場合、simple のみ利用可能', () async {
        final container = await createContainer(
          bookDetail: createBookDetail(),
          shelfEntry: createShelfEntry(),
        );

        final state = container.read(
          shareCardNotifierProvider(externalId),
        );

        expect(state.availableLevels, [ShareCardLevel.simple]);
        container.dispose();
      });

      test('rating ありの場合、simple と profile が利用可能', () async {
        final container = await createContainer(
          bookDetail: createBookDetail(),
          shelfEntry: createShelfEntry(rating: 4),
        );

        final state = container.read(
          shareCardNotifierProvider(externalId),
        );

        expect(state.availableLevels, [
          ShareCardLevel.simple,
          ShareCardLevel.profile,
        ]);
        container.dispose();
      });

      test('rating なし・note ありの場合、simple のみ利用可能', () async {
        final container = await createContainer(
          bookDetail: createBookDetail(),
          shelfEntry: createShelfEntry(note: '良い本でした'),
        );

        final state = container.read(
          shareCardNotifierProvider(externalId),
        );

        expect(state.availableLevels, [ShareCardLevel.simple]);
        container.dispose();
      });

      test('rating あり・note ありの場合、全レベル利用可能', () async {
        final container = await createContainer(
          bookDetail: createBookDetail(),
          shelfEntry: createShelfEntry(rating: 5, note: '素晴らしい本でした'),
        );

        final state = container.read(
          shareCardNotifierProvider(externalId),
        );

        expect(state.availableLevels, [
          ShareCardLevel.simple,
          ShareCardLevel.profile,
          ShareCardLevel.review,
        ]);
        container.dispose();
      });

      test('note が空文字の場合、review は利用不可', () async {
        final container = await createContainer(
          bookDetail: createBookDetail(),
          shelfEntry: createShelfEntry(rating: 4, note: ''),
        );

        final state = container.read(
          shareCardNotifierProvider(externalId),
        );

        expect(state.availableLevels, [
          ShareCardLevel.simple,
          ShareCardLevel.profile,
        ]);
        container.dispose();
      });

      test('note が空白のみの場合、review は利用不可', () async {
        final container = await createContainer(
          bookDetail: createBookDetail(),
          shelfEntry: createShelfEntry(rating: 3, note: '   '),
        );

        final state = container.read(
          shareCardNotifierProvider(externalId),
        );

        expect(state.availableLevels, [
          ShareCardLevel.simple,
          ShareCardLevel.profile,
        ]);
        container.dispose();
      });
    });

    group('デフォルトレベルの選択', () {
      test('デフォルトで simple カードが選択される', () async {
        final container = await createContainer(
          bookDetail: createBookDetail(),
          shelfEntry: createShelfEntry(rating: 5, note: '素晴らしい'),
        );

        final state = container.read(
          shareCardNotifierProvider(externalId),
        );

        expect(state.currentLevel, ShareCardLevel.simple);
        container.dispose();
      });
    });

    group('レベル切り替え', () {
      test('利用可能なレベルへの切り替えが成功する', () async {
        final container = await createContainer(
          bookDetail: createBookDetail(),
          shelfEntry: createShelfEntry(rating: 4, note: '良い本'),
        );

        final notifier = container.read(
          shareCardNotifierProvider(externalId).notifier,
        );

        notifier.changeLevel(ShareCardLevel.profile);

        final state = container.read(
          shareCardNotifierProvider(externalId),
        );
        expect(state.currentLevel, ShareCardLevel.profile);
        container.dispose();
      });

      test('利用不可なレベルへの切り替えが無視される', () async {
        final container = await createContainer(
          bookDetail: createBookDetail(),
          shelfEntry: createShelfEntry(),
        );

        final notifier = container.read(
          shareCardNotifierProvider(externalId).notifier,
        );

        notifier.changeLevel(ShareCardLevel.profile);

        final state = container.read(
          shareCardNotifierProvider(externalId),
        );
        expect(state.currentLevel, ShareCardLevel.simple);
        container.dispose();
      });

      test('review レベルへの切り替えが利用可能な場合に成功する', () async {
        final container = await createContainer(
          bookDetail: createBookDetail(),
          shelfEntry: createShelfEntry(rating: 5, note: '最高の本'),
        );

        final notifier = container.read(
          shareCardNotifierProvider(externalId).notifier,
        );

        notifier.changeLevel(ShareCardLevel.review);

        final state = container.read(
          shareCardNotifierProvider(externalId),
        );
        expect(state.currentLevel, ShareCardLevel.review);
        container.dispose();
      });
    });

    group('カードデータの集約', () {
      test('BookDetail と ShelfEntry からカードデータが正しく集約される',
          () async {
        final container = await createContainer(
          bookDetail: createBookDetail(),
          shelfEntry: createShelfEntry(
            rating: 4,
            note: 'テストメモ',
          ),
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
        expect(state.cardData.rating, 4);
        expect(state.cardData.note, 'テストメモ');
        expect(state.cardData.completedAt, completedAt);
        expect(state.cardData.userName, 'テストユーザー');
        expect(
          state.cardData.avatarUrl,
          'https://example.com/avatar.jpg',
        );
        container.dispose();
      });

      test('表紙画像が null の場合、thumbnailUrl が null になる', () async {
        final container = await createContainer(
          bookDetail: createBookDetail(thumbnailUrl: null),
          shelfEntry: createShelfEntry(),
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

class _FakeShelfState extends ShelfState {
  _FakeShelfState(this._initial);
  final Map<String, ShelfEntry> _initial;

  @override
  Map<String, ShelfEntry> build() {
    return _initial;
  }
}

class _FakeAccountNotifier extends AccountNotifier {
  _FakeAccountNotifier(this._profile);
  final UserProfile _profile;

  @override
  Future<UserProfile> build() async {
    return _profile;
  }
}
