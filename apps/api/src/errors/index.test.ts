import { GraphQLError } from "graphql";
import { beforeEach, describe, expect, it, vi } from "vitest";
import type { LoggerService } from "../logger";
import {
  createBusinessError,
  createSystemError,
  createUserError,
  type ErrorCategory,
  ErrorHandler,
} from "./index";

function createMockLogger(): LoggerService {
  return {
    debug: vi.fn(),
    info: vi.fn(),
    warn: vi.fn(),
    error: vi.fn(),
    child: vi.fn().mockReturnThis(),
  };
}

describe("ErrorHandler", () => {
  let mockLogger: LoggerService;
  let errorHandler: ErrorHandler;

  beforeEach(() => {
    mockLogger = createMockLogger();
  });

  describe("formatError", () => {
    describe("in development environment", () => {
      beforeEach(() => {
        errorHandler = new ErrorHandler(mockLogger, false);
      });

      it("should preserve stack trace in development", () => {
        const originalError = new GraphQLError("Test error", {
          extensions: {
            code: "TEST_ERROR",
            category: "USER_ERROR" as ErrorCategory,
            stacktrace: ["at test.ts:10", "at main.ts:20"],
          },
        });

        const formattedError = {
          message: "Test error",
          extensions: {
            code: "TEST_ERROR",
            category: "USER_ERROR",
            stacktrace: ["at test.ts:10", "at main.ts:20"],
          },
        };

        const result = errorHandler.formatError(formattedError, originalError);

        expect(result.extensions?.stacktrace).toBeDefined();
        expect(result.extensions?.stacktrace).toEqual([
          "at test.ts:10",
          "at main.ts:20",
        ]);
      });

      it("should add timestamp to error response", () => {
        const originalError = new GraphQLError("Test error", {
          extensions: { code: "TEST_ERROR" },
        });

        const formattedError = {
          message: "Test error",
          extensions: { code: "TEST_ERROR" },
        };

        const result = errorHandler.formatError(formattedError, originalError);

        expect(result.extensions?.timestamp).toBeDefined();
        expect(typeof result.extensions?.timestamp).toBe("string");
      });
    });

    describe("in production environment", () => {
      beforeEach(() => {
        errorHandler = new ErrorHandler(mockLogger, true);
      });

      it("should mask stack trace in production", () => {
        const originalError = new GraphQLError("Test error", {
          extensions: {
            code: "TEST_ERROR",
            category: "SYSTEM_ERROR" as ErrorCategory,
            stacktrace: ["at test.ts:10", "at main.ts:20"],
          },
        });

        const formattedError = {
          message: "Test error",
          extensions: {
            code: "TEST_ERROR",
            category: "SYSTEM_ERROR",
            stacktrace: ["at test.ts:10", "at main.ts:20"],
          },
        };

        const result = errorHandler.formatError(formattedError, originalError);

        expect(result.extensions?.stacktrace).toBeUndefined();
      });

      it("should mask internal error messages for SYSTEM_ERROR", () => {
        const originalError = new GraphQLError("Database connection failed", {
          extensions: {
            code: "DATABASE_ERROR",
            category: "SYSTEM_ERROR" as ErrorCategory,
          },
        });

        const formattedError = {
          message: "Database connection failed",
          extensions: {
            code: "DATABASE_ERROR",
            category: "SYSTEM_ERROR",
          },
        };

        const result = errorHandler.formatError(formattedError, originalError);

        expect(result.message).toBe("Internal server error");
      });

      it("should preserve user-facing messages for USER_ERROR", () => {
        const originalError = new GraphQLError("Invalid email format", {
          extensions: {
            code: "BAD_USER_INPUT",
            category: "USER_ERROR" as ErrorCategory,
          },
        });

        const formattedError = {
          message: "Invalid email format",
          extensions: {
            code: "BAD_USER_INPUT",
            category: "USER_ERROR",
          },
        };

        const result = errorHandler.formatError(formattedError, originalError);

        expect(result.message).toBe("Invalid email format");
      });

      it("should preserve messages for BUSINESS_ERROR", () => {
        const originalError = new GraphQLError("User already exists", {
          extensions: {
            code: "USER_EXISTS",
            category: "BUSINESS_ERROR" as ErrorCategory,
          },
        });

        const formattedError = {
          message: "User already exists",
          extensions: {
            code: "USER_EXISTS",
            category: "BUSINESS_ERROR",
          },
        };

        const result = errorHandler.formatError(formattedError, originalError);

        expect(result.message).toBe("User already exists");
      });
    });

    describe("error logging", () => {
      beforeEach(() => {
        errorHandler = new ErrorHandler(mockLogger, false);
      });

      it("should log SYSTEM_ERROR with error level", () => {
        const originalError = new GraphQLError("Database error", {
          extensions: {
            code: "DATABASE_ERROR",
            category: "SYSTEM_ERROR" as ErrorCategory,
          },
        });

        const formattedError = {
          message: "Database error",
          extensions: {
            code: "DATABASE_ERROR",
            category: "SYSTEM_ERROR",
          },
        };

        errorHandler.formatError(formattedError, originalError);

        expect(mockLogger.error).toHaveBeenCalled();
      });

      it("should log USER_ERROR with warn level", () => {
        const originalError = new GraphQLError("Invalid input", {
          extensions: {
            code: "BAD_USER_INPUT",
            category: "USER_ERROR" as ErrorCategory,
          },
        });

        const formattedError = {
          message: "Invalid input",
          extensions: {
            code: "BAD_USER_INPUT",
            category: "USER_ERROR",
          },
        };

        errorHandler.formatError(formattedError, originalError);

        expect(mockLogger.warn).toHaveBeenCalled();
      });

      it("should log BUSINESS_ERROR with info level", () => {
        const originalError = new GraphQLError("Business rule violation", {
          extensions: {
            code: "BUSINESS_RULE",
            category: "BUSINESS_ERROR" as ErrorCategory,
          },
        });

        const formattedError = {
          message: "Business rule violation",
          extensions: {
            code: "BUSINESS_RULE",
            category: "BUSINESS_ERROR",
          },
        };

        errorHandler.formatError(formattedError, originalError);

        expect(mockLogger.info).toHaveBeenCalled();
      });
    });
  });
});

describe("Error factory functions", () => {
  describe("createUserError", () => {
    it("should create a USER_ERROR with correct properties", () => {
      const error = createUserError("BAD_USER_INPUT", "Invalid email format");

      expect(error.code).toBe("BAD_USER_INPUT");
      expect(error.message).toBe("Invalid email format");
      expect(error.category).toBe("USER_ERROR");
    });

    it("should include optional extensions", () => {
      const error = createUserError("BAD_USER_INPUT", "Invalid email format", {
        field: "email",
      });

      expect(error.extensions).toEqual({ field: "email" });
    });
  });

  describe("createSystemError", () => {
    it("should create a SYSTEM_ERROR with correct properties", () => {
      const error = createSystemError("DATABASE_ERROR", "Connection failed");

      expect(error.code).toBe("DATABASE_ERROR");
      expect(error.message).toBe("Connection failed");
      expect(error.category).toBe("SYSTEM_ERROR");
    });

    it("should include cause error if provided", () => {
      const cause = new Error("Original error");
      const error = createSystemError(
        "DATABASE_ERROR",
        "Connection failed",
        cause,
      );

      expect(error.cause).toBe(cause);
    });
  });

  describe("createBusinessError", () => {
    it("should create a BUSINESS_ERROR with correct properties", () => {
      const error = createBusinessError("USER_EXISTS", "User already exists");

      expect(error.code).toBe("USER_EXISTS");
      expect(error.message).toBe("User already exists");
      expect(error.category).toBe("BUSINESS_ERROR");
    });

    it("should include optional extensions", () => {
      const error = createBusinessError("USER_EXISTS", "User already exists", {
        userId: "123",
      });

      expect(error.extensions).toEqual({ userId: "123" });
    });
  });
});

describe("AppError to GraphQLError conversion", () => {
  let errorHandler: ErrorHandler;

  beforeEach(() => {
    const mockLogger = createMockLogger();
    errorHandler = new ErrorHandler(mockLogger, false);
  });

  it("should convert AppError to GraphQLError", () => {
    const appError = createUserError("BAD_USER_INPUT", "Invalid input");
    const graphqlError = errorHandler.toGraphQLError(appError);

    expect(graphqlError).toBeInstanceOf(GraphQLError);
    expect(graphqlError.message).toBe("Invalid input");
    expect(graphqlError.extensions.code).toBe("BAD_USER_INPUT");
    expect(graphqlError.extensions.category).toBe("USER_ERROR");
  });

  it("should preserve extensions in conversion", () => {
    const appError = createUserError("BAD_USER_INPUT", "Invalid input", {
      field: "email",
    });
    const graphqlError = errorHandler.toGraphQLError(appError);

    expect(graphqlError.extensions.field).toBe("email");
  });
});
