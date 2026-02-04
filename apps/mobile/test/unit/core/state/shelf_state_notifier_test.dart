import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/state/book_list_version.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/state/shelf_version.dart';
import 'package:shelfie/features/book_detail/data/book_detail_repository.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_detail/domain/user_book.dart' as detail;
import 'package:shelfie/features/book_search/data/book_search_repository.dart';

class MockBookSearchRepository extends Mock implements BookSearchRepository {}

class MockBookDetailRepository extends Mock implements BookDetailRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(ReadingStatus.backlog);
    registerFallbackValue(BookSource.rakuten);
  });

  late ProviderContainer container;
  late MockBookSearchRepository mockRepository;
  late MockBookDetailRepository mockBookDetailRepository;

  setUp(() {
    mockRepository = MockBookSearchRepository();
    mockBookDetailRepository = MockBookDetailRepository();
    container = ProviderContainer(
      overrides: [
        bookSearchRepositoryProvider.overrideWithValue(mockRepository),
        bookDetailRepositoryProvider
            .overrideWithValue(mockBookDetailRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('ShelfState', () {
    group('initial state', () {
      test('should start with empty map', () {
        final state = container.read(shelfStateProvider);
        expect(state, isEmpty);
      });
    });

    group('registerEntry', () {
      test('should register a shelf entry', () {
        final notifier = container.read(shelfStateProvider.notifier);
        final entry = ShelfEntry(
          userBookId: 1,
          externalId: 'book-123',
          readingStatus: ReadingStatus.backlog,
          addedAt: DateTime.now(),
        );

        notifier.registerEntry(entry);

        final state = container.read(shelfStateProvider);
        expect(state['book-123'], equals(entry));
      });

      test('should update existing entry', () {
        final notifier = container.read(shelfStateProvider.notifier);
        final entry1 = ShelfEntry(
          userBookId: 1,
          externalId: 'book-123',
          readingStatus: ReadingStatus.backlog,
          addedAt: DateTime.now(),
        );
        final entry2 = entry1.copyWith(readingStatus: ReadingStatus.reading);

        notifier.registerEntry(entry1);
        notifier.registerEntry(entry2);

        final state = container.read(shelfStateProvider);
        expect(state['book-123']?.readingStatus, ReadingStatus.reading);
      });
    });

    group('removeEntry', () {
      test('should remove entry by externalId', () {
        final notifier = container.read(shelfStateProvider.notifier);
        final entry = ShelfEntry(
          userBookId: 1,
          externalId: 'book-123',
          readingStatus: ReadingStatus.backlog,
          addedAt: DateTime.now(),
        );

        notifier.registerEntry(entry);
        expect(container.read(shelfStateProvider).containsKey('book-123'), isTrue);

        notifier.removeEntry('book-123');
        expect(container.read(shelfStateProvider).containsKey('book-123'), isFalse);
      });

      test('should do nothing when entry does not exist', () {
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.removeEntry('non-existent');

        final state = container.read(shelfStateProvider);
        expect(state, isEmpty);
      });
    });

    group('isInShelf', () {
      test('should return true when book is in shelf', () {
        final notifier = container.read(shelfStateProvider.notifier);
        final entry = ShelfEntry(
          userBookId: 1,
          externalId: 'book-123',
          readingStatus: ReadingStatus.backlog,
          addedAt: DateTime.now(),
        );

        notifier.registerEntry(entry);

        expect(notifier.isInShelf('book-123'), isTrue);
      });

      test('should return false when book is not in shelf', () {
        final notifier = container.read(shelfStateProvider.notifier);
        expect(notifier.isInShelf('non-existent'), isFalse);
      });
    });

    group('getEntry', () {
      test('should return entry when exists', () {
        final notifier = container.read(shelfStateProvider.notifier);
        final entry = ShelfEntry(
          userBookId: 1,
          externalId: 'book-123',
          readingStatus: ReadingStatus.backlog,
          addedAt: DateTime.now(),
        );

        notifier.registerEntry(entry);

        expect(notifier.getEntry('book-123'), equals(entry));
      });

      test('should return null when entry does not exist', () {
        final notifier = container.read(shelfStateProvider.notifier);
        expect(notifier.getEntry('non-existent'), isNull);
      });
    });

    group('getUserBookId', () {
      test('should return userBookId when entry exists', () {
        final notifier = container.read(shelfStateProvider.notifier);
        final entry = ShelfEntry(
          userBookId: 42,
          externalId: 'book-123',
          readingStatus: ReadingStatus.backlog,
          addedAt: DateTime.now(),
        );

        notifier.registerEntry(entry);

        expect(notifier.getUserBookId('book-123'), 42);
      });

      test('should return null when entry does not exist', () {
        final notifier = container.read(shelfStateProvider.notifier);
        expect(notifier.getUserBookId('non-existent'), isNull);
      });
    });

    group('addToShelf', () {
      test('should add book to shelf and update state on success', () async {
        final now = DateTime.now();
        when(
          () => mockRepository.addBookToShelf(
            externalId: any(named: 'externalId'),
            title: any(named: 'title'),
            authors: any(named: 'authors'),
            publisher: any(named: 'publisher'),
            publishedDate: any(named: 'publishedDate'),
            isbn: any(named: 'isbn'),
            coverImageUrl: any(named: 'coverImageUrl'),
            source: any(named: 'source'),
            readingStatus: any(named: 'readingStatus'),
          ),
        ).thenAnswer(
          (_) async => right(
            UserBook(
              id: 1,
              externalId: 'book-123',
              title: 'Test Book',
              authors: ['Author'],
              addedAt: now,
            ),
          ),
        );

        final notifier = container.read(shelfStateProvider.notifier);
        final result = await notifier.addToShelf(
          externalId: 'book-123',
          title: 'Test Book',
          authors: ['Author'],
          source: BookSource.rakuten,
        );

        expect(result.isRight(), isTrue);
        expect(notifier.isInShelf('book-123'), isTrue);
        expect(notifier.getUserBookId('book-123'), 1);
      });

      test('should set completedAt when readingStatus is completed', () async {
        final now = DateTime.now();
        when(
          () => mockRepository.addBookToShelf(
            externalId: any(named: 'externalId'),
            title: any(named: 'title'),
            authors: any(named: 'authors'),
            publisher: any(named: 'publisher'),
            publishedDate: any(named: 'publishedDate'),
            isbn: any(named: 'isbn'),
            coverImageUrl: any(named: 'coverImageUrl'),
            source: any(named: 'source'),
            readingStatus: any(named: 'readingStatus'),
          ),
        ).thenAnswer(
          (_) async => right(
            UserBook(
              id: 1,
              externalId: 'book-123',
              title: 'Test Book',
              authors: ['Author'],
              addedAt: now,
            ),
          ),
        );

        final notifier = container.read(shelfStateProvider.notifier);
        final result = await notifier.addToShelf(
          externalId: 'book-123',
          title: 'Test Book',
          authors: ['Author'],
          readingStatus: ReadingStatus.completed,
          source: BookSource.rakuten,
        );

        expect(result.isRight(), isTrue);
        final entry = notifier.getEntry('book-123');
        expect(entry?.readingStatus, ReadingStatus.completed);
        expect(entry?.completedAt, isNotNull);
      });

      test('should set startedAt when readingStatus is reading', () async {
        final now = DateTime.now();
        when(
          () => mockRepository.addBookToShelf(
            externalId: any(named: 'externalId'),
            title: any(named: 'title'),
            authors: any(named: 'authors'),
            publisher: any(named: 'publisher'),
            publishedDate: any(named: 'publishedDate'),
            isbn: any(named: 'isbn'),
            coverImageUrl: any(named: 'coverImageUrl'),
            source: any(named: 'source'),
            readingStatus: any(named: 'readingStatus'),
          ),
        ).thenAnswer(
          (_) async => right(
            UserBook(
              id: 1,
              externalId: 'book-123',
              title: 'Test Book',
              authors: ['Author'],
              addedAt: now,
            ),
          ),
        );

        final notifier = container.read(shelfStateProvider.notifier);
        final result = await notifier.addToShelf(
          externalId: 'book-123',
          title: 'Test Book',
          authors: ['Author'],
          readingStatus: ReadingStatus.reading,
          source: BookSource.rakuten,
        );

        expect(result.isRight(), isTrue);
        final entry = notifier.getEntry('book-123');
        expect(entry?.readingStatus, ReadingStatus.reading);
        expect(entry?.startedAt, isNotNull);
      });

      test('should not set startedAt when readingStatus is not reading', () async {
        final now = DateTime.now();
        when(
          () => mockRepository.addBookToShelf(
            externalId: any(named: 'externalId'),
            title: any(named: 'title'),
            authors: any(named: 'authors'),
            publisher: any(named: 'publisher'),
            publishedDate: any(named: 'publishedDate'),
            isbn: any(named: 'isbn'),
            coverImageUrl: any(named: 'coverImageUrl'),
            source: any(named: 'source'),
            readingStatus: any(named: 'readingStatus'),
          ),
        ).thenAnswer(
          (_) async => right(
            UserBook(
              id: 1,
              externalId: 'book-123',
              title: 'Test Book',
              authors: ['Author'],
              addedAt: now,
            ),
          ),
        );

        final notifier = container.read(shelfStateProvider.notifier);
        final result = await notifier.addToShelf(
          externalId: 'book-123',
          title: 'Test Book',
          authors: ['Author'],
          source: BookSource.rakuten,
        );

        expect(result.isRight(), isTrue);
        final entry = notifier.getEntry('book-123');
        expect(entry?.startedAt, isNull);
      });

      test('should not update state on failure', () async {
        when(
          () => mockRepository.addBookToShelf(
            externalId: any(named: 'externalId'),
            title: any(named: 'title'),
            authors: any(named: 'authors'),
            publisher: any(named: 'publisher'),
            publishedDate: any(named: 'publishedDate'),
            isbn: any(named: 'isbn'),
            coverImageUrl: any(named: 'coverImageUrl'),
            source: any(named: 'source'),
            readingStatus: any(named: 'readingStatus'),
          ),
        ).thenAnswer(
          (_) async => left(const NetworkFailure(message: 'Network error')),
        );

        final notifier = container.read(shelfStateProvider.notifier);
        final result = await notifier.addToShelf(
          externalId: 'book-123',
          title: 'Test Book',
          authors: ['Author'],
          source: BookSource.rakuten,
        );

        expect(result.isLeft(), isTrue);
        expect(notifier.isInShelf('book-123'), isFalse);
      });
    });

    group('removeFromShelf', () {
      test('should remove book from shelf and update state on success', () async {
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-123',
            readingStatus: ReadingStatus.backlog,
            addedAt: DateTime.now(),
          ),
        );

        when(() => mockRepository.removeFromShelf(userBookId: 1))
            .thenAnswer((_) async => right(true));

        final result = await notifier.removeFromShelf(
          externalId: 'book-123',
          userBookId: 1,
        );

        expect(result.isRight(), isTrue);
        expect(notifier.isInShelf('book-123'), isFalse);
      });

      test('should not update state on failure', () async {
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-123',
            readingStatus: ReadingStatus.backlog,
            addedAt: DateTime.now(),
          ),
        );

        when(() => mockRepository.removeFromShelf(userBookId: 1))
            .thenAnswer((_) async => left(const NetworkFailure(message: 'Network error')));

        final result = await notifier.removeFromShelf(
          externalId: 'book-123',
          userBookId: 1,
        );

        expect(result.isLeft(), isTrue);
        expect(notifier.isInShelf('book-123'), isTrue);
      });
    });

    group('updateReadingStatus', () {
      test('should update reading status optimistically', () async {
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-123',
            readingStatus: ReadingStatus.backlog,
            addedAt: DateTime.now(),
          ),
        );

        notifier.updateReadingStatus(
          externalId: 'book-123',
          status: ReadingStatus.reading,
        );

        final entry = notifier.getEntry('book-123');
        expect(entry?.readingStatus, ReadingStatus.reading);
      });

      test('should set completedAt when status is completed', () async {
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-123',
            readingStatus: ReadingStatus.reading,
            addedAt: DateTime.now(),
          ),
        );

        notifier.updateReadingStatus(
          externalId: 'book-123',
          status: ReadingStatus.completed,
        );

        final entry = notifier.getEntry('book-123');
        expect(entry?.readingStatus, ReadingStatus.completed);
        expect(entry?.completedAt, isNotNull);
      });

      test('should preserve completedAt when status changes from completed', () async {
        final completedAt = DateTime(2024, 6, 20);
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-123',
            readingStatus: ReadingStatus.completed,
            addedAt: DateTime.now(),
            completedAt: completedAt,
          ),
        );

        notifier.updateReadingStatus(
          externalId: 'book-123',
          status: ReadingStatus.reading,
        );

        final entry = notifier.getEntry('book-123');
        expect(entry?.readingStatus, ReadingStatus.reading);
        expect(entry?.completedAt, equals(completedAt));
      });

      test('should preserve existing completedAt when status changes to completed', () async {
        final existingCompletedAt = DateTime(2024, 5, 15);
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-123',
            readingStatus: ReadingStatus.reading,
            addedAt: DateTime.now(),
            completedAt: existingCompletedAt,
          ),
        );

        notifier.updateReadingStatus(
          externalId: 'book-123',
          status: ReadingStatus.completed,
        );

        final entry = notifier.getEntry('book-123');
        expect(entry?.readingStatus, ReadingStatus.completed);
        expect(entry?.completedAt, equals(existingCompletedAt));
      });

      test('should do nothing when entry does not exist', () async {
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.updateReadingStatus(
          externalId: 'non-existent',
          status: ReadingStatus.reading,
        );

        expect(container.read(shelfStateProvider), isEmpty);
      });

      test('should set startedAt when status is changed to reading and startedAt is null', () async {
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-123',
            readingStatus: ReadingStatus.backlog,
            addedAt: DateTime.now(),
          ),
        );

        notifier.updateReadingStatus(
          externalId: 'book-123',
          status: ReadingStatus.reading,
        );

        final entry = notifier.getEntry('book-123');
        expect(entry?.readingStatus, ReadingStatus.reading);
        expect(entry?.startedAt, isNotNull);
      });

      test('should not overwrite startedAt when status is changed to reading and startedAt already exists', () async {
        final existingStartedAt = DateTime(2024, 1, 1);
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-123',
            readingStatus: ReadingStatus.completed,
            addedAt: DateTime.now(),
            startedAt: existingStartedAt,
            completedAt: DateTime.now(),
          ),
        );

        notifier.updateReadingStatus(
          externalId: 'book-123',
          status: ReadingStatus.reading,
        );

        final entry = notifier.getEntry('book-123');
        expect(entry?.readingStatus, ReadingStatus.reading);
        expect(entry?.startedAt, existingStartedAt);
      });

      test('should not clear startedAt when status is changed from reading to another status', () async {
        final existingStartedAt = DateTime(2024, 1, 1);
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-123',
            readingStatus: ReadingStatus.reading,
            addedAt: DateTime.now(),
            startedAt: existingStartedAt,
          ),
        );

        notifier.updateReadingStatus(
          externalId: 'book-123',
          status: ReadingStatus.backlog,
        );

        final entry = notifier.getEntry('book-123');
        expect(entry?.readingStatus, ReadingStatus.backlog);
        expect(entry?.startedAt, existingStartedAt);
      });
    });

    group('updateReadingNote', () {
      test('should update reading note optimistically', () async {
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-123',
            readingStatus: ReadingStatus.reading,
            addedAt: DateTime.now(),
          ),
        );

        notifier.updateReadingNote(
          externalId: 'book-123',
          note: 'Great book!',
        );

        final entry = notifier.getEntry('book-123');
        expect(entry?.note, 'Great book!');
        expect(entry?.noteUpdatedAt, isNotNull);
      });

      test('should do nothing when entry does not exist', () async {
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.updateReadingNote(
          externalId: 'non-existent',
          note: 'Some note',
        );

        expect(container.read(shelfStateProvider), isEmpty);
      });
    });

    group('clear', () {
      test('should clear all entries', () {
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-1',
            readingStatus: ReadingStatus.backlog,
            addedAt: DateTime.now(),
          ),
        );
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 2,
            externalId: 'book-2',
            readingStatus: ReadingStatus.reading,
            addedAt: DateTime.now(),
          ),
        );

        expect(container.read(shelfStateProvider).length, 2);

        notifier.clear();

        expect(container.read(shelfStateProvider), isEmpty);
      });
    });

    group('shelfVersionProvider の更新', () {
      test('addToShelf 成功時に shelfVersion が increment される', () async {
        when(
          () => mockRepository.addBookToShelf(
            externalId: any(named: 'externalId'),
            title: any(named: 'title'),
            authors: any(named: 'authors'),
            publisher: any(named: 'publisher'),
            publishedDate: any(named: 'publishedDate'),
            isbn: any(named: 'isbn'),
            coverImageUrl: any(named: 'coverImageUrl'),
            source: any(named: 'source'),
            readingStatus: any(named: 'readingStatus'),
          ),
        ).thenAnswer(
          (_) async => right(
            UserBook(
              id: 1,
              externalId: 'book-123',
              title: 'Test Book',
              authors: ['Author'],
              addedAt: DateTime.now(),
            ),
          ),
        );

        final versionBefore = container.read(shelfVersionProvider);
        final notifier = container.read(shelfStateProvider.notifier);
        await notifier.addToShelf(
          externalId: 'book-123',
          title: 'Test Book',
          authors: ['Author'],
          source: BookSource.rakuten,
        );

        expect(container.read(shelfVersionProvider), versionBefore + 1);
      });

      test('addToShelf 失敗時は shelfVersion が変わらない', () async {
        when(
          () => mockRepository.addBookToShelf(
            externalId: any(named: 'externalId'),
            title: any(named: 'title'),
            authors: any(named: 'authors'),
            publisher: any(named: 'publisher'),
            publishedDate: any(named: 'publishedDate'),
            isbn: any(named: 'isbn'),
            coverImageUrl: any(named: 'coverImageUrl'),
            source: any(named: 'source'),
            readingStatus: any(named: 'readingStatus'),
          ),
        ).thenAnswer(
          (_) async => left(const NetworkFailure(message: 'Network error')),
        );

        final versionBefore = container.read(shelfVersionProvider);
        final notifier = container.read(shelfStateProvider.notifier);
        await notifier.addToShelf(
          externalId: 'book-123',
          title: 'Test Book',
          authors: ['Author'],
          source: BookSource.rakuten,
        );

        expect(container.read(shelfVersionProvider), versionBefore);
      });

      test('removeFromShelf 成功時に shelfVersion が increment される', () async {
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-123',
            readingStatus: ReadingStatus.backlog,
            addedAt: DateTime.now(),
          ),
        );

        when(() => mockRepository.removeFromShelf(userBookId: 1))
            .thenAnswer((_) async => right(true));

        final versionBefore = container.read(shelfVersionProvider);
        await notifier.removeFromShelf(
          externalId: 'book-123',
          userBookId: 1,
        );

        expect(container.read(shelfVersionProvider), versionBefore + 1);
      });

      test('removeFromShelf 失敗時は shelfVersion が変わらない', () async {
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-123',
            readingStatus: ReadingStatus.backlog,
            addedAt: DateTime.now(),
          ),
        );

        when(() => mockRepository.removeFromShelf(userBookId: 1))
            .thenAnswer((_) async => left(const NetworkFailure(message: 'Network error')));

        final versionBefore = container.read(shelfVersionProvider);
        await notifier.removeFromShelf(
          externalId: 'book-123',
          userBookId: 1,
        );

        expect(container.read(shelfVersionProvider), versionBefore);
      });

      test('updateReadingStatusWithApi 成功時に shelfVersion が increment される',
          () async {
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-123',
            readingStatus: ReadingStatus.backlog,
            addedAt: DateTime.now(),
          ),
        );

        when(
          () => mockBookDetailRepository.updateReadingStatus(
            userBookId: any(named: 'userBookId'),
            status: any(named: 'status'),
          ),
        ).thenAnswer(
          (_) async => right(
            detail.UserBook(
              id: 1,
              readingStatus: ReadingStatus.reading,
              addedAt: DateTime.now(),
            ),
          ),
        );

        final versionBefore = container.read(shelfVersionProvider);
        await notifier.updateReadingStatusWithApi(
          externalId: 'book-123',
          status: ReadingStatus.reading,
        );

        expect(container.read(shelfVersionProvider), versionBefore + 1);
      });

      test('updateReadingStatusWithApi 失敗時は shelfVersion が変わらない', () async {
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-123',
            readingStatus: ReadingStatus.backlog,
            addedAt: DateTime.now(),
          ),
        );

        when(
          () => mockBookDetailRepository.updateReadingStatus(
            userBookId: any(named: 'userBookId'),
            status: any(named: 'status'),
          ),
        ).thenAnswer(
          (_) async =>
              left(const NetworkFailure(message: 'Network error')),
        );

        final versionBefore = container.read(shelfVersionProvider);
        await notifier.updateReadingStatusWithApi(
          externalId: 'book-123',
          status: ReadingStatus.reading,
        );

        expect(container.read(shelfVersionProvider), versionBefore);
      });

      test('updateReadingNoteWithApi 成功時は shelfVersion が変わらない', () async {
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-123',
            readingStatus: ReadingStatus.reading,
            addedAt: DateTime.now(),
          ),
        );

        when(
          () => mockBookDetailRepository.updateReadingNote(
            userBookId: any(named: 'userBookId'),
            note: any(named: 'note'),
          ),
        ).thenAnswer(
          (_) async => right(
            detail.UserBook(
              id: 1,
              readingStatus: ReadingStatus.reading,
              addedAt: DateTime.now(),
              note: 'Great book!',
              noteUpdatedAt: DateTime.now(),
            ),
          ),
        );

        final versionBefore = container.read(shelfVersionProvider);
        await notifier.updateReadingNoteWithApi(
          externalId: 'book-123',
          note: 'Great book!',
        );

        expect(container.read(shelfVersionProvider), versionBefore);
      });

      test('updateRatingWithApi 成功時は shelfVersion が変わらない', () async {
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-123',
            readingStatus: ReadingStatus.reading,
            addedAt: DateTime.now(),
          ),
        );

        when(
          () => mockBookDetailRepository.updateRating(
            userBookId: any(named: 'userBookId'),
            rating: any(named: 'rating'),
          ),
        ).thenAnswer(
          (_) async => right(
            detail.UserBook(
              id: 1,
              readingStatus: ReadingStatus.reading,
              addedAt: DateTime.now(),
              rating: 4,
            ),
          ),
        );

        final versionBefore = container.read(shelfVersionProvider);
        await notifier.updateRatingWithApi(
          externalId: 'book-123',
          rating: 4,
        );

        expect(container.read(shelfVersionProvider), versionBefore);
      });
    });

    group('bookListVersionProvider の更新', () {
      test('removeFromShelf 成功時に bookListVersion が increment される',
          () async {
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-123',
            readingStatus: ReadingStatus.backlog,
            addedAt: DateTime.now(),
          ),
        );

        when(() => mockRepository.removeFromShelf(userBookId: 1))
            .thenAnswer((_) async => right(true));

        final versionBefore = container.read(bookListVersionProvider);
        await notifier.removeFromShelf(
          externalId: 'book-123',
          userBookId: 1,
        );

        expect(container.read(bookListVersionProvider), versionBefore + 1);
      });

      test('removeFromShelf 失敗時は bookListVersion が変わらない', () async {
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-123',
            readingStatus: ReadingStatus.backlog,
            addedAt: DateTime.now(),
          ),
        );

        when(() => mockRepository.removeFromShelf(userBookId: 1)).thenAnswer(
            (_) async =>
                left(const NetworkFailure(message: 'Network error')));

        final versionBefore = container.read(bookListVersionProvider);
        await notifier.removeFromShelf(
          externalId: 'book-123',
          userBookId: 1,
        );

        expect(container.read(bookListVersionProvider), versionBefore);
      });

      test('addToShelf 成功時は bookListVersion が変わらない', () async {
        when(
          () => mockRepository.addBookToShelf(
            externalId: any(named: 'externalId'),
            title: any(named: 'title'),
            authors: any(named: 'authors'),
            publisher: any(named: 'publisher'),
            publishedDate: any(named: 'publishedDate'),
            isbn: any(named: 'isbn'),
            coverImageUrl: any(named: 'coverImageUrl'),
            source: any(named: 'source'),
            readingStatus: any(named: 'readingStatus'),
          ),
        ).thenAnswer(
          (_) async => right(
            UserBook(
              id: 1,
              externalId: 'book-123',
              title: 'Test Book',
              authors: ['Author'],
              addedAt: DateTime.now(),
            ),
          ),
        );

        final versionBefore = container.read(bookListVersionProvider);
        final notifier = container.read(shelfStateProvider.notifier);
        await notifier.addToShelf(
          externalId: 'book-123',
          title: 'Test Book',
          authors: ['Author'],
          source: BookSource.rakuten,
        );

        expect(container.read(bookListVersionProvider), versionBefore);
      });
    });

    group('updateStartedAtWithApi', () {
      test('成功時は startedAt が更新される', () async {
        final now = DateTime.now();
        final newStartedAt = DateTime(2024, 5, 10);
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-123',
            readingStatus: ReadingStatus.reading,
            addedAt: now,
            startedAt: now,
          ),
        );

        when(
          () => mockBookDetailRepository.updateStartedAt(
            userBookId: any(named: 'userBookId'),
            startedAt: any(named: 'startedAt'),
          ),
        ).thenAnswer(
          (_) async => right(
            detail.UserBook(
              id: 1,
              readingStatus: ReadingStatus.reading,
              addedAt: now,
              startedAt: newStartedAt,
            ),
          ),
        );

        final result = await notifier.updateStartedAtWithApi(
          externalId: 'book-123',
          startedAt: newStartedAt,
        );

        expect(result.isRight(), isTrue);
        final entry = notifier.getEntry('book-123');
        expect(entry?.startedAt, equals(newStartedAt));
      });

      test('失敗時は元の状態にロールバックする', () async {
        final now = DateTime.now();
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-123',
            readingStatus: ReadingStatus.reading,
            addedAt: now,
            startedAt: now,
          ),
        );

        when(
          () => mockBookDetailRepository.updateStartedAt(
            userBookId: any(named: 'userBookId'),
            startedAt: any(named: 'startedAt'),
          ),
        ).thenAnswer(
          (_) async =>
              left(const NetworkFailure(message: 'Network error')),
        );

        final result = await notifier.updateStartedAtWithApi(
          externalId: 'book-123',
          startedAt: DateTime(2024, 5, 10),
        );

        expect(result.isLeft(), isTrue);
        final entry = notifier.getEntry('book-123');
        expect(entry?.startedAt, equals(now));
      });

      test('エントリが存在しない場合は Left(UnexpectedFailure) を返す', () async {
        final notifier = container.read(shelfStateProvider.notifier);

        final result = await notifier.updateStartedAtWithApi(
          externalId: 'non-existent',
          startedAt: DateTime(2024, 5, 10),
        );

        expect(result.isLeft(), isTrue);
      });
    });

    group('updateCompletedAtWithApi', () {
      test('成功時は completedAt が更新される', () async {
        final now = DateTime.now();
        final newCompletedAt = DateTime(2024, 5, 10);
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-123',
            readingStatus: ReadingStatus.completed,
            addedAt: now,
            completedAt: now,
          ),
        );

        when(
          () => mockBookDetailRepository.updateCompletedAt(
            userBookId: any(named: 'userBookId'),
            completedAt: any(named: 'completedAt'),
          ),
        ).thenAnswer(
          (_) async => right(
            detail.UserBook(
              id: 1,
              readingStatus: ReadingStatus.completed,
              addedAt: now,
              completedAt: newCompletedAt,
            ),
          ),
        );

        final result = await notifier.updateCompletedAtWithApi(
          externalId: 'book-123',
          completedAt: newCompletedAt,
        );

        expect(result.isRight(), isTrue);
        final entry = notifier.getEntry('book-123');
        expect(entry?.completedAt, equals(newCompletedAt));
      });

      test('失敗時は元の状態にロールバックする', () async {
        final now = DateTime.now();
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-123',
            readingStatus: ReadingStatus.completed,
            addedAt: now,
            completedAt: now,
          ),
        );

        when(
          () => mockBookDetailRepository.updateCompletedAt(
            userBookId: any(named: 'userBookId'),
            completedAt: any(named: 'completedAt'),
          ),
        ).thenAnswer(
          (_) async =>
              left(const NetworkFailure(message: 'Network error')),
        );

        final result = await notifier.updateCompletedAtWithApi(
          externalId: 'book-123',
          completedAt: DateTime(2024, 5, 10),
        );

        expect(result.isLeft(), isTrue);
        final entry = notifier.getEntry('book-123');
        expect(entry?.completedAt, equals(now));
      });

      test('エントリが存在しない場合は Left(UnexpectedFailure) を返す', () async {
        final notifier = container.read(shelfStateProvider.notifier);

        final result = await notifier.updateCompletedAtWithApi(
          externalId: 'non-existent',
          completedAt: DateTime(2024, 5, 10),
        );

        expect(result.isLeft(), isTrue);
      });

      test('shelfVersion が変わらない', () async {
        final now = DateTime.now();
        final newCompletedAt = DateTime(2024, 5, 10);
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-123',
            readingStatus: ReadingStatus.completed,
            addedAt: now,
            completedAt: now,
          ),
        );

        when(
          () => mockBookDetailRepository.updateCompletedAt(
            userBookId: any(named: 'userBookId'),
            completedAt: any(named: 'completedAt'),
          ),
        ).thenAnswer(
          (_) async => right(
            detail.UserBook(
              id: 1,
              readingStatus: ReadingStatus.completed,
              addedAt: now,
              completedAt: newCompletedAt,
            ),
          ),
        );

        final versionBefore = container.read(shelfVersionProvider);
        await notifier.updateCompletedAtWithApi(
          externalId: 'book-123',
          completedAt: newCompletedAt,
        );

        expect(container.read(shelfVersionProvider), versionBefore);
      });
    });

    group('backward compatibility', () {
      test('registerBook should work as alias for registerEntry', () {
        final notifier = container.read(shelfStateProvider.notifier);

        notifier.registerBook('book-123', 1);

        expect(notifier.isInShelf('book-123'), isTrue);
        expect(notifier.getUserBookId('book-123'), 1);
      });
    });
  });
}
