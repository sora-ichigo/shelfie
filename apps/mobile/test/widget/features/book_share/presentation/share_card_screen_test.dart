import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/account/application/account_notifier.dart';
import 'package:shelfie/features/account/domain/user_profile.dart';
import 'package:shelfie/features/book_detail/application/book_detail_notifier.dart';
import 'package:shelfie/features/book_detail/domain/book_detail.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_share/domain/share_card_level.dart';
import 'package:shelfie/features/book_share/presentation/share_card_screen.dart';

void main() {
  const externalId = 'book-123';
  final now = DateTime(2025, 1, 1);
  final completedAt = DateTime(2025, 1, 15);

  BookDetail createBookDetail() {
    return BookDetail(
      id: externalId,
      title: 'テスト書籍',
      authors: ['著者A'],
      thumbnailUrl: 'https://example.com/cover.jpg',
    );
  }

  ShelfEntry createShelfEntry({
    int? rating,
    String? note,
  }) {
    return ShelfEntry(
      userBookId: 1,
      externalId: externalId,
      readingStatus: ReadingStatus.completed,
      addedAt: now,
      completedAt: completedAt,
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

  Widget buildTestWidget({
    required BookDetail bookDetail,
    required ShelfEntry shelfEntry,
    UserProfile? userProfile,
  }) {
    final profile = userProfile ?? createUserProfile();
    return ProviderScope(
      overrides: [
        bookDetailNotifierProvider(externalId)
            .overrideWith(() => _FakeBookDetailNotifier(bookDetail)),
        shelfStateProvider.overrideWith(
          () => _FakeShelfState({externalId: shelfEntry}),
        ),
        accountNotifierProvider
            .overrideWith(() => _FakeAccountNotifier(profile)),
      ],
      child: MaterialApp(
        theme: AppTheme.dark(),
        home: const ShareCardScreen(externalId: externalId),
      ),
    );
  }

  group('ShareCardScreen', () {
    testWidgets('カードプレビューが表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        bookDetail: createBookDetail(),
        shelfEntry: createShelfEntry(rating: 4, note: 'テストメモ'),
      ));
      await tester.pumpAndSettle();

      expect(find.text('テスト書籍'), findsOneWidget);
    });

    testWidgets('シェアボタンと保存ボタンが表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        bookDetail: createBookDetail(),
        shelfEntry: createShelfEntry(rating: 4),
      ));
      await tester.pumpAndSettle();

      expect(find.text('シェア'), findsOneWidget);
      expect(find.text('保存'), findsOneWidget);
    });

    testWidgets('戻るボタンが表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        bookDetail: createBookDetail(),
        shelfEntry: createShelfEntry(),
      ));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('全レベル利用可能時にレベル切り替えUIが表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        bookDetail: createBookDetail(),
        shelfEntry: createShelfEntry(rating: 5, note: 'テストメモ'),
      ));
      await tester.pumpAndSettle();

      for (final level in ShareCardLevel.values) {
        expect(find.text(level.displayName), findsOneWidget);
      }
    });

    testWidgets('simple のみの場合レベル切り替えUIが非表示', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        bookDetail: createBookDetail(),
        shelfEntry: createShelfEntry(),
      ));
      await tester.pumpAndSettle();

      expect(find.byType(SegmentedButton<ShareCardLevel>), findsNothing);
    });

    testWidgets('AppBar にタイトル「シェアカード」が表示される', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        bookDetail: createBookDetail(),
        shelfEntry: createShelfEntry(),
      ));
      await tester.pumpAndSettle();

      expect(find.text('シェアカード'), findsOneWidget);
    });
  });
}

class _FakeBookDetailNotifier extends BookDetailNotifier {
  _FakeBookDetailNotifier(this._bookDetail);
  final BookDetail _bookDetail;

  @override
  Future<BookDetail?> build(String externalId) async => _bookDetail;
}

class _FakeShelfState extends ShelfState {
  _FakeShelfState(this._initial);
  final Map<String, ShelfEntry> _initial;

  @override
  Map<String, ShelfEntry> build() => _initial;
}

class _FakeAccountNotifier extends AccountNotifier {
  _FakeAccountNotifier(this._profile);
  final UserProfile _profile;

  @override
  Future<UserProfile> build() async => _profile;
}
