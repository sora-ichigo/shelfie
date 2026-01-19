variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "github_owner" {
  description = "GitHub repository owner (organization or user)"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}

variable "pool_id" {
  description = "Workload Identity Pool ID"
  type        = string
  default     = "github-actions-pool"
}

variable "provider_id" {
  description = "Workload Identity Provider ID"
  type        = string
  default     = "github-actions-provider"
}

variable "service_account_id" {
  description = "Service account ID for GitHub Actions"
  type        = string
  default     = "github-actions-deployer"
}

variable "artifact_registry_location" {
  description = "Location of the Artifact Registry repository"
  type        = string
}

variable "artifact_registry_repository" {
  description = "Name of the Artifact Registry repository"
  type        = string
}

variable "cloud_run_service_name" {
  description = "Name of the Cloud Run service to deploy"
  type        = string
}

variable "cloud_run_location" {
  description = "Location of the Cloud Run service"
  type        = string
}
