resource "google_project_service" "androidpublisher_api" {
  project = var.project_id
  service = "androidpublisher.googleapis.com"

  disable_dependent_services = false
  disable_on_destroy         = false
}

resource "google_service_account" "play_publisher" {
  project      = var.project_id
  account_id   = "google-play-publisher"
  display_name = "Google Play Publisher"
  description  = "Service account for uploading AABs to Google Play Store"
}

resource "google_service_account_key" "play_publisher" {
  service_account_id = google_service_account.play_publisher.name
}
