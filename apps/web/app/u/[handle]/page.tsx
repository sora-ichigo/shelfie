import type { Metadata } from "next";
import Image from "next/image";
import { notFound } from "next/navigation";
import { fetchUserByHandle } from "../../../lib/graphql/fetch-user";
import { graphql, useFragment } from "../../../lib/graphql/generated";

export const UserProfilePageFragment = graphql(`
  fragment UserProfilePage_User on User {
    name
    avatarUrl
    bio
    handle
  }
`);

const APP_URL = process.env.APP_URL ?? "http://localhost:3000";
const APP_STORE_URL =
  "https://apps.apple.com/jp/app/shelfie-%E8%AA%AD%E6%9B%B8%E8%A8%98%E9%8C%B2-%E6%9C%AC%E6%A3%9A%E7%AE%A1%E7%90%86/id6758423936";

interface Props {
  params: Promise<{ handle: string }>;
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { handle } = await params;
  const result = await fetchUserByHandle(handle);
  const user = useFragment(UserProfilePageFragment, result);

  if (!user) {
    return {
      title: "ユーザーが見つかりません - Shelfie",
    };
  }

  const displayName = user.name ?? `@${handle}`;

  return {
    title: `${displayName} - Shelfie`,
    description: `${displayName} さんのプロフィールを Shelfie で見る`,
    openGraph: {
      title: `${displayName} - Shelfie`,
      description: `${displayName} さんのプロフィールを Shelfie で見る`,
      type: "profile",
      url: `${APP_URL}/u/${handle}`,
    },
  };
}

export default async function UserProfilePage({ params }: Props) {
  const { handle } = await params;
  const result = await fetchUserByHandle(handle);
  const user = useFragment(UserProfilePageFragment, result);

  if (!user) {
    notFound();
  }

  const appLink = `shelfie:///u/${handle}`;
  const displayName = user.name ?? handle;
  const avatarInitial = displayName.charAt(0).toUpperCase();

  return (
    <main style={styles.container}>
      <div style={styles.card}>
        <div style={styles.logoSection}>
          <h1 style={styles.logo}>Shelfie</h1>
          <p style={styles.tagline}>読書家のための本棚アプリ</p>
        </div>

        <div style={styles.profileSection}>
          {user.avatarUrl ? (
            <Image
              src={user.avatarUrl}
              alt={displayName}
              width={80}
              height={80}
              style={styles.avatarImage}
            />
          ) : (
            <div style={styles.avatar}>
              <span style={styles.avatarText}>{avatarInitial}</span>
            </div>
          )}
          <h2 style={styles.name}>{displayName}</h2>
          <p style={styles.handle}>@{handle}</p>
          {user.bio && <p style={styles.bio}>{user.bio}</p>}
        </div>

        <div style={styles.buttonSection}>
          <a href={appLink} style={styles.primaryButton}>
            アプリで開く
          </a>
          <div style={styles.storeLinks}>
            <a href={APP_STORE_URL} style={styles.storeBadge}>
              <svg
                width="20"
                height="24"
                viewBox="0 0 814 1000"
                fill="white"
                role="img"
                aria-label="Apple logo"
              >
                <path d="M788.1 340.9c-5.8 4.5-108.2 62.2-108.2 190.5 0 148.4 130.3 200.9 134.2 202.2-.6 3.2-20.7 71.9-68.7 141.9-42.8 61.6-87.5 123.1-155.5 123.1s-85.5-39.5-164-39.5c-76.5 0-103.7 40.8-165.9 40.8s-105.6-57.4-155.5-127.4c-58.6-82-106.9-209.6-106.9-330.8 0-194.4 126.4-297.5 250.8-297.5 66.1 0 121.2 43.4 162.7 43.4 39.5 0 101.1-46 176.3-46 28.5 0 130.9 2.6 198.3 99.2zm-234-181.5c31.1-36.9 53.1-88.1 53.1-139.3 0-7.1-.6-14.3-1.9-20.1-50.6 1.9-110.8 33.7-147.1 75.8-28.5 32.4-55.1 83.6-55.1 135.5 0 7.8 1.3 15.6 1.9 18.1 3.2.6 8.4 1.3 13.6 1.3 45.4 0 103.3-30.4 135.5-71.3z" />
              </svg>
              <span style={styles.storeBadgeText}>
                <span style={styles.storeBadgeLabel}>Download on the</span>
                <span style={styles.storeBadgeName}>App Store</span>
              </span>
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
  avatarImage: {
    width: "80px",
    height: "80px",
    borderRadius: "50%",
    objectFit: "cover" as const,
    margin: "0 auto 12px auto",
    display: "block",
  },
  avatarText: {
    fontSize: "32px",
    fontWeight: "600",
    color: "#ffffff",
  },
  name: {
    fontSize: "20px",
    fontWeight: "600",
    color: "#ffffff",
    margin: "0 0 4px 0",
  },
  handle: {
    fontSize: "14px",
    color: "#888888",
    margin: "0 0 8px 0",
  },
  bio: {
    fontSize: "14px",
    color: "#cccccc",
    margin: "0",
    lineHeight: "1.5",
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
    gap: "12px",
  },
  storeBadge: {
    display: "flex",
    alignItems: "center",
    gap: "8px",
    padding: "8px 16px",
    backgroundColor: "#000000",
    border: "1px solid #555555",
    borderRadius: "8px",
    textDecoration: "none",
    color: "#ffffff",
  },
  storeBadgeText: {
    display: "flex",
    flexDirection: "column" as const,
    textAlign: "left" as const,
  },
  storeBadgeLabel: {
    fontSize: "9px",
    lineHeight: "1.2",
    letterSpacing: "0.5px",
  },
  storeBadgeName: {
    fontSize: "16px",
    fontWeight: "600",
    lineHeight: "1.2",
  },
};
