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
  description = "Environment name (dev, stg, prod) - used for environment-specific settings like immutable_tags"
  type        = string

  validation {
    condition     = contains(["dev", "stg", "prod"], var.environment)
    error_message = "Environment must be one of: dev, stg, prod"
  }
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
  description = "CPU limit for the container (e.g., '1', '2', '1000m')"
  type        = string
  default     = "1"
}

variable "memory_limit" {
  description = "Memory limit for the container (e.g., '512Mi', '1Gi')"
  type        = string
  default     = "512Mi"
}

variable "min_instances" {
  description = "Minimum number of instances (0 for scale-to-zero)"
  type        = number
  default     = 0
}

variable "max_instances" {
  description = "Maximum number of instances"
  type        = number
  default     = 10
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
  description = "Ingress setting: INGRESS_TRAFFIC_ALL, INGRESS_TRAFFIC_INTERNAL_ONLY, INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER"
  type        = string
  default     = "INGRESS_TRAFFIC_ALL"

  validation {
    condition = contains([
      "INGRESS_TRAFFIC_ALL",
      "INGRESS_TRAFFIC_INTERNAL_ONLY",
      "INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER"
    ], var.ingress)
    error_message = "Ingress must be one of: INGRESS_TRAFFIC_ALL, INGRESS_TRAFFIC_INTERNAL_ONLY, INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER"
  }
}

# =============================================================================
# Environment Variables
# =============================================================================

variable "environment_variables" {
  description = "Additional environment variables for the container"
  type        = map(string)
  default     = {}
}
