import { eq } from "drizzle-orm";
import { config } from "../config";
import { getDb, users } from "../db";
import { verifyIdToken } from "./firebase";

export interface AuthenticatedUser {
  uid: string;
  email?: string;
  emailVerified: boolean;
}

export function extractBearerToken(
  authorizationHeader: string | undefined,
): string | null {
  if (!authorizationHeader) {
    return null;
  }

  if (!authorizationHeader.startsWith("Bearer ")) {
    return null;
  }

  return authorizationHeader.slice(7);
}

async function getDevUserById(
  userId: number,
): Promise<AuthenticatedUser | null> {
  const db = getDb();
  const result = await db
    .select({ firebaseUid: users.firebaseUid, email: users.email })
    .from(users)
    .where(eq(users.id, userId))
    .limit(1);

  const user = result[0];
  if (!user) {
    return null;
  }

  return {
    uid: user.firebaseUid,
    email: user.email,
    emailVerified: true,
  };
}

async function getDevUser(
  devUserIdHeader: string | undefined,
): Promise<AuthenticatedUser | null> {
  if (config.isProduction()) {
    return null;
  }

  const devUserIdStr = devUserIdHeader ?? process.env.DEV_USER_ID;
  if (!devUserIdStr) {
    return null;
  }

  const userId = Number.parseInt(devUserIdStr, 10);
  if (Number.isNaN(userId)) {
    return null;
  }

  return getDevUserById(userId);
}

export async function createAuthContext(
  authorizationHeader: string | undefined,
  devUserIdHeader?: string,
): Promise<AuthenticatedUser | null> {
  const devUser = await getDevUser(devUserIdHeader);
  if (devUser) {
    return devUser;
  }

  const token = extractBearerToken(authorizationHeader);

  if (!token) {
    return null;
  }

  const decodedToken = await verifyIdToken(token);

  if (!decodedToken) {
    return null;
  }

  return {
    uid: decodedToken.uid,
    email: decodedToken.email,
    emailVerified: decodedToken.email_verified ?? false,
  };
}
