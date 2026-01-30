output "firebase_project_id" {
  description = "Firebase Project ID"
  value       = google_firebase_project.default.project
}

output "identity_platform_authorized_domains" {
  description = "Configured authorized domains for Identity Platform"
  value       = google_identity_platform_config.default.authorized_domains
}

# =============================================================================
# Firebase App IDs
# =============================================================================

output "android_app_id" {
  description = "Firebase Android App ID"
  value       = var.android_package_name != null ? google_firebase_android_app.default[0].app_id : null
}

output "ios_app_id" {
  description = "Firebase iOS App ID"
  value       = var.ios_bundle_id != null ? google_firebase_apple_app.default[0].app_id : null
}

output "ios_dev_app_id" {
  description = "Firebase iOS Dev App ID (for App Distribution)"
  value       = var.ios_dev_bundle_id != null ? google_firebase_apple_app.dev[0].app_id : null
}

output "web_app_id" {
  description = "Firebase Web App ID"
  value       = var.enable_web_app ? google_firebase_web_app.default[0].app_id : null
}

# =============================================================================
# Firebase App Configurations
# =============================================================================

output "android_config_json" {
  description = "google-services.json content for Android"
  value       = var.android_package_name != null ? data.google_firebase_android_app_config.default[0].config_file_contents : null
  sensitive   = true
}

output "ios_config_plist" {
  description = "GoogleService-Info.plist content for iOS"
  value       = var.ios_bundle_id != null ? data.google_firebase_apple_app_config.default[0].config_file_contents : null
  sensitive   = true
}

output "web_config" {
  description = "Firebase Web App configuration"
  value = var.enable_web_app ? {
    api_key             = data.google_firebase_web_app_config.default[0].api_key
    auth_domain         = data.google_firebase_web_app_config.default[0].auth_domain
    storage_bucket      = data.google_firebase_web_app_config.default[0].storage_bucket
    messaging_sender_id = data.google_firebase_web_app_config.default[0].messaging_sender_id
  } : null
  sensitive = true
}
