provider "google" {
  project = "your-gcp-project-id" # Ganti dengan Project ID Anda
  region  = "asia-southeast1"      # Ganti dengan region yang Anda inginkan
}


resource "google_compute_firewall" "db-firewall" {
  name    = "mariadb-firewall"
  network = "default"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "3306", "4444", "4567-4568", "9100"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "mariadb_cluster" {
  count        = 3
  name         = "mariadb-node-${count.index}"
  machine_type = "e2-medium"
  zone         = "asia-southeast1-a" 

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11" 
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  metadata = {
    ssh-keys = "your-ssh-username:${file("~/.ssh/id_rsa.pub")}" 
  }

  tags = ["mariadb"]
}

resource "google_compute_instance" "monitoring" {
  name         = "monitoring-server"
  machine_type = "e2-medium"
  zone         = "asia-southeast1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  metadata = {
    ssh-keys = "your-ssh-username:${file("~/.ssh/id_rsa.pub")}"
  }

  tags = ["monitoring"]
}

output "mariadb_ips" {
  value = google_compute_instance.mariadb_cluster.*.network_interface.0.access_config.0.nat_ip
}

output "monitoring_ip" {
  value = google_compute_instance.monitoring.network_interface.0.access_config.0.nat_ip
}