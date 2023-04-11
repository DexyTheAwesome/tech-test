resource "google_compute_instance_template" "technical_blog" {
  name         = var.name
  description  = "This template is used to create app server instances."
  machine_type = "e2-micro"

  tags = ["https", "techblog"]

  scheduling {
    on_host_maintenance = "MIGRATE"
  }

  // Create a new boot disk from an image
  disk {
    source_image = var.image
    boot         = true
    labels = {
      environment = "techblog"
    }
  }

  # Additional drive
  disk {
    // Instance Templates reference disks by name, not self link
    source      = google_compute_disk.additional_disk.name
    auto_delete = false
    boot        = false
  }

  network_interface {
    network = google_compute_network.technical_blog.name

    access_config {}
  }

  metadata_startup_script = "echo 'Hello World' > /hello.txt"
  labels = {
    environment = "techblog"
  }
}

resource "google_compute_disk" "additional_disk" {
  name  = var.name
  image = var.image
  size  = 10
  type  = "pd-ssd"
}

resource "google_compute_region_instance_group_manager" "technical_blog" {
  name = var.name

  base_instance_name        = var.name
  region                    = var.gcp_region
  distribution_policy_zones = var.gcp_zone

  version {
    instance_template = google_compute_instance_template.technical_blog.id
  }

  target_size = 2

  auto_healing_policies {
    health_check      = google_compute_region_health_check.technical_blog.id
    initial_delay_sec = 300
  }
}
