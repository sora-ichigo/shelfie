# Library Ecosystem Guidelines

本ドキュメントは、ライブラリエコシステムの活用に関するガイドラインを定義する。

## 原則: 車輪の再発明を避ける

ライブラリを使用する際は、そのエコシステム（プラグイン、拡張、型システム）を最大限活用すること。

### Why

- ライブラリ作者が既に解決した問題を再度解決するのは時間の浪費
- 独自実装はメンテナンスコストが高く、バグの温床になりやすい
- 公式プラグインはテスト済みで、バージョンアップにも追従される

## 実装前チェックリスト

カスタム実装を書く前に、以下を確認すること:

1. **公式ドキュメントを確認**: 求める機能が既に提供されていないか
2. **プラグイン/拡張を検索**: `@library/plugin-*` や `library-plugin-*` パターン
3. **型システムの活用**: ライブラリが提供する型を使用しているか
4. **コミュニティソリューション**: GitHub Issues や Discussions を確認

## Anti-Pattern: 型の手動定義

### Bad Example

```typescript
// ライブラリの型を無視して独自インターフェースを定義
interface FieldBuilder {
  exposeInt: (field: string, opts: { description: string }) => unknown;
  exposeString: (field: string, opts: { description: string }) => unknown;
}

interface PothosBuilder {
  objectType: (name: string, options: { ... }) => void;
}

// 型安全性を失い、as でキャスト
const schemaBuilder = builder as PothosBuilder;
```

### Good Example

```typescript
// ライブラリが提供する型をそのまま使用
import SchemaBuilder from "@pothos/core";

const builder = new SchemaBuilder<{
  Context: GraphQLContext;
  Scalars: { DateTime: { Input: Date; Output: Date } };
}>({});

// 型推論が効き、IDE サポートも完全
builder.objectType(UserRef, {
  fields: (t) => ({
    id: t.exposeInt("id"),
    email: t.exposeString("email"),
  }),
});
```

## Pothos 固有のガイドライン

### 活用すべきプラグイン

| Plugin | Purpose | Use Case |
|--------|---------|----------|
| `@pothos/plugin-errors` | エラーハンドリング | Result 型、Union errors |
| `@pothos/plugin-validation` | 入力バリデーション | Zod 統合 |
| `@pothos/plugin-dataloader` | N+1 問題解決 | BatchLoader 統合 |
| `@pothos/plugin-scope-auth` | 認可 | Field/Type レベル認可 |
| `@pothos/plugin-drizzle` | ORM 統合 | Drizzle 型からの GraphQL 型生成 |

### SchemaBuilder の型パラメータ

```typescript
// 必要な機能を SchemaTypes で宣言
interface SchemaTypes {
  Context: GraphQLContext;
  Scalars: {
    DateTime: { Input: Date; Output: Date };
  };
  // plugin-errors 使用時
  Interfaces: {
    Error: ErrorInterface;
  };
}

const builder = new SchemaBuilder<SchemaTypes>({
  plugins: [ErrorsPlugin, ValidationPlugin],
});
```

### ObjectRef による型安全な参照

```typescript
// 型参照を事前定義
const UserRef = builder.objectRef<User>("User");
const AuthErrorRef = builder.objectRef<AuthError>("AuthError");

// 後から実装
UserRef.implement({
  fields: (t) => ({
    id: t.exposeInt("id"),
    // ...
  }),
});
```

## 研究フェーズの重要性

新機能実装時は、以下の順序で調査を行う:

1. **公式ドキュメント** (15分): 基本的な使い方と利用可能な機能
2. **プラグイン一覧** (10分): npm で `@library/plugin-*` を検索
3. **GitHub Issues** (10分): 同じ課題を持つ人の解決策
4. **実装判断**: 上記で見つからない場合のみカスタム実装

## 判断基準

| 状況 | 推奨アプローチ |
|------|----------------|
| 公式プラグインが存在 | プラグインを使用 |
| コミュニティプラグインが存在 | 評価後に採用検討 |
| カスタマイズが必要 | プラグインを拡張 |
| 完全に新しい要件 | 最小限のカスタム実装 |

## ドキュメント化

独自実装を行う場合は、以下を記録すること:

- なぜ既存のソリューションが使えなかったか
- 調査したプラグイン/ライブラリのリスト
- 将来的に公式対応された場合の移行計画

---

updated_at: 2026-01-20
