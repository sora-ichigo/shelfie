# コーディング規約とベストプラクティス

Shelfie モバイルアプリケーションの開発における規約とガイドライン。

## 目次

- [Lint ルール](#lint-ルール)
- [Riverpod の使用パターン](#riverpod-の使用パターン)
- [freezed の使用パターン](#freezed-の使用パターン)
- [go_router の使用パターン](#go_router-の使用パターン)
- [Ferry の使用パターン](#ferry-の使用パターン)
- [エラーハンドリング](#エラーハンドリング)

## Lint ルール

### 基本設定

`very_good_analysis` をベースに、厳格な静的解析を有効化。

```yaml
# analysis_options.yaml
include: package:very_good_analysis/analysis_options.yaml

analyzer:
  language:
    strict-casts: true      # 暗黙的なキャストを禁止
    strict-inference: true  # 型推論の厳格化
    strict-raw-types: true  # 生の型を禁止
```

### 推奨ルール

| ルール | 説明 |
|-------|------|
| `prefer_const_constructors` | 可能な限り const コンストラクタを使用 |
| `prefer_single_quotes` | シングルクォートを優先 |
| `always_use_package_imports` | 相対インポートではなくパッケージインポートを使用 |
| `unawaited_futures` | 待機していない Future を警告 |
| `avoid_void_async` | void async 関数を避ける |

### 除外設定

生成ファイルは解析対象から除外:

```yaml
exclude:
  - "**/*.g.dart"
  - "**/*.freezed.dart"
  - "**/*.gr.dart"
```

## Riverpod の使用パターン

### Provider の定義

`riverpod_annotation` を使用したコード生成ベースの定義を推奨。

```dart
// Good: annotation ベース
@riverpod
class BooksNotifier extends _$BooksNotifier {
  @override
  Future<List<Book>> build() async {
    return _fetchBooks();
  }
}

// Avoid: 手動定義（特別な理由がない限り）
final booksProvider = StateNotifierProvider<BooksNotifier, AsyncValue<List<Book>>>(...);
```

### keepAlive の使用

アプリ全体で共有する状態には `keepAlive: true` を設定:

```dart
// 認証状態: アプリ全体で永続化
@Riverpod(keepAlive: true)
class AuthStateNotifier extends _$AuthStateNotifier {
  @override
  AuthState build() => const AuthState();
}

// 画面固有の状態: autoDispose（デフォルト）
@riverpod
class BookDetailNotifier extends _$BookDetailNotifier {
  @override
  Future<Book> build(String bookId) async {
    return ref.watch(bookRepositoryProvider).getBook(bookId);
  }
}
```

### 選択的リビルドの最適化

`select` を使用して必要なフィールドのみを監視:

```dart
// Bad: 全体を監視（不要なリビルドが発生）
final user = ref.watch(userProvider);
final name = user.name;

// Good: 必要なフィールドのみを監視
final name = ref.watch(userProvider.select((u) => u.name));

// Good: 複数フィールドが必要な場合は Record を使用
final (name, email) = ref.watch(
  userProvider.select((u) => (u.name, u.email)),
);
```

### Provider の依存関係

Provider 間の依存関係は `ref.watch` で明示的に定義:

```dart
@riverpod
BookRepository bookRepository(BookRepositoryRef ref) {
  final client = ref.watch(ferryClientProvider);
  return BookRepositoryImpl(client);
}

@riverpod
Future<List<Book>> books(BooksRef ref) async {
  final repository = ref.watch(bookRepositoryProvider);
  final result = await repository.getBooks();
  return result.fold(
    (failure) => throw failure,
    (books) => books,
  );
}
```

### AsyncValue のハンドリング

`when` または `whenOrNull` を使用して状態をハンドリング:

```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  final booksAsync = ref.watch(booksProvider);

  return booksAsync.when(
    data: (books) => BookListView(books: books),
    loading: () => const LoadingIndicator(),
    error: (error, stack) => ErrorView(
      failure: error is Failure ? error : UnexpectedFailure(message: '$error'),
      onRetry: () => ref.invalidate(booksProvider),
    ),
  );
}
```

## freezed の使用パターン

### 基本的なモデル定義

```dart
@freezed
class Book with _$Book {
  const factory Book({
    required String id,
    required String title,
    required String author,
    @Default('') String description,
    DateTime? publishedAt,
  }) = _Book;

  // JSON シリアライゼーションが必要な場合
  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}
```

### sealed class によるエラー型

exhaustive パターンマッチングを強制:

```dart
@freezed
sealed class Failure with _$Failure {
  const Failure._();

  const factory Failure.network({required String message}) = NetworkFailure;
  const factory Failure.server({
    required String message,
    required String code,
  }) = ServerFailure;
  const factory Failure.auth({required String message}) = AuthFailure;
  const factory Failure.validation({
    required String message,
    Map<String, String>? fieldErrors,
  }) = ValidationFailure;
  const factory Failure.unexpected({
    required String message,
    StackTrace? stackTrace,
  }) = UnexpectedFailure;

  // 共通メソッド
  String get userMessage => when(
    network: (_) => 'ネットワーク接続を確認してください',
    server: (_, __) => 'サーバーエラーが発生しました',
    auth: (_) => '再度ログインしてください',
    validation: (msg, _) => msg,
    unexpected: (_, __) => '予期しないエラーが発生しました',
  );
}
```

### copyWith の使用

イミュータブルな更新には `copyWith` を使用:

```dart
final updatedBook = book.copyWith(
  title: 'New Title',
  author: book.author, // 変更なし
);
```

## go_router の使用パターン

### ルートパスの一元管理

```dart
abstract final class AppRoutes {
  static const home = '/';
  static const login = '/auth/login';
  static const bookDetail = '/books/:bookId';

  // パラメータ付きパスの生成
  static String bookDetailPath({required String bookId}) => '/books/$bookId';
}
```

### 型安全なパラメータ

```dart
class BookDetailParams {
  const BookDetailParams({required this.bookId});

  factory BookDetailParams.fromState({
    required Map<String, String> pathParameters,
  }) {
    final bookId = pathParameters['bookId'];
    if (bookId == null || bookId.isEmpty) {
      throw ArgumentError('bookId is required');
    }
    return BookDetailParams(bookId: bookId);
  }

  final String bookId;
}
```

### ShellRoute によるタブナビゲーション

```dart
ShellRoute(
  builder: (context, state, child) => MainShell(child: child),
  routes: [
    GoRoute(
      path: AppRoutes.homeTab,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: HomeScreen(),
      ),
    ),
    // 他のタブ...
  ],
),
```

### 認証ガード

```dart
redirect: (context, state) {
  final isAuthenticated = ref.read(authStateProvider).isAuthenticated;
  final isAuthRoute = state.matchedLocation.startsWith('/auth');

  if (!isAuthenticated && !isAuthRoute) {
    return AppRoutes.login;
  }
  if (isAuthenticated && isAuthRoute) {
    return AppRoutes.home;
  }
  return null;
},
```

### ディープリンク対応

```dart
GoRouter(
  // ...
  onException: (context, state, router) {
    // 不正な URL へのフォールバック
    router.go(AppRoutes.error);
  },
)
```

## Ferry の使用パターン

### クライアント設定

```dart
@Riverpod(keepAlive: true)
Client ferryClient(FerryClientRef ref) {
  final endpoint = ref.watch(apiEndpointProvider);
  final authToken = ref.watch(authTokenProvider);
  final cache = ref.watch(ferryCacheProvider);

  final httpLink = HttpLink(
    endpoint,
    defaultHeaders: {
      if (authToken != null) 'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json',
    },
  );

  return Client(
    link: httpLink,
    cache: cache,
    defaultFetchPolicies: {
      OperationType.query: FetchPolicy.CacheFirst,
      OperationType.mutation: FetchPolicy.NetworkOnly,
    },
  );
}
```

### BaseRepository での使用

```dart
class BookRepositoryImpl extends BaseRepository implements BookRepository {
  BookRepositoryImpl(super.client);

  @override
  Future<Either<Failure, Book>> getBook(String id) async {
    final request = GGetBookReq((b) => b..vars.id = id);
    return executeQuery(request).then((result) =>
      result.map((data) => data.book.toDomain()),
    );
  }

  @override
  Future<Either<Failure, Book>> createBook(CreateBookInput input) async {
    final request = GCreateBookReq((b) => b..vars.input = input.toGql());
    return executeMutation(request).then((result) =>
      result.map((data) => data.createBook.toDomain()),
    );
  }
}
```

### キャッシュ戦略

| FetchPolicy | 使用ケース |
|------------|----------|
| `CacheFirst` | 読み取り専用データ（デフォルトのクエリ） |
| `NetworkOnly` | ミューテーション、最新データが必須の場合 |
| `CacheAndNetwork` | リアルタイム性が求められるが、初期表示は速くしたい場合 |

## エラーハンドリング

### Failure 型の使用

全てのエラーは `Failure` 型で表現:

```dart
// Repository 層
Future<Either<Failure, Book>> getBook(String id) async {
  try {
    final response = await _client.request(request).first;

    if (response.hasErrors) {
      return left(ServerFailure(
        message: response.graphqlErrors?.first.message ?? 'Unknown error',
        code: 'GRAPHQL_ERROR',
      ));
    }

    return right(response.data!.book.toDomain());
  } on SocketException {
    return left(const NetworkFailure(message: 'No internet connection'));
  } on TimeoutException {
    return left(const NetworkFailure(message: 'Request timeout'));
  } catch (e) {
    return left(UnexpectedFailure(message: e.toString()));
  }
}
```

### Either のハンドリング

```dart
// fold を使用
final result = await bookRepository.getBook(id);
result.fold(
  (failure) => showSnackBar(failure.userMessage),
  (book) => navigateToDetail(book),
);

// match を使用（より関数的）
final message = result.match(
  (failure) => failure.userMessage,
  (book) => 'Loaded: ${book.title}',
);

// getOrElse でデフォルト値
final book = result.getOrElse((failure) => Book.empty());
```

### エラータイプ別の処理

```dart
void handleError(Failure failure) {
  switch (failure) {
    case NetworkFailure():
      showRetryDialog();
    case AuthFailure():
      navigateToLogin();
    case ValidationFailure(fieldErrors: final errors?):
      showFieldErrors(errors);
    case ServerFailure(code: 'NOT_FOUND'):
      showNotFoundMessage();
    default:
      showGenericError(failure.userMessage);
  }
}
```

### グローバルエラーハンドラ

未処理のエラーは `ErrorHandler` でキャッチ:

```dart
// main.dart
void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      // ...
      runApp(ProviderScope(child: const App()));
    },
    (error, stackTrace) {
      debugPrint('[FATAL] Unhandled error: $error');
    },
  );
}

// ErrorHandler の初期化
class _AppInitializerState extends ConsumerState<_AppInitializer> {
  @override
  void initState() {
    super.initState();
    final errorHandler = ref.read(errorHandlerProvider);
    errorHandler.initialize();
  }
}
```

### UI でのエラー表示

```dart
// ErrorView ウィジェットを使用
ErrorView(
  failure: failure,
  onRetry: () => ref.invalidate(dataProvider),
  retryButtonText: '再試行',
)

// Failure タイプに応じたアイコンと色
// - NetworkFailure: wifi_off, warning color
// - ServerFailure: cloud_off, error color
// - AuthFailure: lock_outline, warning color
// - ValidationFailure: warning_amber_outlined, warning color
// - UnexpectedFailure: error_outline, error color
```

## 命名規約

### ファイル名

- スネークケース: `book_repository.dart`
- 生成ファイルは自動的に `*.g.dart`, `*.freezed.dart`

### クラス名

- パスカルケース: `BookRepository`, `GetBookUseCase`
- Provider は `*Provider` サフィックス: `bookRepositoryProvider`
- Notifier は `*Notifier` サフィックス: `AuthStateNotifier`

### 変数名

- キャメルケース: `bookId`, `isLoading`
- プライベートは `_` プレフィックス: `_client`
- 定数は lowerCamelCase: `defaultTimeout`

### ディレクトリ名

- スネークケース: `book_detail`, `error_handling`
