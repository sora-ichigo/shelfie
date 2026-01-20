export {
  createFirebaseAuthAdapter,
  type DecodedIdToken,
  type FirebaseAuthAdapter,
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
