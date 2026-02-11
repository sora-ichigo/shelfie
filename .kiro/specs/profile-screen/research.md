# Research & Design Decisions

---
**Purpose**: プロフィール画面機能の設計判断に関する調査結果と根拠を記録する。
---

## Summary
- **Feature**: `profile-screen`
- **Discovery Scope**: Extension（既存システムの拡張）
- **Key Findings**:
  - 既存の `UserProfile` エンティティと `AccountRepository` を拡張してステータス別冊数を取得可能
  - GraphQL User 型に4つのステータス別カウントフィールドを追加する方式が既存パターン（`bookCount`）に整合
  - 要件の「droppedCount / 読まない」は実際のシステムでは `interested / 気になる` に対応する（`DROP` ステータスは deprecated 済み）

## Research Log

### 既存アーキテクチャの統合ポイント分析

- **Context**: プロフィール画面は既存のアカウント機能と本棚機能を横断する。統合方式を確認する必要がある。
- **Sources Consulted**: `apps/mobile/lib/features/account/`, `apps/api/src/features/users/`, `apps/api/src/features/books/`
- **Findings**:
  - API 側: `bookCount` は `UserRef.implement()` 内で `bookShelfRepository.countUserBooks()` を呼び出すリゾルバとして実装済み。同パターンでステータス別カウントを追加可能。
  - Mobile 側: `AccountNotifier` が `shelfVersionProvider` を `ref.watch` しており、本棚変更時に自動再取得される。新しいプロフィール用 Notifier も同パターンを踏襲すべき。
  - `AccountRepository.getMyProfile()` は `FetchPolicy.NetworkOnly` を使用。ステータス別冊数も Mutation で変動するため同ポリシーが適切。
- **Implications**: 新規の feature モジュール（`features/profile/`）を作成し、既存の account feature とは分離する。ただし、account の `UserProfile` エンティティを拡張してステータス別冊数を含める。

### ReadingStatus の要件と実装の不一致

- **Context**: 要件では「droppedCount / 読まない」が指定されているが、実際のシステムでは異なるステータス名を使用している。
- **Sources Consulted**: `apps/api/src/db/schema/books.ts`, `apps/mobile/lib/features/book_detail/domain/reading_status.dart`, GraphQL スキーマ
- **Findings**:
  - DB の `reading_status` enum: `backlog`, `reading`, `completed`, `interested`
  - GraphQL の `ReadingStatus` enum: `BACKLOG`, `READING`, `COMPLETED`, `INTERESTED`（`DROP` は deprecated）
  - Mobile の `ReadingStatus` enum: `backlog`, `reading`, `completed`, `interested`
  - 「読まない」は存在せず、「気になる」（`interested`）が対応するステータス
- **Implications**: 設計では実際のシステムに合わせて `interestedCount` を使用する。要件の「droppedCount」は `interestedCount` として実装する。

### ShelfVersion 連動パターン

- **Context**: プロフィール画面のステータス別冊数は本棚操作で変動するため、ShelfVersion による状態伝播が必要。
- **Sources Consulted**: `apps/mobile/lib/core/state/shelf_version.dart`, `mobile-tech.md` steering
- **Findings**:
  - `ShelfVersion` は `keepAlive: true` な int カウンター。`addToShelf`, `removeFromShelf`, `updateReadingStatus` 成功時に increment。
  - `AccountNotifier` は `ref.watch(shelfVersionProvider)` で自動再取得。
  - 新しい `ProfileNotifier` も同パターンで `ref.watch(shelfVersionProvider)` を使用すべき（Async Provider のため）。
- **Implications**: ProfileNotifier は AccountNotifier と同様に ShelfVersion を watch し、本棚変更時にステータス別冊数を自動更新する。

### Ferry キャッシュポリシー

- **Context**: プロフィールクエリのキャッシュポリシーを決定する必要がある。
- **Sources Consulted**: `mobile-tech.md` steering, `AccountRepository`
- **Findings**:
  - ステータス別冊数は Mutation（addToShelf, removeFromShelf, updateReadingStatus）で変動する
  - `AccountRepository.getMyProfile()` は既に `NetworkOnly` を使用
  - ShelfVersion 経由の再取得が正しく機能するには `NetworkOnly` が必須
- **Implications**: 新しいプロフィールクエリも `FetchPolicy.NetworkOnly` を使用する。

## Architecture Pattern Evaluation

| Option | Description | Strengths | Risks / Limitations | Notes |
|--------|-------------|-----------|---------------------|-------|
| 既存 account feature を拡張 | AccountNotifier にステータス別冊数を追加 | 変更が最小限 | account feature の責務が肥大化、Phase 2 での再利用が困難 | 不採用 |
| 新規 profile feature を作成 | 独立した feature モジュールで Profile 機能を実装 | 責務が明確、Phase 2 で userId パラメータ対応が容易 | 既存の UserProfile エンティティとの重複 | **採用** |

## Design Decisions

### Decision: profile feature の独立モジュール化

- **Context**: プロフィール画面は account feature と関連するが、Phase 2 で友達プロフィール表示を予定しており、userId パラメータによる汎用化が必要。
- **Alternatives Considered**:
  1. account feature を拡張 -- 変更は最小だが、account は設定画面としての責務があり、プロフィール表示は別の関心事。
  2. 新規 profile feature を作成 -- feature-first アーキテクチャに沿い、独立した関心事として管理。
- **Selected Approach**: 新規 `features/profile/` モジュールを作成。ただし、`UserProfile` エンティティは account feature の既存定義を拡張して使用する。
- **Rationale**: Phase 2 で他ユーザーのプロフィール取得が必要になった際に、profile feature 内で完結する。account feature は設定画面に集中。
- **Trade-offs**: 短期的にはファイル数が増えるが、長期的な保守性と拡張性が向上。
- **Follow-up**: Phase 2 で userId パラメータを受け取る GraphQL クエリの追加が必要。

### Decision: ステータス別冊数のフィールド名を interestedCount に変更

- **Context**: 要件では `droppedCount` だが、実システムの `DROP` は deprecated 済みで `INTERESTED` に置換されている。
- **Selected Approach**: `interestedCount` を使用し、要件 4.4 を `interestedCount` として実装。
- **Rationale**: 実際の DB スキーマと GraphQL スキーマに整合させる。
- **Follow-up**: requirements.md の記述を更新する必要はない（設計段階で吸収）。

## Risks & Mitigations

- **Risk**: GraphQL クエリに4つのカウントフィールドを追加すると、各フィールドが独立した COUNT クエリを発行し N+1 に類似したパフォーマンス問題が発生する可能性がある。
  - **Mitigation**: 1つの SQL クエリで全ステータスの COUNT を GROUP BY で取得する `countUserBooksByStatus` メソッドを実装し、リゾルバ間で結果を共有する。
- **Risk**: ProfileNotifier と AccountNotifier が同じ ShelfVersion を watch するため、本棚変更時に2つの API リクエストが発生する。
  - **Mitigation**: 許容範囲として扱う。将来的に統合が必要な場合は AccountNotifier のプロフィール取得を ProfileNotifier に委譲する。

## References

- [Pothos GraphQL - Object Types](https://pothos-graphql.dev/docs/guide/objects) -- User 型へのフィールド追加パターン
- [Riverpod - Notifier Provider](https://riverpod.dev/docs/essentials/side_effects) -- Async Notifier パターン
- [Ferry GraphQL Client](https://ferrygraphql.com/docs/queries) -- クエリ定義と FetchPolicy
