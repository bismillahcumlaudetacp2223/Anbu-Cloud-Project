terraform {
  backend "gcs" {}
}

provider "google" {}

resource "google_project" "project" {
  name            = "anbu-project"
  project_id      = "anbu-project"
  org_id          = "590751730427"
  billing_account = "01EC24-D036A3-421392"
}

module "project_services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "10.2.0"

  project_id = google_project.project.project_id

  activate_apis = [
    "serviceusage.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "iam.googleapis.com",
    "cloudkms.googleapis.com",
    "artifactregistry.googleapis.com",
    "secretmanager.googleapis.com",
    "admin.googleapis.com",
    "redis.googleapis.com",
    "publicca.googleapis.com",
    "dns.googleapis.com",
    "sql-component.googleapis.com",
    "sqladmin.googleapis.com",
    "servicenetworking.googleapis.com",
  ]
}

