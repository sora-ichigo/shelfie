# Requirements Document

## Project Description (Input)
読了日を更新できるようにしたい。

## Introduction
現在、読了日（completedAt）は読書状態を「読了」に変更した際にシステムが自動的に現在日時を設定しており、ユーザーが手動で変更することができない。本機能では、ユーザーが読了日を任意の日付に変更できるようにする。

## Requirements

### Requirement 1: 読了日の手動更新
**Objective:** ユーザーとして、読了日を任意の日付に変更したい。実際に読み終えた日付を正確に記録するためである。

#### Acceptance Criteria
1. When ユーザーが読書記録セクションの読了日をタップする, the アプリ shall 日付選択UIを表示する
2. When ユーザーが日付選択UIで日付を選択して確定する, the アプリ shall 選択された日付で読了日を更新する
3. When 読了日の更新が成功する, the アプリ shall 読書記録セクションに更新後の読了日を即座に反映する
4. While 読書状態が「読了」以外である, the アプリ shall 読了日の編集機能を表示しない
5. If 読了日の更新に失敗する, the アプリ shall エラーメッセージを表示する

### Requirement 2: 読了日の API 更新
**Objective:** モバイルアプリとして、読了日を API 経由で永続化したい。サーバー側でデータの整合性を保つためである。

#### Acceptance Criteria
1. When 読了日更新リクエストを受信する, the API shall 指定された日付で completedAt を更新する
2. When 読了日更新リクエストを受信する, the API shall 対象の本が認証ユーザーの所有であることを検証する
3. If 対象の本が存在しない, the API shall BOOK_NOT_FOUND エラーを返す
4. If 対象の本が認証ユーザーの所有でない, the API shall FORBIDDEN エラーを返す
5. When 読了日の更新が成功する, the API shall 更新後の UserBook を返す

### Requirement 3: 読了日のバリデーション
**Objective:** システムとして、読了日の値が妥当であることを保証したい。不正なデータの登録を防ぐためである。

#### Acceptance Criteria
1. The アプリ shall 読了日として未来の日付を選択できないようにする
2. The アプリ shall 読了日として本棚への追加日より前の日付も選択可能とする
3. When ユーザーが読了日を選択する, the アプリ shall 日付のみを対象とし時刻の入力は求めない

### Requirement 4: 読書状態変更時の読了日の自動設定
**Objective:** システムとして、読書状態変更時に読了日を適切に管理したい。ユーザーが手動設定した読了日を保護しつつ、初回読了時には自動設定するためである。

#### Acceptance Criteria
1. When 読書状態を「読了」に変更する AND completedAt が null である, the システム shall completedAt に当日の日付を設定する
2. When 読書状態を「読了」に変更する AND completedAt が null でない, the システム shall completedAt の既存値をそのまま保持する
3. When 読書状態を「読了」以外に変更する, the システム shall completedAt の値をクリアせずそのまま保持する
