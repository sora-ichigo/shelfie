terraform {
  required_version = ">= 1.11.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 7.0"
    }
    vercel = {
      source  = "vercel/vercel"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project               = var.project_id
  region                = var.region
  user_project_override = true
  billing_project       = var.project_id
}

provider "vercel" {
  api_token = var.vercel_api_token
}

module "api_cloud_run" {
  source = "../../modules/api-cloud-run"

  project_id                   = var.project_id
  region                       = var.region
  environment                  = var.environment
  service_name                 = var.service_name
  image_name                   = var.image_name
  image_tag                    = var.image_tag
  cpu_limit                    = var.cpu_limit
  memory_limit                 = var.memory_limit
  min_instances                = var.min_instances
  max_instances                = var.max_instances
  request_timeout              = var.request_timeout
  service_account_id           = var.service_account_id
  allow_unauthenticated        = var.allow_unauthenticated
  ingress                      = var.ingress
  environment_variables        = var.environment_variables
  secret_environment_variables = var.secret_environment_variables
}

output "cloud_run_service_url" {
  description = "URL of the deployed Cloud Run service"
  value       = module.api_cloud_run.cloud_run_service_url
}

output "cloud_run_service_name" {
  description = "Name of the Cloud Run service"
  value       = module.api_cloud_run.cloud_run_service_name
}

output "artifact_registry_repository_url" {
  description = "URL of the Artifact Registry repository"
  value       = module.api_cloud_run.artifact_registry_repository_url
}

output "service_account_email" {
  description = "Email of the Cloud Run service account"
  value       = module.api_cloud_run.service_account_email
}

# =============================================================================
# GitHub Actions Workload Identity Federation
# =============================================================================

module "github_actions_wif" {
  source = "../../modules/github-actions-wif"

  project_id                   = var.project_id
  github_owner                 = var.github_owner
  github_repo                  = var.github_repo
  artifact_registry_location   = var.region
  artifact_registry_repository = "shelfie-api"
  cloud_run_service_name       = var.service_name
  cloud_run_location           = var.region

  depends_on = [module.api_cloud_run]
}

output "github_actions_workload_identity_provider" {
  description = "Workload Identity Provider for GitHub Actions"
  value       = module.github_actions_wif.workload_identity_provider
}

output "github_actions_service_account_email" {
  description = "Service account email for GitHub Actions"
  value       = module.github_actions_wif.service_account_email
}

# =============================================================================
# Firebase Authentication
# =============================================================================

module "firebase_auth" {
  source = "../../modules/firebase-auth"

  providers = {
    google-beta = google-beta
  }

  project_id         = var.project_id
  environment        = var.environment
  authorized_domains = ["localhost", "${var.project_id}.firebaseapp.com", "${var.project_id}.web.app"]

  android_dev_package_name = "app.shelfie.shelfie.dev"
  ios_dev_bundle_id        = "app.shelfie.shelfie.dev"
  apple_team_id            = "X9V24ZSQJQ"

  depends_on = [module.api_cloud_run]
}

output "firebase_project_id" {
  description = "Firebase Project ID"
  value       = module.firebase_auth.firebase_project_id
}

output "firebase_authorized_domains" {
  description = "Authorized domains for Firebase Authentication"
  value       = module.firebase_auth.identity_platform_authorized_domains
}

output "android_dev_app_id" {
  description = "Firebase Android Dev App ID (for App Distribution)"
  value       = module.firebase_auth.android_dev_app_id
}

output "ios_dev_app_id" {
  description = "Firebase iOS Dev App ID (for App Distribution)"
  value       = module.firebase_auth.ios_dev_app_id
}

# =============================================================================
# Google Books API
# =============================================================================

module "google_books_api" {
  source = "../../modules/google-books-api"

  providers = {
    google-beta = google-beta
  }

  project_id  = var.project_id
  environment = var.environment
}

output "google_books_api_key" {
  description = "Google Books API key"
  value       = module.google_books_api.api_key
  sensitive   = true
}

output "google_books_api_key_name" {
  description = "Google Books API key resource name"
  value       = module.google_books_api.api_key_name
}

# =============================================================================
# Vercel Web
# =============================================================================

module "vercel_web" {
  source = "../../modules/vercel-web"

  project_name      = "shelfie-web-dev"
  github_repo       = "${var.github_owner}/${var.github_repo}"
  production_branch = "master"
  root_directory    = "apps/web"
}

output "vercel_web_project_id" {
  description = "Vercel Web project ID"
  value       = module.vercel_web.project_id
}

output "vercel_web_default_domain" {
  description = "Vercel Web default domain URL"
  value       = module.vercel_web.default_domain
}

