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

export async function createAuthContext(
  authorizationHeader: string | undefined,
): Promise<AuthenticatedUser | null> {
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
