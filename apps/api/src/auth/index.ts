export {
  getFirebaseAuthConfig,
  initializeFirebaseAuth,
  verifyIdToken,
  type DecodedIdToken,
  type FirebaseAuthConfig,
  type FirebaseAuthResult,
} from "./firebase";

export {
  createAuthContext,
  extractBearerToken,
  type AuthenticatedUser,
} from "./middleware";

export {
  requireAuth,
  requireEmailVerified,
  type AuthenticatedContext,
} from "./scope";
