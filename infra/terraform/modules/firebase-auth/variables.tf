# =============================================================================
# Project Configuration
# =============================================================================

variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

# =============================================================================
# Environment Configuration
# =============================================================================

variable "environment" {
  description = "Environment name (dev, stg, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "stg", "prod"], var.environment)
    error_message = "Environment must be one of: dev, stg, prod"
  }
}

# =============================================================================
# Firebase Authentication Configuration
# =============================================================================

variable "authorized_domains" {
  description = "List of authorized domains for authentication"
  type        = list(string)
  default     = ["localhost"]
}

variable "allow_duplicate_emails" {
  description = "Allow duplicate email addresses across identity providers"
  type        = bool
  default     = false
}

variable "enable_anonymous_auth" {
  description = "Enable anonymous authentication"
  type        = bool
  default     = false
}

variable "autodelete_anonymous_users" {
  description = "Auto-delete anonymous users after 30 days"
  type        = bool
  default     = true
}

# =============================================================================
# Firebase Apps Configuration
# =============================================================================

variable "android_package_name" {
  description = "Android app package name (e.g., com.example.app)"
  type        = string
  default     = null
}

variable "ios_bundle_id" {
  description = "iOS app bundle ID (e.g., com.example.app)"
  type        = string
  default     = null
}

variable "android_dev_package_name" {
  description = "Android dev app package name for Firebase App Distribution (e.g., com.example.app.dev)"
  type        = string
  default     = null
}

variable "ios_dev_bundle_id" {
  description = "iOS dev app bundle ID for Firebase App Distribution (e.g., com.example.app.dev)"
  type        = string
  default     = null
}

variable "enable_web_app" {
  description = "Enable Firebase Web App"
  type        = bool
  default     = false
}
