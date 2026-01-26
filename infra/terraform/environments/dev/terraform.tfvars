environment           = "dev"
project_id            = "shelfie-development-484809"
region                = "asia-northeast1"
min_instances         = 0
max_instances         = 2
cpu_limit             = "1"
memory_limit          = "512Mi"
allow_unauthenticated = true

# GitHub Actions CD
github_owner = "sora-ichigo"
github_repo  = "shelfie"

# Environment Variables
environment_variables = {
  NODE_ENV              = "production"
  FIREBASE_PROJECT_ID   = "shelfie-development-484809"
  FIREBASE_CLIENT_EMAIL = "firebase-adminsdk-fbsvc@shelfie-development-484809.iam.gserviceaccount.com"
  FIREBASE_WEB_API_KEY  = "AIzaSyArNAv_mVB9Q9PeGBqSslhuJn04FcF_BZo"
}

# Secret Manager (create secrets manually: gcloud secrets create <secret-name> --data-file=-)
secret_environment_variables = {
  DATABASE_URL             = "shelfie-api-database-url"
  FIREBASE_PRIVATE_KEY     = "shelfie-api-firebase-private-key"
  RAKUTEN_APPLICATION_ID   = "shelfie-api-rakuten-application-id"
  GOOGLE_BOOKS_API_KEY     = "shelfie-api-google-books-api-key"
}
