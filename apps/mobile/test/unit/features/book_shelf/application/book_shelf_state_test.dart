import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_shelf/application/book_shelf_state.dart';
import 'package:shelfie/features/book_shelf/domain/group_option.dart';
import 'package:shelfie/features/book_shelf/domain/shelf_book_item.dart';
import 'package:shelfie/features/book_shelf/domain/sort_option.dart';

void main() {
  final now = DateTime(2024, 1, 15, 10, 30);

  ShelfBookItem createBook({
    int userBookId = 1,
    String externalId = 'id',
    String title = 'Title',
    List<String> authors = const ['Author'],
    ReadingStatus readingStatus = ReadingStatus.backlog,
    DateTime? addedAt,
  }) {
    return ShelfBookItem(
      userBookId: userBookId,
      externalId: externalId,
      title: title,
      authors: authors,
      readingStatus: readingStatus,
      addedAt: addedAt ?? now,
    );
  }

  group('BookShelfState', () {
    group('initial', () {
      test('should create initial state', () {
        const state = BookShelfState.initial();

        expect(state, isA<BookShelfInitial>());
      });
    });

    group('loading', () {
      test('should create loading state', () {
        const state = BookShelfState.loading();

        expect(state, isA<BookShelfLoading>());
      });
    });

    group('loaded', () {
      test('should create loaded state with required fields', () {
        final books = [createBook()];
        final state = BookShelfState.loaded(
          books: books,
          searchQuery: '',
          sortOption: SortOption.addedAtDesc,
          groupOption: GroupOption.none,
          groupedBooks: const {},
          hasMore: true,
          isLoadingMore: false,
          totalCount: 1,
        );

        expect(state, isA<BookShelfLoaded>());
        final loaded = state as BookShelfLoaded;
        expect(loaded.books, books);
        expect(loaded.searchQuery, '');
        expect(loaded.sortOption, SortOption.addedAtDesc);
        expect(loaded.groupOption, GroupOption.none);
        expect(loaded.groupedBooks, isEmpty);
        expect(loaded.hasMore, isTrue);
        expect(loaded.isLoadingMore, isFalse);
        expect(loaded.totalCount, 1);
      });

      test('should create loaded state with grouped books', () {
        final book1 = createBook(
          userBookId: 1,
          externalId: 'id1',
          readingStatus: ReadingStatus.reading,
        );
        final book2 = createBook(
          userBookId: 2,
          externalId: 'id2',
          readingStatus: ReadingStatus.completed,
        );

        final state = BookShelfState.loaded(
          books: [book1, book2],
          searchQuery: '',
          sortOption: SortOption.addedAtDesc,
          groupOption: GroupOption.byStatus,
          groupedBooks: {
            '読書中': [book1],
            '読了': [book2],
          },
          hasMore: false,
          isLoadingMore: false,
          totalCount: 2,
        );

        final loaded = state as BookShelfLoaded;
        expect(loaded.groupedBooks['読書中'], [book1]);
        expect(loaded.groupedBooks['読了'], [book2]);
      });
    });

    group('error', () {
      test('should create error state with failure', () {
        const failure = NetworkFailure(message: 'Network error');
        const state = BookShelfState.error(failure: failure);

        expect(state, isA<BookShelfError>());
        final error = state as BookShelfError;
        expect(error.failure, failure);
        expect(error.failure.userMessage, 'ネットワーク接続を確認してください');
      });
    });

    group('BookShelfLoaded extension', () {
      group('isEmpty', () {
        test('should return true when books is empty', () {
          const state = BookShelfLoaded(
            books: [],
            searchQuery: '',
            sortOption: SortOption.addedAtDesc,
            groupOption: GroupOption.none,
            groupedBooks: {},
            hasMore: false,
            isLoadingMore: false,
            totalCount: 0,
          );

          expect(state.isEmpty, isTrue);
        });

        test('should return false when books is not empty', () {
          final state = BookShelfLoaded(
            books: [createBook()],
            searchQuery: '',
            sortOption: SortOption.addedAtDesc,
            groupOption: GroupOption.none,
            groupedBooks: const {},
            hasMore: false,
            isLoadingMore: false,
            totalCount: 1,
          );

          expect(state.isEmpty, isFalse);
        });
      });

      group('hasSearchQuery', () {
        test('should return true when searchQuery is not empty', () {
          final state = BookShelfLoaded(
            books: [createBook()],
            searchQuery: 'test',
            sortOption: SortOption.addedAtDesc,
            groupOption: GroupOption.none,
            groupedBooks: const {},
            hasMore: false,
            isLoadingMore: false,
            totalCount: 1,
          );

          expect(state.hasSearchQuery, isTrue);
        });

        test('should return false when searchQuery is empty', () {
          final state = BookShelfLoaded(
            books: [createBook()],
            searchQuery: '',
            sortOption: SortOption.addedAtDesc,
            groupOption: GroupOption.none,
            groupedBooks: const {},
            hasMore: false,
            isLoadingMore: false,
            totalCount: 1,
          );

          expect(state.hasSearchQuery, isFalse);
        });
      });

      group('isGrouped', () {
        test('should return true when groupOption is not none', () {
          final state = BookShelfLoaded(
            books: [createBook()],
            searchQuery: '',
            sortOption: SortOption.addedAtDesc,
            groupOption: GroupOption.byStatus,
            groupedBooks: const {},
            hasMore: false,
            isLoadingMore: false,
            totalCount: 1,
          );

          expect(state.isGrouped, isTrue);
        });

        test('should return false when groupOption is none', () {
          final state = BookShelfLoaded(
            books: [createBook()],
            searchQuery: '',
            sortOption: SortOption.addedAtDesc,
            groupOption: GroupOption.none,
            groupedBooks: const {},
            hasMore: false,
            isLoadingMore: false,
            totalCount: 1,
          );

          expect(state.isGrouped, isFalse);
        });
      });

      group('canLoadMore', () {
        test('should return true when hasMore is true and isLoadingMore is false', () {
          final state = BookShelfLoaded(
            books: [createBook()],
            searchQuery: '',
            sortOption: SortOption.addedAtDesc,
            groupOption: GroupOption.none,
            groupedBooks: const {},
            hasMore: true,
            isLoadingMore: false,
            totalCount: 100,
          );

          expect(state.canLoadMore, isTrue);
        });

        test('should return false when hasMore is false', () {
          final state = BookShelfLoaded(
            books: [createBook()],
            searchQuery: '',
            sortOption: SortOption.addedAtDesc,
            groupOption: GroupOption.none,
            groupedBooks: const {},
            hasMore: false,
            isLoadingMore: false,
            totalCount: 1,
          );

          expect(state.canLoadMore, isFalse);
        });

        test('should return false when isLoadingMore is true', () {
          final state = BookShelfLoaded(
            books: [createBook()],
            searchQuery: '',
            sortOption: SortOption.addedAtDesc,
            groupOption: GroupOption.none,
            groupedBooks: const {},
            hasMore: true,
            isLoadingMore: true,
            totalCount: 100,
          );

          expect(state.canLoadMore, isFalse);
        });
      });
    });

    group('pattern matching', () {
      test('should match initial state', () {
        const state = BookShelfState.initial();
        final result = switch (state) {
          BookShelfInitial() => 'initial',
          BookShelfLoading() => 'loading',
          BookShelfLoaded() => 'loaded',
          BookShelfError() => 'error',
        };

        expect(result, 'initial');
      });

      test('should match loading state', () {
        const state = BookShelfState.loading();
        final result = switch (state) {
          BookShelfInitial() => 'initial',
          BookShelfLoading() => 'loading',
          BookShelfLoaded() => 'loaded',
          BookShelfError() => 'error',
        };

        expect(result, 'loading');
      });

      test('should match loaded state', () {
        final state = BookShelfState.loaded(
          books: [createBook()],
          searchQuery: '',
          sortOption: SortOption.addedAtDesc,
          groupOption: GroupOption.none,
          groupedBooks: const {},
          hasMore: false,
          isLoadingMore: false,
          totalCount: 1,
        );
        final result = switch (state) {
          BookShelfInitial() => 'initial',
          BookShelfLoading() => 'loading',
          BookShelfLoaded() => 'loaded',
          BookShelfError() => 'error',
        };

        expect(result, 'loaded');
      });

      test('should match error state', () {
        const state = BookShelfState.error(
          failure: NetworkFailure(message: 'error'),
        );
        final result = switch (state) {
          BookShelfInitial() => 'initial',
          BookShelfLoading() => 'loading',
          BookShelfLoaded() => 'loaded',
          BookShelfError() => 'error',
        };

        expect(result, 'error');
      });
    });
  });
}
