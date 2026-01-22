type NodeEnv = "development" | "production" | "test";
type LogLevel = "debug" | "info" | "warn" | "error";

interface DatabaseEnvConfig {
  DATABASE_URL: string;
  DB_POOL_MAX?: number;
  DB_IDLE_TIMEOUT_MS?: number;
  DB_CONNECTION_TIMEOUT_MS?: number;
}

interface ServerEnvConfig {
  PORT?: number;
  NODE_ENV: NodeEnv;
  LOG_LEVEL?: LogLevel;
}

interface SecurityEnvConfig {
  CORS_ORIGIN?: string;
  RATE_LIMIT_MAX?: number;
  FIREBASE_PROJECT_ID?: string;
  FIREBASE_CLIENT_EMAIL?: string;
  FIREBASE_PRIVATE_KEY?: string;
}

interface ExternalApiConfig {
  GOOGLE_BOOKS_API_KEY?: string;
}

type AppConfig = DatabaseEnvConfig &
  ServerEnvConfig &
  SecurityEnvConfig &
  ExternalApiConfig;

type ConfigErrorCode = "MISSING_REQUIRED" | "INVALID_VALUE";

export class ConfigError extends Error {
  public readonly code: ConfigErrorCode;
  public readonly key: string;

  constructor(code: ConfigErrorCode, key: string, message: string) {
    super(message);
    this.name = "ConfigError";
    this.code = code;
    this.key = key;
  }
}

const VALID_NODE_ENVS: NodeEnv[] = ["development", "production", "test"];
const VALID_LOG_LEVELS: LogLevel[] = ["debug", "info", "warn", "error"];

class ConfigManager {
  get<K extends keyof AppConfig>(key: K): AppConfig[K] | undefined {
    const value = process.env[key];
    if (value === undefined) {
      return undefined;
    }
    return value as AppConfig[K];
  }

  getOrDefault<K extends keyof AppConfig>(
    key: K,
    defaultValue: NonNullable<AppConfig[K]>,
  ): NonNullable<AppConfig[K]> {
    const value = process.env[key];
    if (value === undefined) {
      return defaultValue;
    }

    if (typeof defaultValue === "number") {
      const parsed = Number.parseInt(value, 10);
      if (Number.isNaN(parsed)) {
        return defaultValue;
      }
      return parsed as NonNullable<AppConfig[K]>;
    }

    return value as NonNullable<AppConfig[K]>;
  }

  validate(): void {
    const requiredVars: (keyof AppConfig)[] = ["DATABASE_URL", "NODE_ENV"];

    for (const key of requiredVars) {
      if (!process.env[key]) {
        throw new ConfigError(
          "MISSING_REQUIRED",
          key,
          `Required environment variable ${key} is not set`,
        );
      }
    }

    const nodeEnv = process.env.NODE_ENV;
    if (nodeEnv && !VALID_NODE_ENVS.includes(nodeEnv as NodeEnv)) {
      throw new ConfigError(
        "INVALID_VALUE",
        "NODE_ENV",
        `NODE_ENV must be one of: ${VALID_NODE_ENVS.join(", ")}`,
      );
    }

    const logLevel = process.env.LOG_LEVEL;
    if (logLevel && !VALID_LOG_LEVELS.includes(logLevel as LogLevel)) {
      throw new ConfigError(
        "INVALID_VALUE",
        "LOG_LEVEL",
        `LOG_LEVEL must be one of: ${VALID_LOG_LEVELS.join(", ")}`,
      );
    }
  }

  isDevelopment(): boolean {
    return process.env.NODE_ENV === "development";
  }

  isProduction(): boolean {
    return process.env.NODE_ENV === "production";
  }

  isTest(): boolean {
    return process.env.NODE_ENV === "test";
  }
}

export const config = new ConfigManager();
