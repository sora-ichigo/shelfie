import type { Builder } from "../../../graphql/builder.js";
import {
  createImageKitClient,
  type ImageUploadService,
  type UploadCredentials,
} from "../../../infra/index.js";

type UploadCredentialsRef = ReturnType<typeof createUploadCredentialsRef>;

function createUploadCredentialsRef(builder: Builder) {
  return builder.objectRef<UploadCredentials>("UploadCredentials");
}

let UploadCredentialsRef: UploadCredentialsRef;

export function registerImageUploadTypes(builder: Builder): void {
  UploadCredentialsRef = createUploadCredentialsRef(builder);

  UploadCredentialsRef.implement({
    description: "署名付きアップロードパラメータ",
    fields: (t) => ({
      token: t.exposeString("token", {
        description: "一意のアップロードトークン",
      }),
      signature: t.exposeString("signature", {
        description: "HMAC-SHA1署名",
      }),
      expire: t.exposeInt("expire", {
        description: "有効期限（Unix timestamp）",
      }),
      publicKey: t.exposeString("publicKey", {
        description: "ImageKit Public Key",
      }),
      uploadEndpoint: t.exposeString("uploadEndpoint", {
        description: "アップロードエンドポイントURL",
      }),
    }),
  });
}

export class ImageUploadError extends Error {
  code: "SERVICE_UNAVAILABLE" | "CONFIGURATION_ERROR";

  constructor(
    code: "SERVICE_UNAVAILABLE" | "CONFIGURATION_ERROR",
    message: string,
  ) {
    super(message);
    this.code = code;
    this.name = "ImageUploadError";
  }
}

type ImageUploadServiceFactory = () => ImageUploadService | null;

function createLazyImageUploadService(): ImageUploadServiceFactory {
  let cachedService: ImageUploadService | null = null;
  let initialized = false;

  return () => {
    if (!initialized) {
      const result = createImageKitClient();
      if (result.success) {
        cachedService = result.data;
      }
      initialized = true;
    }
    return cachedService;
  };
}

export function registerImageUploadQueries(builder: Builder): void {
  const getService = createLazyImageUploadService();

  builder.objectType(ImageUploadError, {
    name: "ImageUploadError",
    description: "画像アップロードサービスのエラー",
    fields: (t) => ({
      code: t.exposeString("code", {
        description: "エラーコード",
      }),
      message: t.exposeString("message", {
        description: "エラーメッセージ",
      }),
    }),
  });

  builder.queryFields((t) => ({
    getUploadCredentials: t.field({
      type: UploadCredentialsRef,
      description: "署名付きアップロードパラメータを取得",
      errors: {
        types: [ImageUploadError],
      },
      authScopes: {
        loggedIn: true,
      },
      resolve: async (_parent, _args, context): Promise<UploadCredentials> => {
        if (!context.user) {
          throw new ImageUploadError("SERVICE_UNAVAILABLE", "認証が必要です");
        }

        const imageUploadService = getService();
        if (!imageUploadService) {
          throw new ImageUploadError(
            "CONFIGURATION_ERROR",
            "画像アップロードサービスが利用できません",
          );
        }

        const result = imageUploadService.getUploadCredentials(1);

        if (!result.success) {
          throw new ImageUploadError(result.error.code, result.error.message);
        }

        return result.data;
      },
    }),
  }));
}
