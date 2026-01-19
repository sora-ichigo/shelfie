import { describe, expect, it, beforeAll, vi } from "vitest";
import type {
  GraphQLEnumType,
  GraphQLInputObjectType,
  GraphQLObjectType,
  GraphQLSchema,
  GraphQLUnionType,
} from "graphql";
import { createTestBuilder } from "../../graphql/builder.js";
import { registerAuthTypes, registerAuthMutations } from "./types.js";
import { registerUserTypes } from "../users/types.js";
import type { AuthService } from "./service.js";

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
      expect(values).toContain("USER_NOT_FOUND");
      expect(values).toContain("EMAIL_ALREADY_VERIFIED");
      expect(values).toContain("RATE_LIMIT_EXCEEDED");
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

  describe("ResendVerificationEmailInput type", () => {
    it("should define ResendVerificationEmailInput input type with email", () => {
      const inputType = schema.getType(
        "ResendVerificationEmailInput",
      ) as GraphQLInputObjectType;

      expect(inputType).toBeDefined();
      const fields = inputType.getFields();
      expect(fields.email).toBeDefined();
    });
  });
});

describe("Auth GraphQL Mutations Schema", () => {
  const createMockAuthService = (): AuthService => ({
    register: vi.fn(),
    resendVerificationEmail: vi.fn(),
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
    expect(registerUserField?.type.toString()).toBe("MutationRegisterUserResult");

    const resultType = schema.getType("MutationRegisterUserResult") as GraphQLUnionType;
    expect(resultType).toBeDefined();
    const unionTypes = resultType.getTypes().map((t) => t.name);
    expect(unionTypes).toContain("MutationRegisterUserSuccess");
    expect(unionTypes).toContain("AuthError");

    const args = registerUserField?.args;
    expect(args?.length).toBe(1);
    expect(args?.[0].name).toBe("input");
    expect(args?.[0].type.toString()).toBe("RegisterUserInput!");
  });

  it("should define resendVerificationEmail mutation with Result union type", () => {
    const mockAuthService = createMockAuthService();
    const schema = createSchemaWithMutations(mockAuthService);
    const mutationType = schema.getMutationType();

    expect(mutationType).toBeDefined();
    const fields = mutationType?.getFields();
    expect(fields?.resendVerificationEmail).toBeDefined();

    const resendField = fields?.resendVerificationEmail;
    expect(resendField?.type.toString()).toBe("MutationResendVerificationEmailResult");

    const resultType = schema.getType("MutationResendVerificationEmailResult") as GraphQLUnionType;
    expect(resultType).toBeDefined();
    const unionTypes = resultType.getTypes().map((t) => t.name);
    expect(unionTypes).toContain("MutationResendVerificationEmailSuccess");
    expect(unionTypes).toContain("AuthError");

    const args = resendField?.args;
    expect(args?.length).toBe(1);
    expect(args?.[0].name).toBe("input");
    expect(args?.[0].type.toString()).toBe("ResendVerificationEmailInput!");
  });
});
