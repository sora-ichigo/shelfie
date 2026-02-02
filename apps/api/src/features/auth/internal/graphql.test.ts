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
  AUTH_ERROR_CODES,
  AuthError,
  LOGIN_ERROR_CODES,
  mapLoginErrorToAuthError,
  mapServiceErrorToAuthError,
  registerAuthMutations,
  registerAuthTypes,
} from "./graphql.js";
import type {
  AuthService,
  AuthServiceError,
  LoginServiceError,
} from "./service.js";

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

    it("should include login-related error codes", () => {
      const enumType = schema.getType("AuthErrorCode") as GraphQLEnumType;

      expect(enumType).toBeDefined();
      const values = enumType.getValues().map((v) => v.name);
      expect(values).toContain("INVALID_TOKEN");
      expect(values).toContain("TOKEN_EXPIRED");
      expect(values).toContain("USER_NOT_FOUND");
      expect(values).toContain("UNAUTHENTICATED");
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
    getCurrentUser: vi.fn(),
    login: vi.fn(),
    refreshToken: vi.fn(),
    changePassword: vi.fn(),
    sendPasswordResetEmail: vi.fn(),
    deleteAccount: vi.fn(),
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

  it("should create AuthError with login-related error codes", () => {
    const tokenError = new AuthError("INVALID_TOKEN", "Invalid token");
    expect(tokenError.code).toBe("INVALID_TOKEN");

    const expiredError = new AuthError("TOKEN_EXPIRED", "Token expired");
    expect(expiredError.code).toBe("TOKEN_EXPIRED");

    const notFoundError = new AuthError("USER_NOT_FOUND", "User not found");
    expect(notFoundError.code).toBe("USER_NOT_FOUND");

    const unauthError = new AuthError("UNAUTHENTICATED", "Unauthenticated");
    expect(unauthError.code).toBe("UNAUTHENTICATED");
  });
});

describe("LOGIN_ERROR_CODES", () => {
  it("should define all login-related error codes", () => {
    expect(LOGIN_ERROR_CODES).toContain("INVALID_TOKEN");
    expect(LOGIN_ERROR_CODES).toContain("TOKEN_EXPIRED");
    expect(LOGIN_ERROR_CODES).toContain("USER_NOT_FOUND");
    expect(LOGIN_ERROR_CODES).toContain("UNAUTHENTICATED");
    expect(LOGIN_ERROR_CODES).toContain("INVALID_CREDENTIALS");
  });

  it("should have 5 error codes", () => {
    expect(LOGIN_ERROR_CODES.length).toBe(5);
  });
});

describe("AUTH_ERROR_CODES includes login error codes", () => {
  it("should include all login error codes in AUTH_ERROR_CODES", () => {
    for (const code of LOGIN_ERROR_CODES) {
      expect(AUTH_ERROR_CODES).toContain(code);
    }
  });
});

describe("mapLoginErrorToAuthError", () => {
  it("should map USER_NOT_FOUND error correctly", () => {
    const error: LoginServiceError = {
      code: "USER_NOT_FOUND",
      message: "User not found",
    };

    const result = mapLoginErrorToAuthError(error);

    expect(result).toBeInstanceOf(AuthError);
    expect(result.code).toBe("USER_NOT_FOUND");
    expect(result.message).toBe("User not found");
    expect(result.field).toBeNull();
    expect(result.retryable).toBe(false);
  });

  it("should map INTERNAL_ERROR correctly", () => {
    const error: LoginServiceError = {
      code: "INTERNAL_ERROR",
      message: "Internal error",
    };

    const result = mapLoginErrorToAuthError(error);

    expect(result).toBeInstanceOf(AuthError);
    expect(result.code).toBe("INTERNAL_ERROR");
    expect(result.message).toBe("Internal error");
    expect(result.field).toBeNull();
    expect(result.retryable).toBe(false);
  });

  it("should set retryable to true for TOKEN_EXPIRED", () => {
    const error: LoginServiceError = {
      code: "TOKEN_EXPIRED" as "USER_NOT_FOUND",
      message: "Token expired",
    };

    const result = mapLoginErrorToAuthError(error as LoginServiceError);

    expect(result.retryable).toBe(true);
  });
});

describe("Auth GraphQL Mutations - changePassword and sendPasswordResetEmail", () => {
  const createMockAuthService = (): AuthService => ({
    register: vi.fn(),
    getCurrentUser: vi.fn(),
    login: vi.fn(),
    refreshToken: vi.fn(),
    changePassword: vi.fn(),
    sendPasswordResetEmail: vi.fn(),
    deleteAccount: vi.fn(),
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

  it("should define changePassword mutation with ChangePasswordInput", () => {
    const mockAuthService = createMockAuthService();
    const schema = createSchemaWithMutations(mockAuthService);
    const mutationType = schema.getMutationType();

    expect(mutationType).toBeDefined();
    const fields = mutationType?.getFields();
    expect(fields?.changePassword).toBeDefined();

    const changePasswordField = fields?.changePassword;
    const args = changePasswordField?.args;
    expect(args?.length).toBe(1);
    expect(args?.[0].name).toBe("input");
    expect(args?.[0].type.toString()).toBe("ChangePasswordInput!");
  });

  it("should define ChangePasswordInput with required fields", () => {
    const mockAuthService = createMockAuthService();
    const schema = createSchemaWithMutations(mockAuthService);
    const inputType = schema.getType(
      "ChangePasswordInput",
    ) as GraphQLInputObjectType;

    expect(inputType).toBeDefined();
    const fields = inputType.getFields();
    expect(fields.email).toBeDefined();
    expect(fields.currentPassword).toBeDefined();
    expect(fields.newPassword).toBeDefined();
  });

  it("should define sendPasswordResetEmail mutation with SendPasswordResetEmailInput", () => {
    const mockAuthService = createMockAuthService();
    const schema = createSchemaWithMutations(mockAuthService);
    const mutationType = schema.getMutationType();

    expect(mutationType).toBeDefined();
    const fields = mutationType?.getFields();
    expect(fields?.sendPasswordResetEmail).toBeDefined();

    const sendPasswordResetEmailField = fields?.sendPasswordResetEmail;
    const args = sendPasswordResetEmailField?.args;
    expect(args?.length).toBe(1);
    expect(args?.[0].name).toBe("input");
    expect(args?.[0].type.toString()).toBe("SendPasswordResetEmailInput!");
  });

  it("should define SendPasswordResetEmailInput with email field", () => {
    const mockAuthService = createMockAuthService();
    const schema = createSchemaWithMutations(mockAuthService);
    const inputType = schema.getType(
      "SendPasswordResetEmailInput",
    ) as GraphQLInputObjectType;

    expect(inputType).toBeDefined();
    const fields = inputType.getFields();
    expect(fields.email).toBeDefined();
  });
});
