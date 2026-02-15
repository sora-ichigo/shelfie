import type { Metadata } from "next";
import { Noto_Sans_JP } from "next/font/google";

const notoSansJP = Noto_Sans_JP({
  subsets: ["latin"],
  display: "swap",
});

export const metadata: Metadata = {
  title: "Shelfie - 読書家のための本棚アプリ",
  description: "あなたの読書体験を可視化し、シェアしよう",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="ja" className={notoSansJP.className}>
      <body style={{ margin: 0, overflow: "hidden" }}>{children}</body>
    </html>
  );
}
