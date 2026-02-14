terraform {
  required_providers {
    vercel = {
      source  = "vercel/vercel"
      version = "~> 4.0"
    }
  }
}

resource "vercel_project" "this" {
  name           = var.project_name
  framework      = var.framework
  root_directory = var.root_directory

  git_repository = {
    type              = "github"
    repo              = var.github_repo
    production_branch = var.production_branch
  }
}

resource "vercel_project_domain" "this" {
  count = var.domain != null ? 1 : 0

  project_id = vercel_project.this.id
  domain     = var.domain
}

resource "vercel_project_environment_variable" "this" {
  for_each = var.environment_variables

  project_id = vercel_project.this.id
  key        = each.key
  value      = each.value
  target     = ["production", "preview"]
}
