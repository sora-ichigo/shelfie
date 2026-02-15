const APP_STORE_URL =
  "https://apps.apple.com/jp/app/shelfie-%E8%AA%AD%E6%9B%B8%E8%A8%98%E9%8C%B2-%E6%9C%AC%E6%A3%9A%E7%AE%A1%E7%90%86/id6758423936";

export default function UserNotFound() {
  return (
    <main style={styles.container}>
      <div style={styles.card}>
        <div style={styles.logoSection}>
          <h1 style={styles.logo}>Shelfie</h1>
          <p style={styles.tagline}>読書家のための本棚アプリ</p>
        </div>

        <div style={styles.messageSection}>
          <div style={styles.icon}>?</div>
          <h2 style={styles.title}>ユーザーが見つかりません</h2>
          <p style={styles.description}>
            お探しのユーザーは存在しないか、削除された可能性があります。
          </p>
        </div>

        <div style={styles.buttonSection}>
          <a href={APP_STORE_URL} style={styles.primaryButton}>
            アプリをダウンロード
          </a>
        </div>
      </div>
    </main>
  );
}

const styles: Record<string, React.CSSProperties> = {
  container: {
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
    height: "100dvh",
    backgroundColor: "#121212",
    padding: "16px",
    boxSizing: "border-box",
  },
  card: {
    maxWidth: "400px",
    width: "100%",
    backgroundColor: "#1e1e1e",
    borderRadius: "16px",
    padding: "32px",
    textAlign: "center",
  },
  logoSection: {
    marginBottom: "24px",
  },
  logo: {
    fontSize: "28px",
    fontWeight: "700",
    color: "#ffffff",
    margin: "0 0 4px 0",
  },
  tagline: {
    fontSize: "14px",
    color: "#888888",
    margin: "0",
  },
  messageSection: {
    marginBottom: "32px",
  },
  icon: {
    width: "64px",
    height: "64px",
    borderRadius: "50%",
    backgroundColor: "#333333",
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
    margin: "0 auto 16px auto",
    fontSize: "28px",
    fontWeight: "700",
    color: "#888888",
  },
  title: {
    fontSize: "20px",
    fontWeight: "600",
    color: "#ffffff",
    margin: "0 0 8px 0",
  },
  description: {
    fontSize: "14px",
    color: "#888888",
    margin: "0",
    lineHeight: "1.5",
  },
  buttonSection: {
    display: "flex",
    flexDirection: "column",
    gap: "16px",
  },
  primaryButton: {
    display: "block",
    padding: "14px 24px",
    backgroundColor: "#6750A4",
    color: "#ffffff",
    borderRadius: "12px",
    textDecoration: "none",
    fontSize: "16px",
    fontWeight: "600",
  },
};
