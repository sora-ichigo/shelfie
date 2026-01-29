terraform {
  backend "gcs" {
    bucket = "shelfie-prod-terraform-state"
    prefix = "api-cloud-run"
  }
}
