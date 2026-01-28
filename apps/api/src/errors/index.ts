import { GraphQLError, type GraphQLFormattedError } from "graphql";
import type { LoggerService } from "../logger";
import { isSentryEnabled, Sentry } from "../sentry.js";

export type ErrorCategory = "USER_ERROR" | "SYSTEM_ERROR" | "BUSINESS_ERROR";

export interface AppError {
  code: string;
  message: string;
  category: ErrorCategory;
  extensions?: Record<string, unknown>;
  cause?: Error;
}

export interface FormattedErrorResponse {
  message: string;
  extensions: {
    code: string;
    category: ErrorCategory;
    timestamp: string;
    requestId?: string;
    [key: string]: unknown;
  };
}

export function createUserError(
  code: string,
  message: string,
  extensions?: Record<string, unknown>,
): AppError {
  return {
    code,
    message,
    category: "USER_ERROR",
    extensions,
  };
}

export function createSystemError(
  code: string,
  message: string,
  cause?: Error,
): AppError {
  return {
    code,
    message,
    category: "SYSTEM_ERROR",
    cause,
  };
}

export function createBusinessError(
  code: string,
  message: string,
  extensions?: Record<string, unknown>,
): AppError {
  return {
    code,
    message,
    category: "BUSINESS_ERROR",
    extensions,
  };
}

export class ErrorHandler {
  private logger: LoggerService;
  private isProduction: boolean;

  constructor(logger: LoggerService, isProduction: boolean) {
    this.logger = logger;
    this.isProduction = isProduction;
  }

  formatError(
    formattedError: GraphQLFormattedError,
    originalError: unknown,
  ): GraphQLFormattedError {
    const extensions = formattedError.extensions ?? {};
    const category = extensions.category as ErrorCategory | undefined;
    const code = (extensions.code as string) ?? "INTERNAL_SERVER_ERROR";

    this.logError(formattedError.message, category, originalError);

    const timestamp = new Date().toISOString();

    if (this.isProduction) {
      const maskedExtensions: Record<string, unknown> = {
        code,
        category: category ?? "SYSTEM_ERROR",
        timestamp,
      };

      for (const [key, value] of Object.entries(extensions)) {
        if (key !== "stacktrace" && key !== "code" && key !== "category") {
          maskedExtensions[key] = value;
        }
      }

      const maskedMessage =
        category === "SYSTEM_ERROR" || !category
          ? "Internal server error"
          : formattedError.message;

      return {
        ...formattedError,
        message: maskedMessage,
        extensions: maskedExtensions,
      };
    }

    return {
      ...formattedError,
      extensions: {
        ...extensions,
        code,
        category: category ?? "SYSTEM_ERROR",
        timestamp,
      },
    };
  }

  toGraphQLError(appError: AppError): GraphQLError {
    return new GraphQLError(appError.message, {
      extensions: {
        code: appError.code,
        category: appError.category,
        ...appError.extensions,
      },
    });
  }

  private logError(
    message: string,
    category: ErrorCategory | undefined,
    originalError: unknown,
  ): void {
    const errorInstance =
      originalError instanceof Error ? originalError : undefined;

    switch (category) {
      case "USER_ERROR":
        this.logger.warn(`GraphQL User Error: ${message}`);
        break;
      case "BUSINESS_ERROR":
        this.logger.info(`GraphQL Business Error: ${message}`);
        break;
      default:
        this.logger.error(`GraphQL System Error: ${message}`, errorInstance);
        if (isSentryEnabled() && errorInstance) {
          Sentry.captureException(errorInstance);
        }
        break;
    }
  }
}

export function createErrorHandler(
  logger: LoggerService,
  isProduction: boolean,
): ErrorHandler {
  return new ErrorHandler(logger, isProduction);
}

export type { DomainError, Result } from "./result";
export {
  err,
  isErr,
  isOk,
  mapErr,
  mapResult,
  ok,
  unwrap,
  unwrapOr,
} from "./result";
