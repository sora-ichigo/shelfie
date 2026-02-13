import type { Metadata } from "next";

const APP_STORE_URL = "https://apps.apple.com/app/shelfie/id6740080981";
const PLAY_STORE_URL =
  "https://play.google.com/store/apps/details?id=app.shelfie.shelfie";
const APP_SCHEME = "https://shelfie.app";

interface Props {
  params: Promise<{ handle: string }>;
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { handle } = await params;
  return {
    title: `@${handle} - Shelfie`,
    description: `@${handle} さんのプロフィールを Shelfie で見る`,
    openGraph: {
      title: `@${handle} - Shelfie`,
      description: `@${handle} さんのプロフィールを Shelfie で見る`,
      type: "profile",
      url: `${APP_SCHEME}/u/${handle}`,
    },
  };
}

export default async function InvitePage({ params }: Props) {
  const { handle } = await params;
  const appLink = `${APP_SCHEME}/u/${handle}`;

  return (
    <main style={styles.container}>
      <div style={styles.card}>
        <div style={styles.logoSection}>
          <h1 style={styles.logo}>Shelfie</h1>
          <p style={styles.tagline}>読書家のための本棚アプリ</p>
        </div>

        <div style={styles.profileSection}>
          <div style={styles.avatar}>
            <span style={styles.avatarText}>
              {handle.charAt(0).toUpperCase()}
            </span>
          </div>
          <h2 style={styles.handle}>@{handle}</h2>
          <p style={styles.description}>
            アプリで @{handle} さんのプロフィールを見る
          </p>
        </div>

        <div style={styles.buttonSection}>
          <a href={appLink} style={styles.primaryButton}>
            アプリで開く
          </a>
          <div style={styles.storeLinks}>
            <a href={APP_STORE_URL} style={styles.storeLink}>
              App Store
            </a>
            <a href={PLAY_STORE_URL} style={styles.storeLink}>
              Google Play
            </a>
          </div>
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
    minHeight: "100vh",
    backgroundColor: "#121212",
    padding: "16px",
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
  profileSection: {
    marginBottom: "32px",
  },
  avatar: {
    width: "80px",
    height: "80px",
    borderRadius: "50%",
    backgroundColor: "#333333",
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
    margin: "0 auto 12px auto",
  },
  avatarText: {
    fontSize: "32px",
    fontWeight: "600",
    color: "#ffffff",
  },
  handle: {
    fontSize: "20px",
    fontWeight: "600",
    color: "#ffffff",
    margin: "0 0 8px 0",
  },
  description: {
    fontSize: "14px",
    color: "#888888",
    margin: "0",
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
  storeLinks: {
    display: "flex",
    justifyContent: "center",
    gap: "24px",
  },
  storeLink: {
    fontSize: "14px",
    color: "#6750A4",
    textDecoration: "none",
  },
};
