terraform {
  backend "gcs" {}
}

provider "google" {
  project = var.project_id
}

# -----------------------------------------------------------------------------
# LOCALS
# -----------------------------------------------------------------------------
locals {
  project_id   = var.project_id[terraform.workspace]
  project_name = "anbu"

  network = default
}

# -----------------------------------------------------------------------------
# PROVISION FIREWALL ALLOW SSH
# -----------------------------------------------------------------------------
resource "google_compute_firewall" "allow_ssh_iap" {
  name    = "allow-ingress-ssh-from-iap-${local.network}"
  network = local.network

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  # private tags are gke nodes
  target_tags = ["private"]

  # IAP public range provided by GCP https://cloud.google.com/iap/docs/using-tcp-forwarding#create-firewall-rule
  source_ranges = ["35.235.240.0/20"]
}

resource "google_compute_firewall" "vpn_firewall" {
  name    = "allow-ingress-vpn-pritunl-${local.network}"
  network = local.network

  allow {
    protocol = "udp"
    ports    = var.vpn_port[terraform.workspace]
  }

  source_ranges = ["0.0.0.0/0"]
}
