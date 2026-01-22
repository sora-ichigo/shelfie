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

module "api_cloud_run" {
  source = "../../modules/api-cloud-run"

  project_id            = var.project_id
  region                = var.region
  environment           = var.environment
  service_name          = var.service_name
  image_name            = var.image_name
  image_tag             = var.image_tag
  cpu_limit             = var.cpu_limit
  memory_limit          = var.memory_limit
  min_instances         = var.min_instances
  max_instances         = var.max_instances
  request_timeout       = var.request_timeout
  service_account_id    = var.service_account_id
  allow_unauthenticated = var.allow_unauthenticated
  ingress               = var.ingress
  environment_variables = var.environment_variables
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
  description = "Google Books API key for server-side use"
  value       = module.google_books_api.api_key
  sensitive   = true
}
