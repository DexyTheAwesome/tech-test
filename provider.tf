terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file(var.gcp_creds)

  project = var.gcp_project
  region  = var.gcp_region
}

provider "google-beta" {
  credentials = file(var.gcp_creds)

  project = var.gcp_project
  region  = var.gcp_region
}