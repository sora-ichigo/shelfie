environment           = "stg"
project_id            = "shelfie-stg"
region                = "asia-northeast1"
min_instances         = 0
max_instances         = 5
cpu_limit             = "1"
memory_limit          = "512Mi"
allow_unauthenticated = true

# GitHub Actions CD
github_owner = "sora-ichigo"
github_repo  = "shelfie"

# Environment Variables
environment_variables = {
  NODE_ENV              = "production"
  FIREBASE_PROJECT_ID   = "shelfie-stg"
  FIREBASE_CLIENT_EMAIL = "" # TODO: Set after creating Firebase service account
  SENTRY_DSN            = "https://fb439c238a42f7a94e2f35d8cc75fdac@o4510782375395328.ingest.us.sentry.io/4510782384111616"
  SENTRY_ENVIRONMENT    = "stg"
}

# Secret Manager (create secrets manually: gcloud secrets create <secret-name> --data-file=-)
secret_environment_variables = {
  DATABASE_URL         = "shelfie-api-database-url"
  FIREBASE_PRIVATE_KEY = "shelfie-api-firebase-private-key"
}
