import type {
  GraphQLEnumType,
  GraphQLInputObjectType,
  GraphQLObjectType,
  GraphQLSchema,
  GraphQLUnionType,
} from "graphql";
import { beforeAll, describe, expect, it, vi } from "vitest";
import { createTestBuilder } from "../../../graphql/builder.js";
import { registerUserTypes } from "../../users/internal/graphql.js";
import {
  AuthError,
  mapServiceErrorToAuthError,
  registerAuthMutations,
  registerAuthTypes,
} from "./graphql.js";
import type { AuthService, AuthServiceError } from "./service.js";

describe("Auth GraphQL Types", () => {
  let schema: GraphQLSchema;

  beforeAll(() => {
    const builder = createTestBuilder();

    registerUserTypes(builder);
    registerAuthTypes(builder);

    builder.queryType({
      fields: (t) => ({
        _dummy: t.string({ resolve: () => "test" }),
      }),
    });

    builder.mutationType({});

    schema = builder.toSchema();
  });

  describe("AuthErrorCode enum", () => {
    it("should define AuthErrorCode enum with all error codes", () => {
      const enumType = schema.getType("AuthErrorCode") as GraphQLEnumType;

      expect(enumType).toBeDefined();
      const values = enumType.getValues().map((v) => v.name);
      expect(values).toContain("EMAIL_ALREADY_EXISTS");
      expect(values).toContain("INVALID_PASSWORD");
      expect(values).toContain("NETWORK_ERROR");
      expect(values).toContain("INTERNAL_ERROR");
    });
  });

  describe("AuthError type", () => {
    it("should define AuthError object type with required fields", () => {
      const objectType = schema.getType("AuthError") as GraphQLObjectType;

      expect(objectType).toBeDefined();
      const fields = objectType.getFields();
      expect(fields.code).toBeDefined();
      expect(fields.message).toBeDefined();
      expect(fields.field).toBeDefined();
      expect(fields.retryable).toBeDefined();
    });
  });

  describe("RegisterUserInput type", () => {
    it("should define RegisterUserInput input type with email and password", () => {
      const inputType = schema.getType(
        "RegisterUserInput",
      ) as GraphQLInputObjectType;

      expect(inputType).toBeDefined();
      const fields = inputType.getFields();
      expect(fields.email).toBeDefined();
      expect(fields.password).toBeDefined();
    });
  });
});

describe("Auth GraphQL Mutations Schema", () => {
  const createMockAuthService = (): AuthService => ({
    register: vi.fn(),
  });

  const createSchemaWithMutations = (authService: AuthService) => {
    const builder = createTestBuilder();

    registerUserTypes(builder);
    registerAuthTypes(builder);

    builder.queryType({
      fields: (t) => ({
        _dummy: t.string({ resolve: () => "test" }),
      }),
    });

    registerAuthMutations(builder, authService);

    return builder.toSchema();
  };

  it("should define registerUser mutation with Result union type", () => {
    const mockAuthService = createMockAuthService();
    const schema = createSchemaWithMutations(mockAuthService);
    const mutationType = schema.getMutationType();

    expect(mutationType).toBeDefined();
    const fields = mutationType?.getFields();
    expect(fields?.registerUser).toBeDefined();

    const registerUserField = fields?.registerUser;
    expect(registerUserField?.type.toString()).toBe(
      "MutationRegisterUserResult",
    );

    const resultType = schema.getType(
      "MutationRegisterUserResult",
    ) as GraphQLUnionType;
    expect(resultType).toBeDefined();
    const unionTypes = resultType.getTypes().map((t) => t.name);
    expect(unionTypes).toContain("MutationRegisterUserSuccess");
    expect(unionTypes).toContain("AuthError");

    const args = registerUserField?.args;
    expect(args?.length).toBe(1);
    expect(args?.[0].name).toBe("input");
    expect(args?.[0].type.toString()).toBe("RegisterUserInput!");
  });
});

describe("mapServiceErrorToAuthError", () => {
  it("should map EMAIL_ALREADY_EXISTS error with email field", () => {
    const error: AuthServiceError = {
      code: "EMAIL_ALREADY_EXISTS",
      message: "このメールアドレスは既に使用されています",
    };

    const result = mapServiceErrorToAuthError(error);

    expect(result).toBeInstanceOf(AuthError);
    expect(result.code).toBe("EMAIL_ALREADY_EXISTS");
    expect(result.message).toBe("このメールアドレスは既に使用されています");
    expect(result.field).toBe("email");
    expect(result.retryable).toBe(false);
  });

  it("should map INVALID_PASSWORD error with password field", () => {
    const error: AuthServiceError = {
      code: "INVALID_PASSWORD",
      message: "パスワードは8文字以上で入力してください",
      requirements: ["8文字以上"],
    };

    const result = mapServiceErrorToAuthError(error);

    expect(result).toBeInstanceOf(AuthError);
    expect(result.code).toBe("INVALID_PASSWORD");
    expect(result.field).toBe("password");
    expect(result.retryable).toBe(false);
  });

  it("should map NETWORK_ERROR with retryable flag", () => {
    const error: AuthServiceError = {
      code: "NETWORK_ERROR",
      message: "ネットワークエラーが発生しました",
      retryable: true,
    };

    const result = mapServiceErrorToAuthError(error);

    expect(result).toBeInstanceOf(AuthError);
    expect(result.code).toBe("NETWORK_ERROR");
    expect(result.field).toBeNull();
    expect(result.retryable).toBe(true);
  });

  it("should map FIREBASE_ERROR to INTERNAL_ERROR", () => {
    const error: AuthServiceError = {
      code: "FIREBASE_ERROR",
      message: "Firebase認証でエラーが発生しました",
      originalCode: "auth/unknown-error",
    };

    const result = mapServiceErrorToAuthError(error);

    expect(result).toBeInstanceOf(AuthError);
    expect(result.code).toBe("INTERNAL_ERROR");
    expect(result.field).toBeNull();
    expect(result.retryable).toBe(false);
  });

  it("should map INTERNAL_ERROR correctly", () => {
    const error: AuthServiceError = {
      code: "INTERNAL_ERROR",
      message: "予期しないエラーが発生しました",
    };

    const result = mapServiceErrorToAuthError(error);

    expect(result).toBeInstanceOf(AuthError);
    expect(result.code).toBe("INTERNAL_ERROR");
    expect(result.field).toBeNull();
    expect(result.retryable).toBe(false);
  });
});

describe("AuthError class", () => {
  it("should create AuthError with all properties", () => {
    const error = new AuthError(
      "EMAIL_ALREADY_EXISTS",
      "Test message",
      "email",
      false,
    );

    expect(error).toBeInstanceOf(Error);
    expect(error.name).toBe("AuthError");
    expect(error.code).toBe("EMAIL_ALREADY_EXISTS");
    expect(error.message).toBe("Test message");
    expect(error.field).toBe("email");
    expect(error.retryable).toBe(false);
  });

  it("should create AuthError with default values", () => {
    const error = new AuthError("INTERNAL_ERROR", "Error message");

    expect(error.field).toBeNull();
    expect(error.retryable).toBe(false);
  });

  it("should create AuthError with retryable flag", () => {
    const error = new AuthError("NETWORK_ERROR", "Network error", null, true);

    expect(error.retryable).toBe(true);
  });
});
