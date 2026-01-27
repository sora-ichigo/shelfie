# Fastlane Match 証明書リポジトリのセットアップ手順

本ドキュメントは、Fastlane match を使用した iOS 証明書/Provisioning Profile 管理のセットアップ手順を説明します。

## 前提条件

- Apple Developer Program への登録
- 証明書リポジトリ (`https://github.com/sora-ichigo/shelfie-certificates`) の作成（Private リポジトリ）
- Ruby と Bundler のインストール

## セットアップ手順

### 1. 依存関係のインストール

```bash
cd apps/mobile/ios
bundle install
```

### 2. 証明書リポジトリの初期化

以下のコマンドを実行して、証明書リポジトリを初期化します。

```bash
bundle exec fastlane match init
```

プロンプトに従って:
- Storage mode: `git` を選択
- Git URL: `https://github.com/sora-ichigo/shelfie-certificates` を入力

### 3. Ad Hoc 証明書と Provisioning Profile の生成

以下のコマンドを実行して、Ad Hoc 配布用の証明書と Provisioning Profile を生成します。

```bash
bundle exec fastlane match adhoc
```

プロンプトに従って:
- Apple ID: 開発者アカウントのメールアドレスを入力
- App-specific password: Apple ID の App 用パスワードを入力（2FA 有効時）
- MATCH_PASSWORD: 証明書の暗号化パスワードを設定（安全な場所に保存）

### 4. MATCH_PASSWORD の記録

生成時に設定した `MATCH_PASSWORD` を安全に記録してください。この値は GitHub Secrets に設定する必要があります。

```bash
# GitHub Secrets に設定
# Repository Settings > Secrets and variables > Actions > New repository secret
# Name: MATCH_PASSWORD
# Value: (設定した暗号化パスワード)
```

### 5. GitHub PAT の作成と設定

証明書リポジトリへのアクセス用に GitHub Personal Access Token (PAT) を作成します。

1. GitHub Settings > Developer settings > Personal access tokens > Fine-grained tokens
2. 以下の設定で新しいトークンを作成:
   - Token name: `shelfie-certificates-access`
   - Expiration: 適切な期限を設定
   - Repository access: `sora-ichigo/shelfie-certificates` のみ
   - Permissions: Contents (Read and write)

3. Base64 エンコードして GitHub Secrets に設定:

```bash
# PAT を Base64 エンコード
echo -n "username:YOUR_PAT_TOKEN" | base64

# GitHub Secrets に設定
# Name: MATCH_GIT_BASIC_AUTHORIZATION
# Value: (Base64 エンコードした値)
```

### 6. 証明書リポジトリの確認

セットアップ完了後、証明書リポジトリに以下のファイルが存在することを確認:

```
shelfie-certificates/
├── certs/
│   └── distribution/
│       └── *.cer (暗号化された証明書)
├── profiles/
│   └── adhoc/
│       └── AdHoc_app.shelfie.shelfie.mobileprovision (暗号化されたプロファイル)
└── README.md
```

## GitHub Secrets/Variables 設定一覧

### Required Secrets

| Secret Name | Description |
|-------------|-------------|
| `MATCH_PASSWORD` | match 暗号化パスワード |
| `MATCH_GIT_BASIC_AUTHORIZATION` | `username:PAT` を Base64 エンコードした値 |

### Required Variables

| Variable Name | Description | Example |
|---------------|-------------|---------|
| `FIREBASE_IOS_APP_ID` | Firebase iOS アプリ ID | `1:123456789:ios:abc123` |
| `FIREBASE_TESTER_GROUPS` | テスターグループエイリアス | `internal-testers` |

## トラブルシューティング

### 証明書の取得に失敗する場合

```bash
# キャッシュをクリアして再取得
bundle exec fastlane match nuke distribution
bundle exec fastlane match adhoc
```

### Provisioning Profile の再生成が必要な場合

新しいデバイスを追加した後は、以下のコマンドで Profile を再生成:

```bash
bundle exec fastlane match adhoc --force
```

## セキュリティに関する注意事項

- 証明書リポジトリは必ず **Private** に設定してください
- `MATCH_PASSWORD` は定期的にローテーションすることを推奨
- GitHub PAT は最小限の権限で作成し、定期的に更新してください
