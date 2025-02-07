provider "google" {
  project     = "goldengate-1"
  region      = "us-central1"
  credentials = file("/home/mnagaraju/gcp-service-account.json")
}
 
resource "google_compute_network" "custom_network" {
  name                    = "test-network"
  auto_create_subnetworks = false
}
 
resource "google_compute_subnetwork" "custom_subnet" {
  name          = "test-subnet"
  network       = google_compute_network.custom_network.id
  ip_cidr_range = "10.0.0.0/16"
  region        = "us-central1"
}
 
resource "google_compute_instance" "vm_instance" {
  name         = "vm-terraform-testing"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
 
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }
 
  network_interface {
    network    = google_compute_network.custom_network.id
    subnetwork = google_compute_subnetwork.custom_subnet.id
    access_config {
      # Assigns an ephemeral external IP
    }
  }
}
