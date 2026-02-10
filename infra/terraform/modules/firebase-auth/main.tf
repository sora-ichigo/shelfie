terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    google-beta = {
      source = "hashicorp/google-beta"
    }
  }
}

# =============================================================================
# Required APIs
# =============================================================================

resource "google_project_service" "firebase_apis" {
  for_each = toset([
    "firebase.googleapis.com",
    "identitytoolkit.googleapis.com",
    "firebaseappdistribution.googleapis.com",
  ])
  project            = var.project_id
  service            = each.key
  disable_on_destroy = false
}

# =============================================================================
# Firebase Project
# =============================================================================

resource "google_firebase_project" "default" {
  provider = google-beta
  project  = var.project_id

  depends_on = [google_project_service.firebase_apis]
}

# =============================================================================
# Identity Platform Configuration
# =============================================================================

resource "google_identity_platform_config" "default" {
  provider = google-beta
  project  = var.project_id

  autodelete_anonymous_users = var.autodelete_anonymous_users

  sign_in {
    allow_duplicate_emails = var.allow_duplicate_emails

    email {
      enabled           = true
      password_required = true
    }

    anonymous {
      enabled = var.enable_anonymous_auth
    }
  }

  authorized_domains = var.authorized_domains

  depends_on = [google_firebase_project.default]
}

# =============================================================================
# Firebase Apps
# =============================================================================

resource "google_firebase_android_app" "default" {
  count = var.android_package_name != null ? 1 : 0

  provider     = google-beta
  project      = var.project_id
  display_name = "shelfie-${var.environment}-android"
  package_name = var.android_package_name

  depends_on = [google_firebase_project.default]
}

resource "google_firebase_android_app" "dev" {
  count = var.android_dev_package_name != null ? 1 : 0

  provider     = google-beta
  project      = var.project_id
  display_name = "shelfie-${var.environment}-android-dev"
  package_name = var.android_dev_package_name

  depends_on = [google_firebase_project.default]
}

resource "google_firebase_apple_app" "default" {
  count = var.ios_bundle_id != null ? 1 : 0

  provider     = google-beta
  project      = var.project_id
  display_name = "shelfie-${var.environment}-ios"
  bundle_id    = var.ios_bundle_id
  team_id      = var.apple_team_id

  depends_on = [google_firebase_project.default]
}

resource "google_firebase_apple_app" "dev" {
  count = var.ios_dev_bundle_id != null ? 1 : 0

  provider     = google-beta
  project      = var.project_id
  display_name = "shelfie-${var.environment}-ios-dev"
  bundle_id    = var.ios_dev_bundle_id
  team_id      = var.apple_team_id

  depends_on = [google_firebase_project.default]
}

resource "google_firebase_web_app" "default" {
  count = var.enable_web_app ? 1 : 0

  provider     = google-beta
  project      = var.project_id
  display_name = "shelfie-${var.environment}-web"

  depends_on = [google_firebase_project.default]
}

# =============================================================================
# Firebase App Configurations (for config file generation)
# =============================================================================

data "google_firebase_android_app_config" "default" {
  count = var.android_package_name != null ? 1 : 0

  provider = google-beta
  project  = var.project_id
  app_id   = google_firebase_android_app.default[0].app_id
}

data "google_firebase_android_app_config" "dev" {
  count = var.android_dev_package_name != null ? 1 : 0

  provider = google-beta
  project  = var.project_id
  app_id   = google_firebase_android_app.dev[0].app_id
}

data "google_firebase_apple_app_config" "default" {
  count = var.ios_bundle_id != null ? 1 : 0

  provider = google-beta
  project  = var.project_id
  app_id   = google_firebase_apple_app.default[0].app_id
}

data "google_firebase_apple_app_config" "dev" {
  count = var.ios_dev_bundle_id != null ? 1 : 0

  provider = google-beta
  project  = var.project_id
  app_id   = google_firebase_apple_app.dev[0].app_id
}

data "google_firebase_web_app_config" "default" {
  count = var.enable_web_app ? 1 : 0

  provider   = google-beta
  project    = var.project_id
  web_app_id = google_firebase_web_app.default[0].app_id
}
