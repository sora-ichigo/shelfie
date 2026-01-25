# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Development Commands

```bash
# セットアップ
mise install && pnpm install && pnpm mobile pub get

# 開発サーバー
pnpm dev:api                    # API サーバー起動
pnpm dev:mobile                 # モバイルアプリ起動

# チェック
pnpm check                      # lint + format
pnpm test                       # 全テスト実行
```

## Flutter テスト実行時の注意

ローカルで `flutter test` を実行する際、全テスト実行はタイムアウトしやすい。以下のいずれかで対応すること：

```bash
# 関連するテストファイルのみ実行（推奨）
flutter test test/unit/path/to/specific_test.dart

# 並列数を増やして高速化
flutter test --concurrency=8
```

## Code Style

- Linter/Formatter: Biome（`biome.json` で設定）
- インデント: スペース2つ
- クォート: ダブルクォート
- セミコロン: あり
- TypeScript strict モード有効
- テストフレームワーク: Vitest (TypeScript) / flutter_test (Dart)

## Testing

### Flutter テスト

- ローカル実行時は関連するテストファイルのみに絞って実行する（全件実行は時間がかかりすぎるため）
- 全テストを実行したい場合は push して CI で確認する

```bash
# 特定のテストファイルのみ実行
pnpm mobile test test/unit/path/to/specific_test.dart

# 特定ディレクトリ配下のテストを実行
pnpm mobile test test/unit/features/some_feature/
```

## CI

GitHub Actions で paths-filter による差分検知を使用。変更されたパッケージのみ CI が実行される。

## Spec-Driven Development

@.claude/SDD.md
