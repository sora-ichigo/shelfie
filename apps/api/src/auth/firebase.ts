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
