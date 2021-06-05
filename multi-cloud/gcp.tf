resource "google_compute_instance" "mc1" {
  name         = "multi-strategy"
  machine_type =  var.mtype
  zone         = "us-central1-a"
  count = var.istest ? 0 : 1

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"
}
}