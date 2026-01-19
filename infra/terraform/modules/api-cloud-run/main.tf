# =============================================================================
# Artifact Registry Repository
# =============================================================================

resource "google_artifact_registry_repository" "api" {
  location      = var.region
  repository_id = "shelfie-api"
  description   = "Shelfie API Docker repository"
  format        = "DOCKER"

  docker_config {
    immutable_tags = var.environment == "prod" ? true : false
  }
}

# =============================================================================
# Service Account
# =============================================================================

resource "google_service_account" "api_runner" {
  account_id   = var.service_account_id
  display_name = "Shelfie API Cloud Run Service Account"
  description  = "Service account for running Shelfie API on Cloud Run"
}

# =============================================================================
# IAM Bindings
# =============================================================================

resource "google_artifact_registry_repository_iam_member" "api_reader" {
  location   = google_artifact_registry_repository.api.location
  repository = google_artifact_registry_repository.api.name
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${google_service_account.api_runner.email}"
}

resource "google_cloud_run_v2_service_iam_member" "invoker" {
  count    = var.allow_unauthenticated ? 1 : 0
  location = google_cloud_run_v2_service.api.location
  name     = google_cloud_run_v2_service.api.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# =============================================================================
# Cloud Run Service
# =============================================================================

resource "google_cloud_run_v2_service" "api" {
  name     = var.service_name
  location = var.region
  ingress  = var.ingress

  template {
    service_account = google_service_account.api_runner.email
    timeout         = "${var.request_timeout}s"

    scaling {
      min_instance_count = var.min_instances
      max_instance_count = var.max_instances
    }

    containers {
      name  = "api"
      image = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.api.repository_id}/${var.image_name}:${var.image_tag}"

      ports {
        container_port = 4000
      }

      resources {
        limits = {
          cpu    = var.cpu_limit
          memory = var.memory_limit
        }
      }

      dynamic "env" {
        for_each = var.environment_variables
        content {
          name  = env.key
          value = env.value
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      template[0].containers[0].image,
    ]
  }
}
