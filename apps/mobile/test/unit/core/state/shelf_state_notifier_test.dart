import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/state/shelf_entry.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart';

class MockBookSearchRepository extends Mock implements BookSearchRepository {}

void main() {
  late ProviderContainer container;
  late MockBookSearchRepository mockRepository;

  setUp(() {
    mockRepository = MockBookSearchRepository();
    container = ProviderContainer(
      overrides: [
        bookSearchRepositoryProvider.overrideWithValue(mockRepository),
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
        );

        expect(result.isRight(), isTrue);
        expect(notifier.isInShelf('book-123'), isTrue);
        expect(notifier.getUserBookId('book-123'), 1);
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
          ),
        ).thenAnswer(
          (_) async => left(const NetworkFailure(message: 'Network error')),
        );

        final notifier = container.read(shelfStateProvider.notifier);
        final result = await notifier.addToShelf(
          externalId: 'book-123',
          title: 'Test Book',
          authors: ['Author'],
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

      test('should clear completedAt when status changes from completed', () async {
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.registerEntry(
          ShelfEntry(
            userBookId: 1,
            externalId: 'book-123',
            readingStatus: ReadingStatus.completed,
            addedAt: DateTime.now(),
            completedAt: DateTime.now(),
          ),
        );

        notifier.updateReadingStatus(
          externalId: 'book-123',
          status: ReadingStatus.reading,
        );

        final entry = notifier.getEntry('book-123');
        expect(entry?.readingStatus, ReadingStatus.reading);
        expect(entry?.completedAt, isNull);
      });

      test('should do nothing when entry does not exist', () async {
        final notifier = container.read(shelfStateProvider.notifier);
        notifier.updateReadingStatus(
          externalId: 'non-existent',
          status: ReadingStatus.reading,
        );

        expect(container.read(shelfStateProvider), isEmpty);
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
