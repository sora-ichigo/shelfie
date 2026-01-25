import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/presentation/widgets/book_card.dart';

class MockShelfState extends Notifier<Map<String, ShelfEntry>>
    with Mock
    implements ShelfState {
  MockShelfState(this._initialState);

  final Map<String, ShelfEntry> _initialState;

  @override
  Map<String, ShelfEntry> build() => _initialState;
}

void main() {
  Widget buildBookCard({
    required ShelfBookItem book,
    VoidCallback? onTap,
    int? rating,
  }) {
    final shelfState = <String, ShelfEntry>{
      book.externalId: ShelfEntry(
        userBookId: book.userBookId,
        externalId: book.externalId,
        readingStatus: ReadingStatus.backlog,
        addedAt: book.addedAt,
        rating: rating,
      ),
    };

    return ProviderScope(
      overrides: [
        shelfStateProvider.overrideWith(() => MockShelfState(shelfState)),
      ],
      child: MaterialApp(
        theme: AppTheme.dark(),
        home: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              width: 120,
              child: BookCard(
                book: book,
                onTap: onTap ?? () {},
              ),
            ),
          ),
        ),
      ),
    );
  }

  ShelfBookItem createTestBook({
    String title = 'テスト本のタイトル',
    List<String> authors = const ['著者A', '著者B'],
    String? coverImageUrl,
  }) {
    return ShelfBookItem(
      userBookId: 1,
      externalId: 'ext-1',
      title: title,
      authors: authors,
      addedAt: DateTime(2024, 1, 1),
      coverImageUrl: coverImageUrl,
    );
  }

  group('BookCard', () {
    group('カバー画像', () {
      testWidgets('カバー画像URLが設定されている場合はCachedNetworkImageが使用される',
          (tester) async {
        await tester.pumpWidget(
          buildBookCard(
            book: createTestBook(
              coverImageUrl: 'https://example.com/cover.jpg',
            ),
          ),
        );

        expect(find.byType(CachedNetworkImage), findsOneWidget);
      });

      testWidgets('画像がない場合はプレースホルダーアイコンが表示される', (tester) async {
        await tester.pumpWidget(
          buildBookCard(book: createTestBook()),
        );

        expect(find.byIcon(Icons.book), findsOneWidget);
      });
    });

    group('星評価', () {
      testWidgets('評価が設定されている場合は星が表示される', (tester) async {
        await tester.pumpWidget(
          buildBookCard(book: createTestBook(), rating: 3),
        );

        final filledStars = find.byIcon(Icons.star);
        final emptyStars = find.byIcon(Icons.star_border);

        expect(filledStars, findsNWidgets(3));
        expect(emptyStars, findsNWidgets(2));
      });

      testWidgets('評価が5の場合は全て塗りつぶし星が表示される', (tester) async {
        await tester.pumpWidget(
          buildBookCard(book: createTestBook(), rating: 5),
        );

        expect(find.byIcon(Icons.star), findsNWidgets(5));
        expect(find.byIcon(Icons.star_border), findsNothing);
      });

      testWidgets('評価が設定されていない場合は星エリアが空', (tester) async {
        await tester.pumpWidget(
          buildBookCard(book: createTestBook(), rating: null),
        );

        expect(find.byIcon(Icons.star), findsNothing);
        expect(find.byIcon(Icons.star_border), findsNothing);
      });
    });

    group('タイトル表示', () {
      testWidgets('タイトルが表示される', (tester) async {
        await tester.pumpWidget(
          buildBookCard(book: createTestBook(title: '短いタイトル')),
        );

        expect(find.text('短いタイトル'), findsOneWidget);
      });

      testWidgets('タイトルは最大2行で省略される', (tester) async {
        await tester.pumpWidget(
          buildBookCard(
            book: createTestBook(
              title: 'これは非常に長いタイトルで、2行を超えると省略記号で切り詰められます',
            ),
          ),
        );

        final titleFinder = find.byWidgetPredicate((widget) {
          if (widget is Text) {
            return widget.maxLines == 2 &&
                widget.overflow == TextOverflow.ellipsis;
          }
          return false;
        });

        expect(titleFinder, findsOneWidget);
      });
    });

    group('著者名表示', () {
      testWidgets('著者名が表示される', (tester) async {
        await tester.pumpWidget(
          buildBookCard(book: createTestBook(authors: ['著者名'])),
        );

        expect(find.text('著者名'), findsOneWidget);
      });

      testWidgets('複数著者はカンマ区切りで表示される', (tester) async {
        await tester.pumpWidget(
          buildBookCard(book: createTestBook(authors: ['著者A', '著者B'])),
        );

        expect(find.text('著者A, 著者B'), findsOneWidget);
      });

      testWidgets('著者名は最大1行で省略される', (tester) async {
        await tester.pumpWidget(
          buildBookCard(
            book: createTestBook(
              authors: ['非常に長い著者名で1行を超えると省略されます'],
            ),
          ),
        );

        final authorFinder = find.byWidgetPredicate((widget) {
          if (widget is Text && (widget.data?.contains('非常に長い') ?? false)) {
            return widget.maxLines == 1 &&
                widget.overflow == TextOverflow.ellipsis;
          }
          return false;
        });

        expect(authorFinder, findsOneWidget);
      });

      testWidgets('著者がいない場合は空文字が表示される', (tester) async {
        await tester.pumpWidget(
          buildBookCard(book: createTestBook(authors: [])),
        );

        final emptyAuthorFinder = find.byWidgetPredicate((widget) {
          if (widget is Text) {
            return widget.data?.isEmpty ?? false;
          }
          return false;
        });

        expect(emptyAuthorFinder, findsOneWidget);
      });
    });

    group('タップ操作', () {
      testWidgets('タップ時にコールバックが呼ばれる', (tester) async {
        var tapped = false;

        await tester.pumpWidget(
          buildBookCard(
            book: createTestBook(),
            onTap: () => tapped = true,
          ),
        );

        await tester.tap(find.byType(BookCard));
        await tester.pump();

        expect(tapped, isTrue);
      });

      testWidgets('タップ可能である', (tester) async {
        await tester.pumpWidget(
          buildBookCard(book: createTestBook()),
        );

        expect(find.byType(GestureDetector), findsOneWidget);
      });
    });

    group('ダークテーマ', () {
      testWidgets('ダークテーマに準拠したデザインで表示される', (tester) async {
        await tester.pumpWidget(
          buildBookCard(book: createTestBook()),
        );

        final context = tester.element(find.byType(BookCard));
        final theme = Theme.of(context);

        expect(theme.brightness, equals(Brightness.dark));
      });

      testWidgets('画像に角丸が適用されている', (tester) async {
        await tester.pumpWidget(
          buildBookCard(book: createTestBook()),
        );

        expect(find.byType(ClipRRect), findsOneWidget);
      });
    });
  });
}
