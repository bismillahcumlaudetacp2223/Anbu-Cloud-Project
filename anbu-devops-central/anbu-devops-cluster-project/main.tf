terraform {
  backend "gcs" {}
}

provider "google" {}

variable project_id {
  type = string
  default = "capstone-anbu"
}

locals {
  project_id      = "capstone-anbu"
  org_id          = "569819205777"
  billing_account = "01FF12-9530EA-5A516B"
}

resource "google_project" "project" {
  name            = local.project_id
  project_id      = local.project_id
  org_id          = local.org_id
  billing_account = local.billing_account
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
    "servicenetworking.googleapis.com",
  ]
}

resource "google_compute_project_metadata_item" "enable_os_login" {
  depends_on = [module.project_services]
  project    = local.project_id
  key        = "enable-oslogin"
  value      = "TRUE"
}