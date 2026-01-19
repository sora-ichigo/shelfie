terraform {
  required_version = ">= 1.11.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
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
