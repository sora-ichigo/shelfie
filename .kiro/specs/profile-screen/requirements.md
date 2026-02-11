# Requirements Document

## Project Description (Input)
プロフィール画面（自分）の実装。ボトムタブの「プロフィール」タブ（/profile）を、現在の「準備中です」プレースホルダーから実際のプロフィール表示画面に置き換える。

表示内容:
- プロフィールヘッダー: アバター、名前、@username
- アクション: 設定アイコン（/account へ遷移）
- 読書統計: ステータス別冊数（読了、読書中、積読、読まない）を数字+ラベル形式で表示

設計方針:
- ミニマムスコープ（ヘッダー + 統計のみ）
- 既存のアカウント画面（/account）とは分離を維持
- Phase 2（友達プロフィール）を見据えた設計: userId パラメータを受け取り、自分/他人で表示を切替可能に
- 読書開始情報はプロフィールには非表示（アカウント画面のみ）

実装が必要なもの:
- API: GraphQL User 型にステータス別冊数フィールド追加（readingCount, backlogCount, completedCount, droppedCount）
- Mobile: UserProfile エンティティ更新、GraphQL クエリ更新、ProfileScreen 実装、再利用可能なプロフィール表示コンポーネント作成

## Introduction

本ドキュメントは、Shelfie モバイルアプリにおけるプロフィール画面機能の要件を定義する。ボトムタブの「プロフィール」タブを、プレースホルダーからユーザーのプロフィール情報と読書統計を表示する画面に置き換える。Phase 2 での友達プロフィール表示を見据え、再利用可能な設計とする。

## Requirements

### Requirement 1: プロフィールヘッダー表示

**Objective:** ユーザーとして、自分のアバター、名前、ユーザー名がプロフィール画面に表示されることで、自分のアカウントを視覚的に確認できるようにしたい

#### Acceptance Criteria

1. When ユーザーがプロフィールタブ（/profile）を開いた時, the ProfileScreen shall ユーザーのアバター画像を表示する
2. When ユーザーがプロフィールタブを開いた時, the ProfileScreen shall ユーザーの表示名を表示する
3. When ユーザーがプロフィールタブを開いた時, the ProfileScreen shall ユーザー名を「@username」形式で表示する
4. If ユーザーのアバター画像が未設定の場合, the ProfileScreen shall デフォルトのアバターアイコンを表示する

### Requirement 2: 設定画面への遷移

**Objective:** ユーザーとして、プロフィール画面から設定画面にすばやくアクセスできるようにしたい

#### Acceptance Criteria

1. When ユーザーがプロフィール画面を表示した時, the ProfileScreen shall 設定アイコンを表示する
2. When ユーザーが設定アイコンをタップした時, the ProfileScreen shall アカウント画面（/account）へ遷移する

### Requirement 3: 読書統計表示

**Objective:** ユーザーとして、ステータス別の冊数を一覧で確認できることで、読書の進捗を把握したい

#### Acceptance Criteria

1. When ユーザーがプロフィール画面を表示した時, the ProfileScreen shall 読了の冊数を数字とラベルで表示する
2. When ユーザーがプロフィール画面を表示した時, the ProfileScreen shall 読書中の冊数を数字とラベルで表示する
3. When ユーザーがプロフィール画面を表示した時, the ProfileScreen shall 積読の冊数を数字とラベルで表示する
4. When ユーザーがプロフィール画面を表示した時, the ProfileScreen shall 読まないの冊数を数字とラベルで表示する
5. The ProfileScreen shall 読書開始情報をプロフィール画面に表示しない

### Requirement 4: GraphQL API のステータス別冊数提供

**Objective:** モバイルアプリがユーザーのステータス別冊数を取得できるように、API がデータを提供する

#### Acceptance Criteria

1. The GraphQL API shall User 型に readingCount フィールドを提供する
2. The GraphQL API shall User 型に backlogCount フィールドを提供する
3. The GraphQL API shall User 型に completedCount フィールドを提供する
4. The GraphQL API shall User 型に droppedCount フィールドを提供する
5. When 各冊数フィールドがクエリされた時, the GraphQL API shall 認証済みユーザーのステータス別冊数を正確に返却する

### Requirement 5: データ取得と状態管理

**Objective:** ユーザーとして、プロフィール画面を開いた際に最新のデータが表示されるようにしたい

#### Acceptance Criteria

1. When プロフィール画面が初回表示された時, the ProfileScreen shall GraphQL API からプロフィールデータとステータス別冊数を取得して表示する
2. While プロフィールデータを取得中の間, the ProfileScreen shall ローディングインジケーターを表示する
3. If プロフィールデータの取得に失敗した場合, the ProfileScreen shall エラー状態を表示する
4. When 本棚のデータが変更された時（ShelfVersion が更新された時）, the ProfileScreen shall ステータス別冊数を再取得して最新の値を表示する

### Requirement 6: 再利用可能なプロフィールコンポーネント設計

**Objective:** Phase 2 での友達プロフィール表示に備え、プロフィール表示コンポーネントを再利用可能に設計したい

#### Acceptance Criteria

1. The ProfileScreen shall userId パラメータを受け取り、指定されたユーザーのプロフィールを表示できる構造とする
2. When userId が自分自身を示す場合, the ProfileScreen shall 設定アイコンを表示する
3. The プロフィール表示コンポーネント shall プロフィールヘッダーと読書統計を独立したウィジェットとして提供する
