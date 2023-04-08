# resource "google_compute_instance" "benefex_technical_blog" {
#   count        = var.instance_count
#   name         = "technical-blog"
#   machine_type = "e2-small"
#   zone         = var.gcp_zone

#   tags = ["http", "techBlog"]

#   boot_disk {
#     initialize_params {
#       image = "windows-server-2019-v20220316"
#       labels = {
#         environment = "techBlog"
#       }
#     }
#   }

#   network_interface {
#     network = google_compute_network.technical_blog.name

#     access_config {}
#   }

#   metadata_startup_script = "echo 'Hello World' > /hello.txt"

#   service_account {
#     scopes = ["userinfo-email", "compute-ro", "storage-ro"]
#   }

#   scratch_disk {
#     interface = "SCSI"
#   }
# }

resource "google_compute_instance_template" "technical_blog" {
  name         = var.name
  description  = "This template is used to create app server instances."
  machine_type = "e2-micro"

  tags = ["https", "techblog"]

  scheduling {
    on_host_maintenance = "MIGRATE"
  }

  disk {
    source_image = "windows-server-2022-dc-v20230315"
    boot         = true
    labels = {
      environment = "techblog"
    }
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


resource "google_compute_region_instance_group_manager" "technical_blog" {
  name = var.name

  base_instance_name        = var.name
  region                    = var.gcp_region
  distribution_policy_zones = var.gcp_zone

  version {
    instance_template = google_compute_instance_template.technical_blog.id
  }

  # all_instances_config {
  #   metadata = {
  #     metadata_startup_script = "echo 'Hello World' > /hello.txt"
  #   }
  #   labels = {
  #     environment = "techBlog"
  #   }
  # }

  target_size = 2

  auto_healing_policies {
    health_check      = google_compute_region_health_check.technical_blog.id
    initial_delay_sec = 300
  }
}
