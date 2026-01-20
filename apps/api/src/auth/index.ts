export {
  type DecodedIdToken,
  type FirebaseAuthConfig,
  type FirebaseAuthResult,
  type FirebaseAuthAdapter,
  getFirebaseAuthConfig,
  initializeFirebaseAuth,
  verifyIdToken,
  createFirebaseAuthAdapter,
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
