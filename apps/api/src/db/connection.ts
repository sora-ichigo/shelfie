import { Pool, type PoolConfig } from "pg";
import { config } from "../config/index.js";

type ConnectionErrorCode = "CONNECTION_FAILED" | "TIMEOUT" | "POOL_EXHAUSTED";

export class ConnectionError extends Error {
  public readonly code: ConnectionErrorCode;
  public readonly retryable: boolean;

  constructor(code: ConnectionErrorCode, message: string, retryable: boolean) {
    super(message);
    this.name = "ConnectionError";
    this.code = code;
    this.retryable = retryable;
  }
}

interface ConnectOptions {
  maxRetries?: number;
  retryDelayMs?: number;
}

export interface DatabaseConnection {
  getPool(): Pool;
  connect(options?: ConnectOptions): Promise<void>;
  disconnect(): Promise<void>;
  healthCheck(): Promise<boolean>;
}

interface DatabaseConnectionConfig {
  connectionString: string;
  max: number;
  idleTimeoutMillis: number;
  connectionTimeoutMillis: number;
}

function getConnectionConfig(): DatabaseConnectionConfig {
  const connectionString = config.get("DATABASE_URL");
  if (!connectionString) {
    throw new ConnectionError(
      "CONNECTION_FAILED",
      "DATABASE_URL environment variable is not set",
      false,
    );
  }

  return {
    connectionString,
    max: config.getOrDefault("DB_POOL_MAX", 20),
    idleTimeoutMillis: config.getOrDefault("DB_IDLE_TIMEOUT_MS", 30000),
    connectionTimeoutMillis: config.getOrDefault(
      "DB_CONNECTION_TIMEOUT_MS",
      5000,
    ),
  };
}

async function sleep(ms: number): Promise<void> {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

export function createDatabaseConnection(): DatabaseConnection {
  const connectionConfig = getConnectionConfig();

  const poolConfig: PoolConfig = {
    connectionString: connectionConfig.connectionString,
    max: connectionConfig.max,
    idleTimeoutMillis: connectionConfig.idleTimeoutMillis,
    connectionTimeoutMillis: connectionConfig.connectionTimeoutMillis,
  };

  const pool = new Pool(poolConfig);

  pool.on("error", (err) => {
    console.error("Unexpected error on idle client", err);
  });

  return {
    getPool(): Pool {
      return pool;
    },

    async connect(options: ConnectOptions = {}): Promise<void> {
      const { maxRetries = 3, retryDelayMs = 1000 } = options;
      let lastError: Error | undefined;

      for (let attempt = 1; attempt <= maxRetries; attempt++) {
        try {
          await pool.query("SELECT 1");
          return;
        } catch (err) {
          lastError = err instanceof Error ? err : new Error(String(err));

          if (attempt < maxRetries) {
            await sleep(retryDelayMs);
          }
        }
      }

      throw new ConnectionError(
        "CONNECTION_FAILED",
        `Failed to connect to database after ${maxRetries} attempts: ${lastError?.message}`,
        true,
      );
    },

    async disconnect(): Promise<void> {
      await pool.end();
    },

    async healthCheck(): Promise<boolean> {
      try {
        await pool.query("SELECT 1");
        return true;
      } catch {
        return false;
      }
    },
  };
}

export function createDatabaseConnectionWithPool(
  pool: Pool,
): DatabaseConnection {
  return {
    getPool(): Pool {
      return pool;
    },

    async connect(options: ConnectOptions = {}): Promise<void> {
      const { maxRetries = 3, retryDelayMs = 1000 } = options;
      let lastError: Error | undefined;

      for (let attempt = 1; attempt <= maxRetries; attempt++) {
        try {
          await pool.query("SELECT 1");
          return;
        } catch (err) {
          lastError = err instanceof Error ? err : new Error(String(err));

          if (attempt < maxRetries) {
            await sleep(retryDelayMs);
          }
        }
      }

      throw new ConnectionError(
        "CONNECTION_FAILED",
        `Failed to connect to database after ${maxRetries} attempts: ${lastError?.message}`,
        true,
      );
    },

    async disconnect(): Promise<void> {
      await pool.end();
    },

    async healthCheck(): Promise<boolean> {
      try {
        await pool.query("SELECT 1");
        return true;
      } catch {
        return false;
      }
    },
  };
}
