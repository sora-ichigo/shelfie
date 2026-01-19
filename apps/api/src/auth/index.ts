export {
  type DecodedIdToken,
  type FirebaseAuthConfig,
  type FirebaseAuthResult,
  getFirebaseAuthConfig,
  initializeFirebaseAuth,
  verifyIdToken,
} from "./firebase";

export {
  type AuthenticatedUser,
  createAuthContext,
  extractBearerToken,
} from "./middleware";

export {
  type AuthenticatedContext,
  requireAuth,
  requireEmailVerified,
} from "./scope";
