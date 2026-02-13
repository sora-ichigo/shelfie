import { NextResponse } from "next/server";

const AASA = {
  applinks: {
    apps: [],
    details: [
      {
        appIDs: ["X9V24ZSQJQ.app.shelfie.shelfie"],
        paths: ["/u/*"],
      },
    ],
  },
};

export function GET() {
  return NextResponse.json(AASA, {
    headers: {
      "Content-Type": "application/json",
    },
  });
}
