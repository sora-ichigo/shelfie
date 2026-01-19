# Database Migration Guide

Drizzle Kit によるマイグレーション運用ガイド

## コマンド一覧

| コマンド | 用途 |
|---------|------|
| `pnpm db:generate` | スキーマ変更からマイグレーションファイルを生成 |
| `pnpm db:migrate` | マイグレーションを実行（本番向け） |
| `pnpm db:push` | スキーマを直接同期（開発時のみ） |
| `pnpm db:studio` | Drizzle Studio（データブラウザ）を起動 |
| `pnpm db:seed` | シードデータを投入 |

## 開発時のワークフロー

### スキーマ変更の手順

1. `src/db/schema/` 内のスキーマファイルを編集
2. 開発環境では `pnpm db:push` でスキーマを同期

```bash
pnpm db:push
```

3. 変更が完了したらマイグレーションファイルを生成

```bash
pnpm db:generate
```

4. 生成されたファイルを確認し、必要に応じて編集

## 本番環境へのマイグレーション

### デプロイフロー

1. **PR/コードレビュー**: マイグレーションファイルをコードレビュー
2. **ステージング環境でテスト**: マイグレーションを適用してテスト
3. **本番デプロイ**: CI/CD パイプラインでマイグレーションを実行

### マイグレーション実行

```bash
DATABASE_URL=<production-url> pnpm db:migrate
```

### トランザクション管理

Drizzle Kit は各マイグレーションファイルをトランザクション内で実行します。
マイグレーションが失敗した場合、そのファイル内の変更は自動的にロールバックされます。

## ロールバック手順

Drizzle Kit には自動ロールバック機能がないため、手動でロールバックする必要があります。

### ロールバック手順

1. **ロールバック用 SQL を作成**

```sql
-- 例: カラムの追加をロールバック
ALTER TABLE users DROP COLUMN IF EXISTS new_column;
```

2. **データベースに直接適用**

```bash
psql $DATABASE_URL -f rollback.sql
```

3. **マイグレーション履歴を更新**

```bash
psql $DATABASE_URL -c "DELETE FROM drizzle.__drizzle_migrations WHERE id = '<migration_id>';"
```

4. **マイグレーションファイルを削除または修正**

### 予防策

- 本番適用前にステージング環境で必ずテスト
- 破壊的変更（DROP TABLE, DROP COLUMN）は特に慎重に
- 大量データの変更はダウンタイムを考慮

## シードデータ管理

### シードデータの構造

シードデータは `src/db/seed.ts` で管理します。

```typescript
export const seedData = {
  users: [
    { email: "admin@example.com" },
    { email: "user@example.com" },
  ],
};
```

### シードの実行

```bash
pnpm db:seed
```

### 本番環境でのシード

本番環境でシードを実行する場合は、既存データとの重複を確認するロジックが必要です。
`seed()` 関数は既存データをスキップするように実装されています。

## ベストプラクティス

### DO

- スキーマ変更は小さく、段階的に
- カラム追加時はまず nullable で追加し、後から NOT NULL 制約を追加
- インデックス追加は CONCURRENTLY オプションを使用（可能な場合）
- マイグレーションファイルは必ずバージョン管理に含める

### DON'T

- 本番環境で `db:push` を使用しない
- 複数の破壊的変更を1つのマイグレーションにまとめない
- マイグレーション履歴を手動で改ざんしない（ロールバック時を除く）
- 適用済みマイグレーションファイルを編集しない
