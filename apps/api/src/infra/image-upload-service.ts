import ImageKit from "imagekit";
import { err, ok, type Result } from "../errors/result.js";

export interface UploadCredentials {
  token: string;
  signature: string;
  expire: number;
  publicKey: string;
  uploadEndpoint: string;
}

export type ImageUploadServiceErrors =
  | { code: "CONFIGURATION_ERROR"; message: string }
  | { code: "SERVICE_UNAVAILABLE"; message: string };

export interface ImageUploadService {
  getUploadCredentials(
    userId: number,
  ): Result<UploadCredentials, ImageUploadServiceErrors>;
}

interface ImageKitConfig {
  publicKey: string;
  privateKey: string;
  urlEndpoint: string;
}

const UPLOAD_ENDPOINT = "https://upload.imagekit.io/api/v1/files/upload";
const DEFAULT_EXPIRE_SECONDS = 30 * 60;

function getConfigFromEnv(): Result<ImageKitConfig, ImageUploadServiceErrors> {
  const publicKey = process.env.IMAGEKIT_PUBLIC_KEY;
  const privateKey = process.env.IMAGEKIT_PRIVATE_KEY;
  const urlEndpoint = process.env.IMAGEKIT_URL_ENDPOINT;

  if (!publicKey) {
    return err({
      code: "CONFIGURATION_ERROR",
      message: "IMAGEKIT_PUBLIC_KEY is not set",
    });
  }

  if (!privateKey) {
    return err({
      code: "CONFIGURATION_ERROR",
      message: "IMAGEKIT_PRIVATE_KEY is not set",
    });
  }

  if (!urlEndpoint) {
    return err({
      code: "CONFIGURATION_ERROR",
      message: "IMAGEKIT_URL_ENDPOINT is not set",
    });
  }

  return ok({
    publicKey,
    privateKey,
    urlEndpoint,
  });
}

export function createImageKitClient(): Result<
  ImageUploadService,
  ImageUploadServiceErrors
> {
  const configResult = getConfigFromEnv();
  if (!configResult.success) {
    return configResult;
  }

  const config = configResult.data;
  const imagekit = new ImageKit({
    publicKey: config.publicKey,
    privateKey: config.privateKey,
    urlEndpoint: config.urlEndpoint,
  });

  const service: ImageUploadService = {
    getUploadCredentials(
      _userId: number,
    ): Result<UploadCredentials, ImageUploadServiceErrors> {
      const expireTime = Math.floor(Date.now() / 1000) + DEFAULT_EXPIRE_SECONDS;
      const authParams = imagekit.getAuthenticationParameters(
        undefined,
        expireTime,
      );

      return ok({
        token: authParams.token,
        signature: authParams.signature,
        expire: authParams.expire,
        publicKey: config.publicKey,
        uploadEndpoint: UPLOAD_ENDPOINT,
      });
    },
  };

  return ok(service);
}
