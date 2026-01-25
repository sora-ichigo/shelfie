import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import type { ImageUploadService, UploadCredentials } from "./image-upload-service.js";
import { createImageKitClient } from "./image-upload-service.js";

describe("ImageUploadService", () => {
  describe("IImageUploadService interface", () => {
    it("should return UploadCredentials with required fields", async () => {
      const mockService: ImageUploadService = {
        getUploadCredentials: vi.fn().mockReturnValue({
          success: true,
          data: {
            token: "test-token",
            signature: "test-signature",
            expire: 1234567890,
            publicKey: "test-public-key",
            uploadEndpoint: "https://upload.imagekit.io/api/v1/files/upload",
          } satisfies UploadCredentials,
        }),
      };

      const result = mockService.getUploadCredentials(1);

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data.token).toBeDefined();
        expect(result.data.signature).toBeDefined();
        expect(result.data.expire).toBeDefined();
        expect(result.data.publicKey).toBeDefined();
        expect(result.data.uploadEndpoint).toBeDefined();
      }
    });
  });

  describe("createImageKitClient", () => {
    const originalEnv = process.env;

    beforeEach(() => {
      vi.resetModules();
      process.env = { ...originalEnv };
    });

    afterEach(() => {
      process.env = originalEnv;
    });

    it("should return CONFIGURATION_ERROR when IMAGEKIT_PUBLIC_KEY is missing", () => {
      process.env.IMAGEKIT_PRIVATE_KEY = "test-private-key";
      process.env.IMAGEKIT_URL_ENDPOINT = "https://ik.imagekit.io/test";

      const result = createImageKitClient();

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("CONFIGURATION_ERROR");
        expect(result.error.message).toContain("IMAGEKIT_PUBLIC_KEY");
      }
    });

    it("should return CONFIGURATION_ERROR when IMAGEKIT_PRIVATE_KEY is missing", () => {
      process.env.IMAGEKIT_PUBLIC_KEY = "test-public-key";
      process.env.IMAGEKIT_URL_ENDPOINT = "https://ik.imagekit.io/test";

      const result = createImageKitClient();

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("CONFIGURATION_ERROR");
        expect(result.error.message).toContain("IMAGEKIT_PRIVATE_KEY");
      }
    });

    it("should return CONFIGURATION_ERROR when IMAGEKIT_URL_ENDPOINT is missing", () => {
      process.env.IMAGEKIT_PUBLIC_KEY = "test-public-key";
      process.env.IMAGEKIT_PRIVATE_KEY = "test-private-key";

      const result = createImageKitClient();

      expect(result.success).toBe(false);
      if (!result.success) {
        expect(result.error.code).toBe("CONFIGURATION_ERROR");
        expect(result.error.message).toContain("IMAGEKIT_URL_ENDPOINT");
      }
    });

    it("should create client successfully when all config is present", () => {
      process.env.IMAGEKIT_PUBLIC_KEY = "test-public-key";
      process.env.IMAGEKIT_PRIVATE_KEY = "test-private-key";
      process.env.IMAGEKIT_URL_ENDPOINT = "https://ik.imagekit.io/test";

      const result = createImageKitClient();

      expect(result.success).toBe(true);
      if (result.success) {
        expect(result.data).toBeDefined();
        expect(typeof result.data.getUploadCredentials).toBe("function");
      }
    });

    describe("getUploadCredentials", () => {
      beforeEach(() => {
        process.env.IMAGEKIT_PUBLIC_KEY = "test-public-key";
        process.env.IMAGEKIT_PRIVATE_KEY = "test-private-key";
        process.env.IMAGEKIT_URL_ENDPOINT = "https://ik.imagekit.io/test";
      });

      it("should return valid upload credentials", () => {
        const clientResult = createImageKitClient();
        expect(clientResult.success).toBe(true);
        if (!clientResult.success) return;

        const service = clientResult.data;
        const result = service.getUploadCredentials(1);

        expect(result.success).toBe(true);
        if (result.success) {
          expect(result.data.token).toBeDefined();
          expect(typeof result.data.token).toBe("string");
          expect(result.data.signature).toBeDefined();
          expect(typeof result.data.signature).toBe("string");
          expect(result.data.expire).toBeDefined();
          expect(typeof result.data.expire).toBe("number");
          expect(result.data.publicKey).toBe("test-public-key");
          expect(result.data.uploadEndpoint).toBe(
            "https://upload.imagekit.io/api/v1/files/upload",
          );
        }
      });

      it("should set expire time approximately 30 minutes in the future", () => {
        const clientResult = createImageKitClient();
        expect(clientResult.success).toBe(true);
        if (!clientResult.success) return;

        const service = clientResult.data;
        const result = service.getUploadCredentials(1);

        expect(result.success).toBe(true);
        if (result.success) {
          const now = Math.floor(Date.now() / 1000);
          const thirtyMinutes = 30 * 60;
          const tolerance = 60;

          expect(result.data.expire).toBeGreaterThanOrEqual(
            now + thirtyMinutes - tolerance,
          );
          expect(result.data.expire).toBeLessThanOrEqual(
            now + thirtyMinutes + tolerance,
          );
        }
      });
    });
  });
});
