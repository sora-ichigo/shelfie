import { config } from "../config";
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

function getDevUser(): AuthenticatedUser | null {
  if (config.isProduction()) {
    return null;
  }

  const devUserId = process.env.DEV_USER_ID;
  if (!devUserId) {
    return null;
  }

  return {
    uid: devUserId,
    email: "dev@example.com",
    emailVerified: true,
  };
}

export async function createAuthContext(
  authorizationHeader: string | undefined,
): Promise<AuthenticatedUser | null> {
  const devUser = getDevUser();
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
