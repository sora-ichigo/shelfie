import * as Sentry from "@sentry/node";
import { config } from "./config";

const dsn = config.get("SENTRY_DSN");

if (dsn) {
  Sentry.init({
    dsn,
    environment: config.get("SENTRY_ENVIRONMENT") ?? "local",
    tracesSampleRate: 0.1,
    integrations: [Sentry.graphqlIntegration()],
  });
}

export { Sentry };
export const isSentryEnabled = (): boolean => !!dsn;
