import type { Metadata } from "next";

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
    <html lang="ja">
      <body>{children}</body>
    </html>
  );
}
