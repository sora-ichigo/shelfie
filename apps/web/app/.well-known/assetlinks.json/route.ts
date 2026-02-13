import { NextResponse } from "next/server";

const ASSET_LINKS = [
  {
    relation: ["delegate_permission/common.handle_all_urls"],
    target: {
      namespace: "android_app",
      package_name: "app.shelfie.shelfie",
      sha256_cert_fingerprints: ["TODO:REPLACE_WITH_ACTUAL_SHA256_FINGERPRINT"],
    },
  },
];

export function GET() {
  return NextResponse.json(ASSET_LINKS, {
    headers: {
      "Content-Type": "application/json",
    },
  });
}
