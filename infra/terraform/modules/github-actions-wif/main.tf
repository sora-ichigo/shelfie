# =============================================================================
# Workload Identity Pool
# =============================================================================

resource "google_iam_workload_identity_pool" "github" {
  workload_identity_pool_id = var.pool_id
  display_name              = "GitHub Actions Pool"
  description               = "Workload Identity Pool for GitHub Actions"
}

# =============================================================================
# Workload Identity Provider
# =============================================================================

resource "google_iam_workload_identity_pool_provider" "github" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.github.workload_identity_pool_id
  workload_identity_pool_provider_id = var.provider_id
  display_name                       = "GitHub Actions Provider"
  description                        = "OIDC identity provider for GitHub Actions"

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
    "attribute.ref"        = "assertion.ref"
  }

  attribute_condition = "assertion.repository == '${var.github_owner}/${var.github_repo}'"

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

# =============================================================================
# Service Account for GitHub Actions
# =============================================================================

resource "google_service_account" "github_actions" {
  account_id   = var.service_account_id
  display_name = "GitHub Actions Deployer"
  description  = "Service account for GitHub Actions to deploy to Cloud Run"
}

# =============================================================================
# Workload Identity Federation binding
# =============================================================================

resource "google_service_account_iam_member" "workload_identity_user" {
  service_account_id = google_service_account.github_actions.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github.name}/attribute.repository/${var.github_owner}/${var.github_repo}"
}

# =============================================================================
# IAM Permissions for GitHub Actions Service Account
# =============================================================================

resource "google_artifact_registry_repository_iam_member" "github_actions_writer" {
  location   = var.artifact_registry_location
  repository = var.artifact_registry_repository
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${google_service_account.github_actions.email}"
}

resource "google_cloud_run_v2_service_iam_member" "github_actions_developer" {
  location = var.cloud_run_location
  name     = var.cloud_run_service_name
  role     = "roles/run.developer"
  member   = "serviceAccount:${google_service_account.github_actions.email}"
}

resource "google_project_iam_member" "github_actions_sa_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.github_actions.email}"
}

resource "google_project_iam_member" "github_actions_appdistro_admin" {
  project = var.project_id
  role    = "roles/firebaseappdistro.admin"
  member  = "serviceAccount:${google_service_account.github_actions.email}"
}
