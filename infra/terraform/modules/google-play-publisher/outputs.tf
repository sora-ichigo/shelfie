output "service_account_email" {
  description = "Google Play publisher service account email"
  value       = google_service_account.play_publisher.email
}

output "service_account_key_json" {
  description = "Google Play publisher service account key (base64-encoded JSON)"
  value       = google_service_account_key.play_publisher.private_key
  sensitive   = true
}
