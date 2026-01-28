environment           = "prod"
project_id            = "shelfie-prod"
region                = "asia-northeast1"
min_instances         = 1
max_instances         = 10
cpu_limit             = "2"
memory_limit          = "1Gi"
allow_unauthenticated = false

# GitHub Actions CD
github_owner = "sora-ichigo"
github_repo  = "shelfie"

# Environment Variables
environment_variables = {
  NODE_ENV              = "production"
  FIREBASE_PROJECT_ID   = "shelfie-prod"
  FIREBASE_CLIENT_EMAIL = "" # TODO: Set after creating Firebase service account
  SENTRY_DSN            = "https://fb439c238a42f7a94e2f35d8cc75fdac@o4510782375395328.ingest.us.sentry.io/4510782384111616"
  SENTRY_ENVIRONMENT    = "prod"
}

# Secret Manager (create secrets manually: gcloud secrets create <secret-name> --data-file=-)
secret_environment_variables = {
  DATABASE_URL         = "shelfie-api-database-url"
  FIREBASE_PRIVATE_KEY = "shelfie-api-firebase-private-key"
}
