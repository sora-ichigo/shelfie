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

## Spec-Driven Development

@.claude/SDD.md
