import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shelfie/core/error/failure.dart';
import 'package:shelfie/core/state/shelf_state_notifier.dart';
import 'package:shelfie/core/storage/secure_storage_service.dart';
import 'package:shelfie/features/book_detail/application/book_detail_notifier.dart';
import 'package:shelfie/features/book_detail/data/book_detail_repository.dart';
import 'package:shelfie/features/book_detail/domain/book_detail.dart';
import 'package:shelfie/features/book_detail/domain/reading_status.dart';
import 'package:shelfie/features/book_detail/domain/user_book.dart';
import 'package:shelfie/features/book_search/data/book_search_repository.dart'
    show BookSource;

class MockBookDetailRepository extends Mock implements BookDetailRepository {}

class MockSecureStorageService extends Mock implements SecureStorageService {}

ProviderContainer createTestContainer({
  required MockBookDetailRepository mockRepository,
  List<Override> overrides = const [],
}) {
  final mockStorage = MockSecureStorageService();
  when(() => mockStorage.saveAuthData(
        userId: any(named: 'userId'),
        email: any(named: 'email'),
        idToken: any(named: 'idToken'),
        refreshToken: any(named: 'refreshToken'),
      )).thenAnswer((_) async {});
  when(() => mockStorage.updateTokens(
        idToken: any(named: 'idToken'),
        refreshToken: any(named: 'refreshToken'),
      )).thenAnswer((_) async {});
  when(() => mockStorage.clearAuthData()).thenAnswer((_) async {});
  when(() => mockStorage.loadAuthData()).thenAnswer((_) async => null);

  return ProviderContainer(
    overrides: [
      secureStorageServiceProvider.overrideWithValue(mockStorage),
      bookDetailRepositoryProvider.overrideWithValue(mockRepository),
      ...overrides,
    ],
  );
}

BookDetail createMockBookDetail({
  String id = 'book-1',
  String title = 'Test Book',
  List<String> authors = const ['Author 1'],
}) {
  return BookDetail(
    id: id,
    title: title,
    authors: authors,
  );
}

UserBook createMockUserBook({
  int id = 1,
  ReadingStatus readingStatus = ReadingStatus.backlog,
  DateTime? addedAt,
  DateTime? startedAt,
  DateTime? completedAt,
  String? note,
  DateTime? noteUpdatedAt,
  String? thoughts,
  DateTime? thoughtsUpdatedAt,
}) {
  return UserBook(
    id: id,
    readingStatus: readingStatus,
    addedAt: addedAt ?? DateTime(2024, 6, 15),
    startedAt: startedAt,
    completedAt: completedAt,
    note: note,
    noteUpdatedAt: noteUpdatedAt,
    thoughts: thoughts,
    thoughtsUpdatedAt: thoughtsUpdatedAt,
  );
}

void main() {
  setUpAll(() {
    registerFallbackValue(BookSource.rakuten);
  });

  group('BookDetailNotifier', () {
    late MockBookDetailRepository mockRepository;
    late ProviderContainer container;

    setUp(() {
      mockRepository = MockBookDetailRepository();
      container = createTestContainer(mockRepository: mockRepository);
    });

    tearDown(() {
      container.dispose();
    });

    group('初期状態', () {
      test('初期状態は AsyncValue.loading', () {
        final state =
            container.read(bookDetailNotifierProvider('book-1'));

        expect(state, isA<AsyncLoading<BookDetail?>>());
      });
    });

    group('loadBookDetail', () {
      test('書籍詳細取得成功時は AsyncValue.data(BookDetail) を返す', () async {
        final bookDetail = createMockBookDetail();

        when(() => mockRepository.getBookDetail(bookId: 'book-1', source: any(named: 'source')))
            .thenAnswer((_) async => right((bookDetail: bookDetail, userBook: null)));

        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);
        await notifier.loadBookDetail(source: BookSource.rakuten);

        final state = container.read(bookDetailNotifierProvider('book-1'));
        expect(state.hasValue, isTrue);
        expect(state.value, isNotNull);
        expect(state.value!.id, equals('book-1'));
        expect(state.value!.title, equals('Test Book'));
      });

      test('マイライブラリ追加済みの書籍の場合は ShelfState にエントリを登録する', () async {
        final bookDetail = createMockBookDetail();
        final userBook = createMockUserBook(
          id: 42,
          readingStatus: ReadingStatus.reading,
        );

        when(() => mockRepository.getBookDetail(bookId: 'book-1', source: any(named: 'source')))
            .thenAnswer((_) async => right((bookDetail: bookDetail, userBook: userBook)));

        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);
        await notifier.loadBookDetail(source: BookSource.rakuten);

        final shelfState = container.read(shelfStateProvider);
        expect(shelfState.containsKey('book-1'), isTrue);
        expect(shelfState['book-1']!.userBookId, equals(42));
        expect(shelfState['book-1']!.readingStatus, equals(ReadingStatus.reading));
      });

      test('取得失敗時は AsyncValue.error を返す', () async {
        when(() => mockRepository.getBookDetail(bookId: 'book-1', source: any(named: 'source')))
            .thenAnswer((_) async => left(
                const NetworkFailure(message: 'No internet connection')));

        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);
        await notifier.loadBookDetail(source: BookSource.rakuten);

        final state = container.read(bookDetailNotifierProvider('book-1'));
        expect(state.hasError, isTrue);
        expect(state.error, isA<NetworkFailure>());
      });

      test('書籍が見つからない場合は NotFoundFailure を返す', () async {
        when(() => mockRepository.getBookDetail(bookId: 'not-found', source: any(named: 'source')))
            .thenAnswer(
                (_) async => left(const NotFoundFailure(message: 'Not found')));

        final notifier =
            container.read(bookDetailNotifierProvider('not-found').notifier);
        await notifier.loadBookDetail(source: BookSource.rakuten);

        final state = container.read(bookDetailNotifierProvider('not-found'));
        expect(state.hasError, isTrue);
        expect(state.error, isA<NotFoundFailure>());
      });
    });

    group('updateReadingStatus', () {
      test('読書状態更新成功時は ShelfState を更新する', () async {
        final bookDetail = createMockBookDetail();
        final userBook = createMockUserBook(
          id: 42,
          readingStatus: ReadingStatus.backlog,
        );

        when(() => mockRepository.getBookDetail(bookId: 'book-1', source: any(named: 'source')))
            .thenAnswer((_) async => right((bookDetail: bookDetail, userBook: userBook)));

        final updatedUserBook = createMockUserBook(
          id: 42,
          readingStatus: ReadingStatus.reading,
        );
        when(() => mockRepository.updateReadingStatus(
              userBookId: 42,
              status: ReadingStatus.reading,
            )).thenAnswer((_) async => right(updatedUserBook));

        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);
        await notifier.loadBookDetail(source: BookSource.rakuten);

        final result = await notifier.updateReadingStatus(
          userBookId: 42,
          status: ReadingStatus.reading,
        );

        expect(result.isRight(), isTrue);
        final shelfState = container.read(shelfStateProvider);
        expect(shelfState['book-1']!.readingStatus, equals(ReadingStatus.reading));
      });

      test('読了に更新時は completedAt が設定される', () async {
        final bookDetail = createMockBookDetail();
        final userBook = createMockUserBook(
          id: 42,
          readingStatus: ReadingStatus.reading,
        );

        when(() => mockRepository.getBookDetail(bookId: 'book-1', source: any(named: 'source')))
            .thenAnswer((_) async => right((bookDetail: bookDetail, userBook: userBook)));

        final completedAt = DateTime(2024, 6, 20);
        final updatedUserBook = createMockUserBook(
          id: 42,
          readingStatus: ReadingStatus.completed,
          completedAt: completedAt,
        );
        when(() => mockRepository.updateReadingStatus(
              userBookId: 42,
              status: ReadingStatus.completed,
            )).thenAnswer((_) async => right(updatedUserBook));

        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);
        await notifier.loadBookDetail(source: BookSource.rakuten);

        final result = await notifier.updateReadingStatus(
          userBookId: 42,
          status: ReadingStatus.completed,
        );

        expect(result.isRight(), isTrue);
        final shelfState = container.read(shelfStateProvider);
        expect(shelfState['book-1']!.readingStatus, equals(ReadingStatus.completed));
        expect(shelfState['book-1']!.completedAt, equals(completedAt));
      });

      test('Optimistic update: ShelfState が API呼び出し前に状態を更新する', () async {
        final bookDetail = createMockBookDetail();
        final userBook = createMockUserBook(
          id: 42,
          readingStatus: ReadingStatus.backlog,
        );

        when(() => mockRepository.getBookDetail(bookId: 'book-1', source: any(named: 'source')))
            .thenAnswer((_) async => right((bookDetail: bookDetail, userBook: userBook)));

        final updatedUserBook = createMockUserBook(
          id: 42,
          readingStatus: ReadingStatus.reading,
        );

        final completer = Completer<Either<Failure, UserBook>>();
        when(() => mockRepository.updateReadingStatus(
              userBookId: 42,
              status: ReadingStatus.reading,
            )).thenAnswer((_) => completer.future);

        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);
        await notifier.loadBookDetail(source: BookSource.rakuten);

        // ignore: unawaited_futures
        notifier.updateReadingStatus(
          userBookId: 42,
          status: ReadingStatus.reading,
        );

        await Future<void>.delayed(Duration.zero);

        final shelfState = container.read(shelfStateProvider);
        expect(shelfState['book-1']?.readingStatus, equals(ReadingStatus.reading));

        completer.complete(right(updatedUserBook));
      });

      test('更新失敗時は Optimistic update をロールバックする', () async {
        final bookDetail = createMockBookDetail();
        final userBook = createMockUserBook(
          id: 42,
          readingStatus: ReadingStatus.backlog,
        );

        when(() => mockRepository.getBookDetail(bookId: 'book-1', source: any(named: 'source')))
            .thenAnswer((_) async => right((bookDetail: bookDetail, userBook: userBook)));

        when(() => mockRepository.updateReadingStatus(
              userBookId: 42,
              status: ReadingStatus.reading,
            )).thenAnswer((_) async =>
            left(const ServerFailure(message: 'Server error', code: 'ERROR')));

        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);
        await notifier.loadBookDetail(source: BookSource.rakuten);

        final result = await notifier.updateReadingStatus(
          userBookId: 42,
          status: ReadingStatus.reading,
        );

        expect(result.isLeft(), isTrue);
        final shelfState = container.read(shelfStateProvider);
        expect(shelfState['book-1']!.readingStatus, equals(ReadingStatus.backlog));
      });

      test('認証エラー時は Left(AuthFailure) を返す', () async {
        final bookDetail = createMockBookDetail();
        final userBook = createMockUserBook(id: 42);

        when(() => mockRepository.getBookDetail(bookId: 'book-1', source: any(named: 'source')))
            .thenAnswer((_) async => right((bookDetail: bookDetail, userBook: userBook)));

        when(() => mockRepository.updateReadingStatus(
              userBookId: 42,
              status: ReadingStatus.reading,
            )).thenAnswer((_) async =>
            left(const AuthFailure(message: 'Authentication required')));

        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);
        await notifier.loadBookDetail(source: BookSource.rakuten);

        final result = await notifier.updateReadingStatus(
          userBookId: 42,
          status: ReadingStatus.reading,
        );

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<AuthFailure>());
      });

      test('権限エラー時は Left(ForbiddenFailure) を返す', () async {
        final bookDetail = createMockBookDetail();
        final userBook = createMockUserBook(id: 42);

        when(() => mockRepository.getBookDetail(bookId: 'book-1', source: any(named: 'source')))
            .thenAnswer((_) async => right((bookDetail: bookDetail, userBook: userBook)));

        when(() => mockRepository.updateReadingStatus(
              userBookId: 42,
              status: ReadingStatus.reading,
            )).thenAnswer(
            (_) async => left(const ForbiddenFailure(message: 'Forbidden')));

        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);
        await notifier.loadBookDetail(source: BookSource.rakuten);

        final result = await notifier.updateReadingStatus(
          userBookId: 42,
          status: ReadingStatus.reading,
        );

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<ForbiddenFailure>());
      });
    });

    group('updateReadingNote', () {
      test('読書メモ更新成功時は ShelfState を更新する', () async {
        final bookDetail = createMockBookDetail();
        final userBook = createMockUserBook(
          id: 42,
          note: null,
        );

        when(() => mockRepository.getBookDetail(bookId: 'book-1', source: any(named: 'source')))
            .thenAnswer((_) async => right((bookDetail: bookDetail, userBook: userBook)));

        final noteUpdatedAt = DateTime(2024, 6, 20);
        final updatedUserBook = createMockUserBook(
          id: 42,
          note: 'Great book!',
          noteUpdatedAt: noteUpdatedAt,
        );
        when(() => mockRepository.updateReadingNote(
              userBookId: 42,
              note: 'Great book!',
            )).thenAnswer((_) async => right(updatedUserBook));

        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);
        await notifier.loadBookDetail(source: BookSource.rakuten);

        final result = await notifier.updateReadingNote(
          userBookId: 42,
          note: 'Great book!',
        );

        expect(result.isRight(), isTrue);
        final shelfState = container.read(shelfStateProvider);
        expect(shelfState['book-1']!.note, equals('Great book!'));
        expect(shelfState['book-1']!.noteUpdatedAt, equals(noteUpdatedAt));
      });

      test('空文字でのメモ更新が成功する（メモ削除）', () async {
        final bookDetail = createMockBookDetail();
        final userBook = createMockUserBook(
          id: 42,
          note: 'Old note',
        );

        when(() => mockRepository.getBookDetail(bookId: 'book-1', source: any(named: 'source')))
            .thenAnswer((_) async => right((bookDetail: bookDetail, userBook: userBook)));

        final noteUpdatedAt = DateTime(2024, 6, 20);
        final updatedUserBook = createMockUserBook(
          id: 42,
          note: '',
          noteUpdatedAt: noteUpdatedAt,
        );
        when(() => mockRepository.updateReadingNote(
              userBookId: 42,
              note: '',
            )).thenAnswer((_) async => right(updatedUserBook));

        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);
        await notifier.loadBookDetail(source: BookSource.rakuten);

        final result = await notifier.updateReadingNote(
          userBookId: 42,
          note: '',
        );

        expect(result.isRight(), isTrue);
        final shelfState = container.read(shelfStateProvider);
        expect(shelfState['book-1']!.note, equals(''));
      });

      test('Optimistic update: ShelfState が API呼び出し前に状態を更新する', () async {
        final bookDetail = createMockBookDetail();
        final userBook = createMockUserBook(
          id: 42,
          note: 'Old note',
        );

        when(() => mockRepository.getBookDetail(bookId: 'book-1', source: any(named: 'source')))
            .thenAnswer((_) async => right((bookDetail: bookDetail, userBook: userBook)));

        final noteUpdatedAt = DateTime(2024, 6, 20);
        final updatedUserBook = createMockUserBook(
          id: 42,
          note: 'New note',
          noteUpdatedAt: noteUpdatedAt,
        );

        final completer = Completer<Either<Failure, UserBook>>();
        when(() => mockRepository.updateReadingNote(
              userBookId: 42,
              note: 'New note',
            )).thenAnswer((_) => completer.future);

        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);
        await notifier.loadBookDetail(source: BookSource.rakuten);

        // ignore: unawaited_futures
        notifier.updateReadingNote(
          userBookId: 42,
          note: 'New note',
        );

        await Future<void>.delayed(Duration.zero);

        final shelfState = container.read(shelfStateProvider);
        expect(shelfState['book-1']?.note, equals('New note'));

        completer.complete(right(updatedUserBook));
      });

      test('更新失敗時は Optimistic update をロールバックする', () async {
        final bookDetail = createMockBookDetail();
        final userBook = createMockUserBook(
          id: 42,
          note: 'Old note',
        );

        when(() => mockRepository.getBookDetail(bookId: 'book-1', source: any(named: 'source')))
            .thenAnswer((_) async => right((bookDetail: bookDetail, userBook: userBook)));

        when(() => mockRepository.updateReadingNote(
              userBookId: 42,
              note: 'New note',
            )).thenAnswer((_) async =>
            left(const ServerFailure(message: 'Server error', code: 'ERROR')));

        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);
        await notifier.loadBookDetail(source: BookSource.rakuten);

        final result = await notifier.updateReadingNote(
          userBookId: 42,
          note: 'New note',
        );

        expect(result.isLeft(), isTrue);
        final shelfState = container.read(shelfStateProvider);
        expect(shelfState['book-1']!.note, equals('Old note'));
      });

      test('認証エラー時は Left(AuthFailure) を返す', () async {
        final bookDetail = createMockBookDetail();
        final userBook = createMockUserBook(id: 42);

        when(() => mockRepository.getBookDetail(bookId: 'book-1', source: any(named: 'source')))
            .thenAnswer((_) async => right((bookDetail: bookDetail, userBook: userBook)));

        when(() => mockRepository.updateReadingNote(
              userBookId: 42,
              note: 'note',
            )).thenAnswer((_) async =>
            left(const AuthFailure(message: 'Authentication required')));

        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);
        await notifier.loadBookDetail(source: BookSource.rakuten);

        final result = await notifier.updateReadingNote(
          userBookId: 42,
          note: 'note',
        );

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<AuthFailure>());
      });
    });

    group('updateThoughts', () {
      test('感想更新成功時は ShelfState を更新する', () async {
        final bookDetail = createMockBookDetail();
        final userBook = createMockUserBook(
          id: 42,
          thoughts: null,
        );

        when(() => mockRepository.getBookDetail(bookId: 'book-1', source: any(named: 'source')))
            .thenAnswer((_) async => right((bookDetail: bookDetail, userBook: userBook)));

        final thoughtsUpdatedAt = DateTime(2024, 6, 20);
        final updatedUserBook = createMockUserBook(
          id: 42,
          thoughts: 'Great story!',
          thoughtsUpdatedAt: thoughtsUpdatedAt,
        );
        when(() => mockRepository.updateThoughts(
              userBookId: 42,
              thoughts: 'Great story!',
            )).thenAnswer((_) async => right(updatedUserBook));

        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);
        await notifier.loadBookDetail(source: BookSource.rakuten);

        final result = await notifier.updateThoughts(
          userBookId: 42,
          thoughts: 'Great story!',
        );

        expect(result.isRight(), isTrue);
        final shelfState = container.read(shelfStateProvider);
        expect(shelfState['book-1']!.thoughts, equals('Great story!'));
        expect(shelfState['book-1']!.thoughtsUpdatedAt, equals(thoughtsUpdatedAt));
      });

      test('空文字での感想更新が成功する（感想削除）', () async {
        final bookDetail = createMockBookDetail();
        final userBook = createMockUserBook(
          id: 42,
          thoughts: 'Old thoughts',
        );

        when(() => mockRepository.getBookDetail(bookId: 'book-1', source: any(named: 'source')))
            .thenAnswer((_) async => right((bookDetail: bookDetail, userBook: userBook)));

        final thoughtsUpdatedAt = DateTime(2024, 6, 20);
        final updatedUserBook = createMockUserBook(
          id: 42,
          thoughts: '',
          thoughtsUpdatedAt: thoughtsUpdatedAt,
        );
        when(() => mockRepository.updateThoughts(
              userBookId: 42,
              thoughts: '',
            )).thenAnswer((_) async => right(updatedUserBook));

        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);
        await notifier.loadBookDetail(source: BookSource.rakuten);

        final result = await notifier.updateThoughts(
          userBookId: 42,
          thoughts: '',
        );

        expect(result.isRight(), isTrue);
        final shelfState = container.read(shelfStateProvider);
        expect(shelfState['book-1']!.thoughts, equals(''));
      });

      test('Optimistic update: ShelfState が API呼び出し前に状態を更新する', () async {
        final bookDetail = createMockBookDetail();
        final userBook = createMockUserBook(
          id: 42,
          thoughts: 'Old thoughts',
        );

        when(() => mockRepository.getBookDetail(bookId: 'book-1', source: any(named: 'source')))
            .thenAnswer((_) async => right((bookDetail: bookDetail, userBook: userBook)));

        final thoughtsUpdatedAt = DateTime(2024, 6, 20);
        final updatedUserBook = createMockUserBook(
          id: 42,
          thoughts: 'New thoughts',
          thoughtsUpdatedAt: thoughtsUpdatedAt,
        );

        final completer = Completer<Either<Failure, UserBook>>();
        when(() => mockRepository.updateThoughts(
              userBookId: 42,
              thoughts: 'New thoughts',
            )).thenAnswer((_) => completer.future);

        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);
        await notifier.loadBookDetail(source: BookSource.rakuten);

        // ignore: unawaited_futures
        notifier.updateThoughts(
          userBookId: 42,
          thoughts: 'New thoughts',
        );

        await Future<void>.delayed(Duration.zero);

        final shelfState = container.read(shelfStateProvider);
        expect(shelfState['book-1']?.thoughts, equals('New thoughts'));

        completer.complete(right(updatedUserBook));
      });

      test('更新失敗時は Optimistic update をロールバックする', () async {
        final bookDetail = createMockBookDetail();
        final userBook = createMockUserBook(
          id: 42,
          thoughts: 'Old thoughts',
        );

        when(() => mockRepository.getBookDetail(bookId: 'book-1', source: any(named: 'source')))
            .thenAnswer((_) async => right((bookDetail: bookDetail, userBook: userBook)));

        when(() => mockRepository.updateThoughts(
              userBookId: 42,
              thoughts: 'New thoughts',
            )).thenAnswer((_) async =>
            left(const ServerFailure(message: 'Server error', code: 'ERROR')));

        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);
        await notifier.loadBookDetail(source: BookSource.rakuten);

        final result = await notifier.updateThoughts(
          userBookId: 42,
          thoughts: 'New thoughts',
        );

        expect(result.isLeft(), isTrue);
        final shelfState = container.read(shelfStateProvider);
        expect(shelfState['book-1']!.thoughts, equals('Old thoughts'));
      });

      test('認証エラー時は Left(AuthFailure) を返す', () async {
        final bookDetail = createMockBookDetail();
        final userBook = createMockUserBook(id: 42);

        when(() => mockRepository.getBookDetail(bookId: 'book-1', source: any(named: 'source')))
            .thenAnswer((_) async => right((bookDetail: bookDetail, userBook: userBook)));

        when(() => mockRepository.updateThoughts(
              userBookId: 42,
              thoughts: 'thoughts',
            )).thenAnswer((_) async =>
            left(const AuthFailure(message: 'Authentication required')));

        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);
        await notifier.loadBookDetail(source: BookSource.rakuten);

        final result = await notifier.updateThoughts(
          userBookId: 42,
          thoughts: 'thoughts',
        );

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<AuthFailure>());
      });
    });

    group('updateCompletedAt', () {
      test('読了日更新成功時は ShelfState を更新する', () async {
        final bookDetail = createMockBookDetail();
        final completedAt = DateTime(2024, 6, 20);
        final newCompletedAt = DateTime(2024, 5, 10);
        final userBook = createMockUserBook(
          id: 42,
          readingStatus: ReadingStatus.completed,
          completedAt: completedAt,
        );

        when(() => mockRepository.getBookDetail(bookId: 'book-1', source: any(named: 'source')))
            .thenAnswer((_) async => right((bookDetail: bookDetail, userBook: userBook)));

        final updatedUserBook = createMockUserBook(
          id: 42,
          readingStatus: ReadingStatus.completed,
          completedAt: newCompletedAt,
        );
        when(() => mockRepository.updateCompletedAt(
              userBookId: 42,
              completedAt: newCompletedAt,
            )).thenAnswer((_) async => right(updatedUserBook));

        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);
        await notifier.loadBookDetail(source: BookSource.rakuten);

        final result = await notifier.updateCompletedAt(
          userBookId: 42,
          completedAt: newCompletedAt,
        );

        expect(result.isRight(), isTrue);
        final shelfState = container.read(shelfStateProvider);
        expect(shelfState['book-1']!.completedAt, equals(newCompletedAt));
      });

      test('本棚に未登録の場合は Left(UnexpectedFailure) を返す', () async {
        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);

        final result = await notifier.updateCompletedAt(
          userBookId: 42,
          completedAt: DateTime(2024, 5, 10),
        );

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<UnexpectedFailure>());
      });

      test('更新失敗時は Optimistic update をロールバックする', () async {
        final bookDetail = createMockBookDetail();
        final completedAt = DateTime(2024, 6, 20);
        final userBook = createMockUserBook(
          id: 42,
          readingStatus: ReadingStatus.completed,
          completedAt: completedAt,
        );

        when(() => mockRepository.getBookDetail(bookId: 'book-1', source: any(named: 'source')))
            .thenAnswer((_) async => right((bookDetail: bookDetail, userBook: userBook)));

        when(() => mockRepository.updateCompletedAt(
              userBookId: 42,
              completedAt: any(named: 'completedAt'),
            )).thenAnswer((_) async =>
            left(const ServerFailure(message: 'Server error', code: 'ERROR')));

        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);
        await notifier.loadBookDetail(source: BookSource.rakuten);

        final result = await notifier.updateCompletedAt(
          userBookId: 42,
          completedAt: DateTime(2024, 5, 10),
        );

        expect(result.isLeft(), isTrue);
        final shelfState = container.read(shelfStateProvider);
        expect(shelfState['book-1']!.completedAt, equals(completedAt));
      });
    });

    group('updateStartedAt', () {
      test('読書開始日更新成功時は ShelfState を更新する', () async {
        final bookDetail = createMockBookDetail();
        final startedAt = DateTime(2024, 3, 15);
        final newStartedAt = DateTime(2024, 4, 1);
        final userBook = createMockUserBook(
          id: 42,
          readingStatus: ReadingStatus.reading,
          startedAt: startedAt,
        );

        when(() => mockRepository.getBookDetail(bookId: 'book-1', source: any(named: 'source')))
            .thenAnswer((_) async => right((bookDetail: bookDetail, userBook: userBook)));

        final updatedUserBook = createMockUserBook(
          id: 42,
          readingStatus: ReadingStatus.reading,
          startedAt: newStartedAt,
        );
        when(() => mockRepository.updateStartedAt(
              userBookId: 42,
              startedAt: newStartedAt,
            )).thenAnswer((_) async => right(updatedUserBook));

        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);
        await notifier.loadBookDetail(source: BookSource.rakuten);

        final result = await notifier.updateStartedAt(
          userBookId: 42,
          startedAt: newStartedAt,
        );

        expect(result.isRight(), isTrue);
        final shelfState = container.read(shelfStateProvider);
        expect(shelfState['book-1']!.startedAt, equals(newStartedAt));
      });

      test('本棚に未登録の場合は Left(UnexpectedFailure) を返す', () async {
        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);

        final result = await notifier.updateStartedAt(
          userBookId: 42,
          startedAt: DateTime(2024, 4, 1),
        );

        expect(result.isLeft(), isTrue);
        expect(result.getLeft().toNullable(), isA<UnexpectedFailure>());
      });

      test('更新失敗時は Optimistic update をロールバックする', () async {
        final bookDetail = createMockBookDetail();
        final startedAt = DateTime(2024, 3, 15);
        final userBook = createMockUserBook(
          id: 42,
          readingStatus: ReadingStatus.reading,
          startedAt: startedAt,
        );

        when(() => mockRepository.getBookDetail(bookId: 'book-1', source: any(named: 'source')))
            .thenAnswer((_) async => right((bookDetail: bookDetail, userBook: userBook)));

        when(() => mockRepository.updateStartedAt(
              userBookId: 42,
              startedAt: any(named: 'startedAt'),
            )).thenAnswer((_) async =>
            left(const ServerFailure(message: 'Server error', code: 'ERROR')));

        final notifier =
            container.read(bookDetailNotifierProvider('book-1').notifier);
        await notifier.loadBookDetail(source: BookSource.rakuten);

        final result = await notifier.updateStartedAt(
          userBookId: 42,
          startedAt: DateTime(2024, 4, 1),
        );

        expect(result.isLeft(), isTrue);
        final shelfState = container.read(shelfStateProvider);
        expect(shelfState['book-1']!.startedAt, equals(startedAt));
      });
    });

    group('bookDetailNotifierProvider (family)', () {
      test('異なる externalId で異なる Provider インスタンスを取得できる', () async {
        final bookDetail1 = createMockBookDetail(id: 'book-1', title: 'Book 1');
        final bookDetail2 = createMockBookDetail(id: 'book-2', title: 'Book 2');

        when(() => mockRepository.getBookDetail(bookId: 'book-1', source: any(named: 'source')))
            .thenAnswer((_) async => right((bookDetail: bookDetail1, userBook: null)));
        when(() => mockRepository.getBookDetail(bookId: 'book-2', source: any(named: 'source')))
            .thenAnswer((_) async => right((bookDetail: bookDetail2, userBook: null)));

        final notifier1 =
            container.read(bookDetailNotifierProvider('book-1').notifier);
        final notifier2 =
            container.read(bookDetailNotifierProvider('book-2').notifier);

        await notifier1.loadBookDetail(source: BookSource.rakuten);
        await notifier2.loadBookDetail(source: BookSource.rakuten);

        final state1 = container.read(bookDetailNotifierProvider('book-1'));
        final state2 = container.read(bookDetailNotifierProvider('book-2'));

        expect(state1.value!.title, equals('Book 1'));
        expect(state2.value!.title, equals('Book 2'));
      });

      test('同じ externalId で同じ Provider インスタンスを取得する', () {
        final provider1 = bookDetailNotifierProvider('book-1');
        final provider2 = bookDetailNotifierProvider('book-1');

        expect(provider1, equals(provider2));
      });
    });
  });
}
