output "project_id" {
  description = "Vercel project ID"
  value       = vercel_project.this.id
}

output "default_domain" {
  description = "Default Vercel domain URL"
  value       = "https://${var.project_name}.vercel.app"
}
