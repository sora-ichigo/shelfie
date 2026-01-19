# Shelfie Mobile App

Shelfie のモバイルアプリケーション。Flutter を使用した iOS/Android クロスプラットフォームアプリ。

## 目次

- [アーキテクチャ概要](#アーキテクチャ概要)
- [ディレクトリ構成](#ディレクトリ構成)
- [各レイヤーの責務](#各レイヤーの責務)
- [主要ライブラリ](#主要ライブラリ)
- [開発ガイド](#開発ガイド)

## アーキテクチャ概要

Feature-first + Clean Architecture パターンを採用。機能単位でモジュール化し、各機能内を presentation/application/domain/infrastructure の 4 層に分離する。

```
┌────────────────────────────────────────────────────────┐
│                      App Layer                         │
│  (main.dart, ShelfieApp, ProviderScope)               │
├────────────────────────────────────────────────────────┤
│                    Routing Layer                       │
│  (AppRouter, Route Guards, DeepLink handling)         │
├────────────────────────────────────────────────────────┤
│                    Feature Modules                     │
│  ┌─────────────────────────────────────────────────┐  │
│  │  Feature X                                      │  │
│  │  ┌─────────────┐  ┌─────────────────────────┐  │  │
│  │  │ Presentation│──│ Application (UseCases)  │  │  │
│  │  └─────────────┘  └─────────────────────────┘  │  │
│  │         │                    │                 │  │
│  │         ▼                    ▼                 │  │
│  │  ┌─────────────────────────────────────────┐  │  │
│  │  │         Domain (Models, Interfaces)     │  │  │
│  │  └─────────────────────────────────────────┘  │  │
│  │                      ▲                        │  │
│  │                      │                        │  │
│  │  ┌─────────────────────────────────────────┐  │  │
│  │  │  Infrastructure (Repositories, APIs)    │  │  │
│  │  └─────────────────────────────────────────┘  │  │
│  └─────────────────────────────────────────────────┘  │
├────────────────────────────────────────────────────────┤
│                      Core Layer                        │
│  (Theme, Widgets, Error Handling, Network, Utils)     │
└────────────────────────────────────────────────────────┘
```

### 設計原則

- **依存関係の方向**: 外側から内側へ。Infrastructure は Domain に依存するが、Domain は外部に依存しない
- **機能の独立性**: 各機能モジュールは独立してテスト・開発可能
- **状態管理の一貫性**: Riverpod による統一的な状態管理と依存性注入

## ディレクトリ構成

```
lib/
├── main.dart                    # エントリポイント
├── app/                         # アプリケーション設定
│   ├── app.dart                 # ShelfieApp ルートウィジェット
│   └── providers.dart           # ルートレベル Provider
├── core/                        # 共通コンポーネント
│   ├── error/                   # エラーハンドリング
│   │   ├── failure.dart         # Failure 型階層
│   │   └── error_handler.dart   # グローバルエラーハンドラ
│   ├── network/                 # ネットワーク設定
│   │   └── ferry_client.dart    # Ferry GraphQL クライアント
│   ├── repository/              # リポジトリ基盤
│   │   └── base_repository.dart # BaseRepository
│   ├── theme/                   # テーマ設定
│   │   ├── app_theme.dart       # ThemeData 定義
│   │   ├── app_colors.dart      # カスタムカラー
│   │   ├── app_typography.dart  # タイポグラフィ
│   │   └── app_spacing.dart     # スペーシング定数
│   ├── widgets/                 # 共通ウィジェット
│   │   ├── loading_indicator.dart
│   │   ├── error_view.dart
│   │   └── empty_state.dart
│   └── utils/                   # ユーティリティ
│       ├── extensions/
│       └── helpers/
├── routing/                     # ルーティング
│   ├── app_router.dart          # GoRouter 設定
│   └── route_guards.dart        # ルートガード
└── features/                    # 機能モジュール
    └── [feature_name]/
        ├── presentation/        # UI 層
        │   ├── screens/
        │   ├── widgets/
        │   └── providers/
        ├── application/         # アプリケーション層
        │   ├── use_cases/
        │   └── services/
        ├── domain/              # ドメイン層
        │   ├── models/
        │   ├── entities/
        │   └── repositories/    # インターフェース
        └── infrastructure/      # インフラ層
            ├── repositories/    # 実装
            ├── data_sources/
            └── dtos/

test/
├── unit/                        # ユニットテスト
├── widget/                      # ウィジェットテスト
└── integration/                 # インテグレーションテスト
```

## 各レイヤーの責務

### Presentation Layer

UI の表示とユーザー入力の処理を担当。

| コンポーネント | 責務 |
|--------------|------|
| Screens | 画面全体のレイアウトと状態の監視 |
| Widgets | 再利用可能な UI コンポーネント |
| Providers | UI 状態の管理（StateNotifier, AsyncNotifier） |

**実装パターン**:
```dart
// ConsumerWidget で Provider を監視
class BookListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(booksProvider);

    return booksAsync.when(
      data: (books) => BookListView(books: books),
      loading: () => const LoadingIndicator(),
      error: (error, _) => ErrorView(failure: error as Failure),
    );
  }
}
```

### Application Layer

ユースケースの実行とビジネスロジックの調整を担当。

| コンポーネント | 責務 |
|--------------|------|
| UseCases | 単一のビジネス操作をカプセル化 |
| Services | 複数の Repository を協調させる |

**実装パターン**:
```dart
class GetBookUseCase {
  GetBookUseCase(this._bookRepository);

  final BookRepository _bookRepository;

  Future<Either<Failure, Book>> execute(String bookId) {
    return _bookRepository.getBook(bookId);
  }
}
```

### Domain Layer

ビジネスルールとエンティティを定義。外部依存を持たない純粋な Dart コード。

| コンポーネント | 責務 |
|--------------|------|
| Models | freezed によるイミュータブルデータクラス |
| Entities | ビジネスエンティティの定義 |
| Repositories | データアクセスのインターフェース定義 |

**実装パターン**:
```dart
@freezed
class Book with _$Book {
  const factory Book({
    required String id,
    required String title,
    required String author,
    String? isbn,
  }) = _Book;
}

abstract class BookRepository {
  Future<Either<Failure, Book>> getBook(String id);
  Future<Either<Failure, List<Book>>> getBooks();
}
```

### Infrastructure Layer

外部システムとの連携とデータ永続化を担当。

| コンポーネント | 責務 |
|--------------|------|
| Repositories | Domain Repository の実装 |
| DataSources | API やローカル DB へのアクセス |
| DTOs | 外部データ形式との変換 |

**実装パターン**:
```dart
class BookRepositoryImpl extends BaseRepository implements BookRepository {
  BookRepositoryImpl(super.client);

  @override
  Future<Either<Failure, Book>> getBook(String id) {
    return executeQuery(GGetBookReq((b) => b..vars.id = id))
        .then((result) => result.map((data) => data.book.toDomain()));
  }
}
```

## 主要ライブラリ

### 状態管理: Riverpod

```dart
// Provider の定義（riverpod_annotation を使用）
@riverpod
class BooksNotifier extends _$BooksNotifier {
  @override
  Future<List<Book>> build() async {
    return ref.watch(bookRepositoryProvider).getBooks();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() =>
      ref.read(bookRepositoryProvider).getBooks()
    );
  }
}

// 選択的リビルドの最適化
final bookTitle = ref.watch(
  bookProvider(bookId).select((book) => book.title),
);
```

### ルーティング: go_router

```dart
// ルート定義
GoRoute(
  path: '/books/:bookId',
  builder: (context, state) {
    final bookId = state.pathParameters['bookId']!;
    return BookDetailScreen(bookId: bookId);
  },
),

// ナビゲーション
context.go('/books/123');
context.push('/books/123');

// 認証ガード
redirect: (context, state) {
  final isAuthenticated = ref.read(authStateProvider).isAuthenticated;
  if (!isAuthenticated && !state.matchedLocation.startsWith('/auth')) {
    return '/auth/login';
  }
  return null;
},
```

### データモデリング: freezed

```dart
@freezed
class Book with _$Book {
  const factory Book({
    required String id,
    required String title,
    @Default('') String author,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}
```

### GraphQL: Ferry

```dart
// クエリの実行
final response = await client.request(GGetBooksReq()).first;

// Either でのエラーハンドリング
Future<Either<Failure, List<Book>>> getBooks() {
  return executeQuery(GGetBooksReq())
      .then((result) => result.map((data) =>
        data.books.map((b) => b.toDomain()).toList()
      ));
}
```

### エラーハンドリング: fpdart Either

```dart
// Either の使用
final result = await bookRepository.getBook(id);

result.fold(
  (failure) => showError(failure.userMessage),
  (book) => showBook(book),
);

// パターンマッチング
result.match(
  (failure) => switch (failure) {
    NetworkFailure() => showRetryDialog(),
    AuthFailure() => navigateToLogin(),
    _ => showGenericError(),
  },
  (book) => displayBook(book),
);
```

## 開発ガイド

### セットアップ

```bash
# 依存関係のインストール
flutter pub get

# コード生成（freezed, riverpod_generator, ferry_generator）
dart run build_runner build --delete-conflicting-outputs

# または watch モード
dart run build_runner watch --delete-conflicting-outputs
```

### テスト

```bash
# 全テスト実行
flutter test

# カバレッジ付きテスト
flutter test --coverage

# 特定のテストファイル
flutter test test/unit/core/error/failure_test.dart

# インテグレーションテスト
flutter test integration_test/
```

### コマンド

```bash
# Lint チェック
flutter analyze

# フォーマット
dart format .

# GraphQL スキーマの取得とコード生成
# (API サーバーが起動している場合)
# 設定は build.yaml を参照
```

### 新機能の追加手順

1. `lib/features/[feature_name]/` ディレクトリを作成
2. 4 層構造（presentation, application, domain, infrastructure）を作成
3. Domain 層でモデルとリポジトリインターフェースを定義
4. Infrastructure 層でリポジトリを実装
5. Application 層でユースケースを定義
6. Presentation 層で UI と Provider を実装
7. テストを作成
