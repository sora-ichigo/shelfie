# =============================================================================
# Project Configuration
# =============================================================================

variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region for resource deployment"
  type        = string
  default     = "asia-northeast1"
}

# =============================================================================
# Environment Configuration
# =============================================================================

variable "environment" {
  description = "Environment name (dev, stg, prod)"
  type        = string
  default     = "dev"
}

# =============================================================================
# Cloud Run Service Configuration
# =============================================================================

variable "service_name" {
  description = "Name of the Cloud Run service"
  type        = string
  default     = "shelfie-api"
}

variable "image_name" {
  description = "Name of the container image"
  type        = string
  default     = "api"
}

variable "image_tag" {
  description = "Tag of the container image"
  type        = string
  default     = "latest"
}

# =============================================================================
# Resource Limits and Scaling
# =============================================================================

variable "cpu_limit" {
  description = "CPU limit for the container"
  type        = string
  default     = "1"
}

variable "memory_limit" {
  description = "Memory limit for the container"
  type        = string
  default     = "512Mi"
}

variable "min_instances" {
  description = "Minimum number of instances"
  type        = number
  default     = 0
}

variable "max_instances" {
  description = "Maximum number of instances"
  type        = number
  default     = 2
}

variable "request_timeout" {
  description = "Request timeout in seconds"
  type        = number
  default     = 300
}

# =============================================================================
# IAM and Service Account
# =============================================================================

variable "service_account_id" {
  description = "ID for the Cloud Run service account"
  type        = string
  default     = "shelfie-api-runner"
}

variable "allow_unauthenticated" {
  description = "Allow unauthenticated access to the Cloud Run service"
  type        = bool
  default     = true
}

# =============================================================================
# Network and Access
# =============================================================================

variable "ingress" {
  description = "Ingress setting"
  type        = string
  default     = "INGRESS_TRAFFIC_ALL"
}

# =============================================================================
# Environment Variables
# =============================================================================

variable "environment_variables" {
  description = "Additional environment variables for the container"
  type        = map(string)
  default = {
    SENTRY_DSN = "https://fb439c238a42f7a94e2f35d8cc75fdac@o4510782375395328.ingest.us.sentry.io/4510782384111616"
  }
}

variable "secret_environment_variables" {
  description = "Environment variables sourced from Secret Manager. Map of env var name to secret name."
  type        = map(string)
  default     = {}
}

# =============================================================================
# GitHub Actions Configuration
# =============================================================================

variable "github_owner" {
  description = "GitHub repository owner (organization or user)"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}
