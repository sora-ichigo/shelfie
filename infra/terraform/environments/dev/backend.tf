terraform {
  backend "gcs" {
    bucket = "shelfie-dev-terraform-state"
    prefix = "api-cloud-run"
  }
}
