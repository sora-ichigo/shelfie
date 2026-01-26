import admin from "firebase-admin";
import type { DecodedIdToken } from "firebase-admin/auth";

export type { DecodedIdToken } from "firebase-admin/auth";

export interface FirebaseAuthConfig {
  projectId: string;
  clientEmail?: string;
  privateKey?: string;
}

export interface FirebaseAuthResult {
  initialized: boolean;
}

export function getFirebaseAuthConfig(): FirebaseAuthConfig | undefined {
  const projectId = process.env.FIREBASE_PROJECT_ID;

  if (!projectId) {
    return undefined;
  }

  const clientEmail = process.env.FIREBASE_CLIENT_EMAIL;
  const rawPrivateKey = process.env.FIREBASE_PRIVATE_KEY;
  const privateKey = rawPrivateKey?.replace(/\\n/g, "\n");

  return {
    projectId,
    clientEmail,
    privateKey,
  };
}

export function initializeFirebaseAuth(
  config?: FirebaseAuthConfig,
): FirebaseAuthResult {
  if (admin.apps.length > 0) {
    return { initialized: true };
  }

  if (config?.clientEmail && config?.privateKey) {
    admin.initializeApp({
      credential: admin.credential.cert({
        projectId: config.projectId,
        clientEmail: config.clientEmail,
        privateKey: config.privateKey,
      }),
    });
  } else {
    admin.initializeApp({
      credential: admin.credential.applicationDefault(),
    });
  }

  return { initialized: true };
}

export async function verifyIdToken(
  idToken: string,
): Promise<DecodedIdToken | null> {
  try {
    return await admin.auth().verifyIdToken(idToken);
  } catch {
    return null;
  }
}

export interface FirebaseAuthAdapter {
  createUser(
    email: string,
    password: string,
  ): Promise<{ uid: string; emailVerified: boolean }>;
  signIn(
    email: string,
    password: string,
  ): Promise<{ uid: string; idToken: string; refreshToken: string }>;
  refreshToken(
    refreshToken: string,
  ): Promise<{ idToken: string; refreshToken: string }>;
  changePassword(
    idToken: string,
    newPassword: string,
  ): Promise<{ idToken: string; refreshToken: string }>;
  sendPasswordResetEmail(email: string): Promise<void>;
}

interface FirebaseSignInResponse {
  idToken: string;
  email: string;
  refreshToken: string;
  expiresIn: string;
  localId: string;
  registered: boolean;
}

interface FirebaseErrorResponse {
  error: {
    code: number;
    message: string;
    errors: Array<{ message: string; domain: string; reason: string }>;
  };
}

interface FirebaseRefreshTokenResponse {
  id_token: string;
  refresh_token: string;
  expires_in: string;
  token_type: string;
  user_id: string;
  project_id: string;
}

interface FirebaseUpdateResponse {
  idToken: string;
  refreshToken: string;
}

interface FirebaseSendOobCodeResponse {
  email: string;
}

function mapFirebaseRestErrorCode(message: string): string {
  if (message.includes("INVALID_LOGIN_CREDENTIALS")) {
    return "auth/invalid-credential";
  }
  if (message.includes("EMAIL_NOT_FOUND")) {
    return "auth/user-not-found";
  }
  if (message.includes("INVALID_PASSWORD")) {
    return "auth/wrong-password";
  }
  return "auth/internal-error";
}

function mapFirebaseRefreshErrorCode(message: string): string {
  if (message.includes("INVALID_REFRESH_TOKEN")) {
    return "auth/invalid-refresh-token";
  }
  if (message.includes("TOKEN_EXPIRED")) {
    return "auth/token-expired";
  }
  if (message.includes("USER_DISABLED")) {
    return "auth/user-disabled";
  }
  if (message.includes("USER_NOT_FOUND")) {
    return "auth/user-not-found";
  }
  return "auth/internal-error";
}

function mapFirebaseUpdatePasswordErrorCode(message: string): string {
  if (message.includes("INVALID_ID_TOKEN")) {
    return "auth/invalid-id-token";
  }
  if (message.includes("WEAK_PASSWORD")) {
    return "auth/weak-password";
  }
  if (message.includes("CREDENTIAL_TOO_OLD_LOGIN_AGAIN")) {
    return "auth/requires-recent-login";
  }
  if (message.includes("USER_DISABLED")) {
    return "auth/user-disabled";
  }
  if (message.includes("USER_NOT_FOUND")) {
    return "auth/user-not-found";
  }
  return "auth/internal-error";
}

function mapFirebaseSendOobCodeErrorCode(message: string): string {
  if (message.includes("EMAIL_NOT_FOUND")) {
    return "auth/user-not-found";
  }
  if (message.includes("INVALID_EMAIL")) {
    return "auth/invalid-email";
  }
  return "auth/internal-error";
}

export function createFirebaseAuthAdapter(): FirebaseAuthAdapter {
  return {
    async createUser(
      email: string,
      password: string,
    ): Promise<{ uid: string; emailVerified: boolean }> {
      const userRecord = await admin.auth().createUser({
        email,
        password,
      });
      return {
        uid: userRecord.uid,
        emailVerified: userRecord.emailVerified,
      };
    },

    async signIn(
      email: string,
      password: string,
    ): Promise<{ uid: string; idToken: string; refreshToken: string }> {
      const apiKey = process.env.FIREBASE_WEB_API_KEY;
      if (!apiKey) {
        throw { code: "auth/internal-error" };
      }

      const url = `https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${apiKey}`;

      const response = await fetch(url, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          email,
          password,
          returnSecureToken: true,
        }),
      });

      if (!response.ok) {
        const errorData = (await response.json()) as FirebaseErrorResponse;
        const errorCode = mapFirebaseRestErrorCode(
          errorData.error?.message || "",
        );
        throw { code: errorCode };
      }

      const data = (await response.json()) as FirebaseSignInResponse;
      return {
        uid: data.localId,
        idToken: data.idToken,
        refreshToken: data.refreshToken,
      };
    },

    async refreshToken(
      refreshToken: string,
    ): Promise<{ idToken: string; refreshToken: string }> {
      const apiKey = process.env.FIREBASE_WEB_API_KEY;
      if (!apiKey) {
        throw { code: "auth/internal-error" };
      }

      const url = `https://securetoken.googleapis.com/v1/token?key=${apiKey}`;

      const response = await fetch(url, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          grant_type: "refresh_token",
          refresh_token: refreshToken,
        }),
      });

      if (!response.ok) {
        const errorData = (await response.json()) as FirebaseErrorResponse;
        const errorCode = mapFirebaseRefreshErrorCode(
          errorData.error?.message || "",
        );
        throw { code: errorCode };
      }

      const data = (await response.json()) as FirebaseRefreshTokenResponse;
      return {
        idToken: data.id_token,
        refreshToken: data.refresh_token,
      };
    },

    async changePassword(
      idToken: string,
      newPassword: string,
    ): Promise<{ idToken: string; refreshToken: string }> {
      const apiKey = process.env.FIREBASE_WEB_API_KEY;
      if (!apiKey) {
        throw { code: "auth/internal-error" };
      }

      const url = `https://identitytoolkit.googleapis.com/v1/accounts:update?key=${apiKey}`;

      const response = await fetch(url, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          idToken,
          password: newPassword,
          returnSecureToken: true,
        }),
      });

      if (!response.ok) {
        const errorData = (await response.json()) as FirebaseErrorResponse;
        const errorCode = mapFirebaseUpdatePasswordErrorCode(
          errorData.error?.message || "",
        );
        throw { code: errorCode };
      }

      const data = (await response.json()) as FirebaseUpdateResponse;
      return {
        idToken: data.idToken,
        refreshToken: data.refreshToken,
      };
    },

    async sendPasswordResetEmail(email: string): Promise<void> {
      const apiKey = process.env.FIREBASE_WEB_API_KEY;
      if (!apiKey) {
        throw { code: "auth/internal-error" };
      }

      const url = `https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=${apiKey}`;

      const response = await fetch(url, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          requestType: "PASSWORD_RESET",
          email,
        }),
      });

      if (!response.ok) {
        const errorData = (await response.json()) as FirebaseErrorResponse;
        const errorCode = mapFirebaseSendOobCodeErrorCode(
          errorData.error?.message || "",
        );
        throw { code: errorCode };
      }

      // sendPasswordResetEmail は void を返す
      (await response.json()) as FirebaseSendOobCodeResponse;
    },
  };
}
