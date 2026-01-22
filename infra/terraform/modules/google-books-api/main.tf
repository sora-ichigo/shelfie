terraform {
  required_providers {
    google-beta = {
      source = "hashicorp/google-beta"
    }
  }
}

resource "google_project_service" "books_api" {
  provider = google-beta
  project  = var.project_id
  service  = "books.googleapis.com"

  disable_dependent_services = false
  disable_on_destroy         = false
}

resource "google_project_service" "apikeys_api" {
  provider = google-beta
  project  = var.project_id
  service  = "apikeys.googleapis.com"

  disable_dependent_services = false
  disable_on_destroy         = false
}

resource "google_apikeys_key" "books_api_key" {
  provider     = google-beta
  name         = "books-api-server-key-${var.environment}"
  display_name = "Books API Server Key (${var.environment})"
  project      = var.project_id

  restrictions {
    api_targets {
      service = "books.googleapis.com"
    }
  }

  depends_on = [
    google_project_service.books_api,
    google_project_service.apikeys_api,
  ]
}
