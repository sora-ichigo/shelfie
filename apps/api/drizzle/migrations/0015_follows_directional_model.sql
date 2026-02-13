-- follows テーブルを双方向正規化モデルから一方向フォローモデルに移行する
-- 旧: (user_id_a, user_id_b) where user_id_a < user_id_b (1レコードで双方向)
-- 新: (follower_id, followee_id) 方向付き (A→BとB→Aは別レコード)

-- Step 1: 既存データを一時テーブルに退避（旧1レコード → 新2レコード変換用）
CREATE TEMP TABLE follows_backup AS
SELECT user_id_a, user_id_b, created_at FROM follows;

-- Step 2: follows テーブルのデータを削除
TRUNCATE TABLE follows RESTART IDENTITY;

-- Step 3: 旧制約・インデックスを削除
ALTER TABLE follows DROP CONSTRAINT IF EXISTS chk_ordered;
ALTER TABLE follows DROP CONSTRAINT IF EXISTS uq_follow;
DROP INDEX IF EXISTS idx_follows_user_a;
DROP INDEX IF EXISTS idx_follows_user_b;

-- Step 4: カラムをリネーム
ALTER TABLE follows RENAME COLUMN user_id_a TO follower_id;
ALTER TABLE follows RENAME COLUMN user_id_b TO followee_id;

-- Step 5: 新制約・インデックスを追加
ALTER TABLE follows ADD CONSTRAINT chk_no_self_follow CHECK (follower_id != followee_id);
ALTER TABLE follows ADD CONSTRAINT uq_follow UNIQUE (follower_id, followee_id);
CREATE INDEX idx_follows_follower ON follows (follower_id);
CREATE INDEX idx_follows_followee ON follows (followee_id);

-- Step 6: 既存データを変換して挿入（旧1レコード → 新2レコード: A→BとB→Aの双方向）
INSERT INTO follows (follower_id, followee_id, created_at)
SELECT user_id_a, user_id_b, created_at FROM follows_backup
UNION ALL
SELECT user_id_b, user_id_a, created_at FROM follows_backup;

-- Step 7: 一時テーブルを削除
DROP TABLE follows_backup;
