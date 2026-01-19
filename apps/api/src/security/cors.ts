export interface CorsConfig {
  origin?: string | string[];
  credentials?: boolean;
  methods?: string[];
  allowedHeaders?: string[];
}

export interface CorsOptions {
  origin: string | string[] | undefined;
  credentials: boolean;
  methods?: string[];
  allowedHeaders?: string[];
}

const DEFAULT_DEVELOPMENT_ORIGIN = "http://localhost:3000";

export function getCorsOrigin(): string | string[] | undefined {
  const corsOrigin = process.env.CORS_ORIGIN;

  if (corsOrigin) {
    if (corsOrigin.includes(",")) {
      return corsOrigin.split(",").map((origin) => origin.trim());
    }
    return corsOrigin;
  }

  if (process.env.NODE_ENV === "development") {
    return DEFAULT_DEVELOPMENT_ORIGIN;
  }

  return undefined;
}

export function createCorsOptions(config?: CorsConfig): CorsOptions {
  const origin = config?.origin ?? getCorsOrigin();

  return {
    origin,
    credentials: config?.credentials ?? true,
    methods: config?.methods,
    allowedHeaders: config?.allowedHeaders,
  };
}
