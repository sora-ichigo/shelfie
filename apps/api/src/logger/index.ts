import pino, { type Logger as PinoLoggerInstance } from "pino";

export type LogLevel = "debug" | "info" | "warn" | "error";

export interface LogContext {
  requestId?: string;
  userId?: string;
  feature?: string;
  [key: string]: unknown;
}

export interface LoggerConfig {
  level?: LogLevel;
  prettyPrint?: boolean;
}

export interface LoggerService {
  debug(message: string, context?: LogContext): void;
  info(message: string, context?: LogContext): void;
  warn(message: string, context?: LogContext): void;
  error(message: string, error?: Error, context?: LogContext): void;
  child(bindings: LogContext): LoggerService;
}

function getLogLevel(): LogLevel {
  const envLevel = process.env.LOG_LEVEL;
  if (
    envLevel === "debug" ||
    envLevel === "info" ||
    envLevel === "warn" ||
    envLevel === "error"
  ) {
    return envLevel;
  }
  return "info";
}

function isPrettyPrintEnabled(): boolean {
  return process.env.NODE_ENV === "development";
}

function createPinoLogger(config: LoggerConfig = {}): PinoLoggerInstance {
  const level = config.level ?? getLogLevel();
  const prettyPrint = config.prettyPrint ?? isPrettyPrintEnabled();

  const options: pino.LoggerOptions = {
    level,
    formatters: {
      level: (label) => ({ level: label }),
    },
    timestamp: pino.stdTimeFunctions.isoTime,
  };

  if (prettyPrint) {
    return pino({
      ...options,
      transport: {
        target: "pino-pretty",
        options: {
          colorize: true,
          translateTime: "SYS:standard",
          ignore: "pid,hostname",
        },
      },
    });
  }

  return pino(options);
}

class Logger implements LoggerService {
  private pinoLogger: PinoLoggerInstance;

  constructor(pinoLogger: PinoLoggerInstance) {
    this.pinoLogger = pinoLogger;
  }

  debug(message: string, context?: LogContext): void {
    if (context) {
      this.pinoLogger.debug(context, message);
    } else {
      this.pinoLogger.debug(message);
    }
  }

  info(message: string, context?: LogContext): void {
    if (context) {
      this.pinoLogger.info(context, message);
    } else {
      this.pinoLogger.info(message);
    }
  }

  warn(message: string, context?: LogContext): void {
    if (context) {
      this.pinoLogger.warn(context, message);
    } else {
      this.pinoLogger.warn(message);
    }
  }

  error(message: string, error?: Error, context?: LogContext): void {
    const logData: Record<string, unknown> = { ...context };

    if (error) {
      logData.err = {
        message: error.message,
        name: error.name,
        stack: error.stack,
      };
    }

    if (Object.keys(logData).length > 0) {
      this.pinoLogger.error(logData, message);
    } else {
      this.pinoLogger.error(message);
    }
  }

  child(bindings: LogContext): LoggerService {
    return new Logger(this.pinoLogger.child(bindings));
  }
}

export function createLogger(config: LoggerConfig = {}): LoggerService {
  const pinoLogger = createPinoLogger(config);
  return new Logger(pinoLogger);
}

export const logger = createLogger();
