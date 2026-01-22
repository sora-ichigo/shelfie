output "api_key" {
  description = "Google Books API key"
  value       = google_apikeys_key.books_api_key.key_string
  sensitive   = true
}

output "api_key_name" {
  description = "Google Books API key resource name"
  value       = google_apikeys_key.books_api_key.name
}
