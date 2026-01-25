import { afterEach, beforeEach, describe, expect, it, vi } from "vitest";
import { createTestBuilder } from "../../../graphql/builder.js";
import {
  registerImageUploadQueries,
  registerImageUploadTypes,
} from "./graphql.js";

describe("ImageUpload GraphQL", () => {
  const originalEnv = process.env;

  beforeEach(() => {
    vi.resetModules();
    process.env = { ...originalEnv };
    process.env.IMAGEKIT_PUBLIC_KEY = "test-public-key";
    process.env.IMAGEKIT_PRIVATE_KEY = "test-private-key";
    process.env.IMAGEKIT_URL_ENDPOINT = "https://ik.imagekit.io/test";
  });

  afterEach(() => {
    process.env = originalEnv;
  });

  describe("registerImageUploadTypes", () => {
    it("should register UploadCredentials type", () => {
      const builder = createTestBuilder();
      registerImageUploadTypes(builder);

      const schema = builder.toSchema();
      const uploadCredentialsType = schema.getType("UploadCredentials");

      expect(uploadCredentialsType).toBeDefined();
    });
  });

  describe("getUploadCredentials Query", () => {
    it("should register getUploadCredentials query", async () => {
      const builder = createTestBuilder();
      registerImageUploadTypes(builder);

      builder.queryType({
        fields: (t) => ({
          _placeholder: t.string({ resolve: () => "placeholder" }),
        }),
      });

      registerImageUploadQueries(builder);

      const schema = builder.toSchema();
      const queryType = schema.getQueryType();
      const fields = queryType?.getFields();

      expect(fields?.getUploadCredentials).toBeDefined();
    });

    it("should register ImageUploadError type", async () => {
      const builder = createTestBuilder();
      registerImageUploadTypes(builder);

      builder.queryType({
        fields: (t) => ({
          _placeholder: t.string({ resolve: () => "placeholder" }),
        }),
      });

      registerImageUploadQueries(builder);

      const schema = builder.toSchema();
      const imageUploadErrorType = schema.getType("ImageUploadError");

      expect(imageUploadErrorType).toBeDefined();
    });
  });
});
