variable "project_name" {
  description = "Vercel project name"
  type        = string
}

variable "framework" {
  description = "Framework preset for the project"
  type        = string
  default     = "nextjs"
}

variable "github_repo" {
  description = "GitHub repository in 'owner/repo' format"
  type        = string
}

variable "production_branch" {
  description = "Git branch for production deployments"
  type        = string
  default     = "master"
}

variable "root_directory" {
  description = "Root directory of the project source code"
  type        = string
  default     = null
}

variable "domain" {
  description = "Custom domain to assign to the project (optional)"
  type        = string
  default     = null
}
