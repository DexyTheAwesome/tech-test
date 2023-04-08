resource "google_compute_network" "technical_blog" {
  name                    = var.name
  auto_create_subnetworks = true

}

# # backend subnet
# resource "google_compute_subnetwork" "technical_blog" {
#   provider      = google-beta
#   name          = var.name
#   ip_cidr_range = "10.1.2.0/24"
#   region        = var.gcp_region
#   network       = google_compute_network.technical_blog.id
# }

# proxy-only subnet
resource "google_compute_subnetwork" "proxy_subnet" {
  name          = "${var.name}-proxy"
  provider      = google-beta
  ip_cidr_range = "10.0.0.0/24"
  region        = var.gcp_region
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
  network       = google_compute_network.technical_blog.id
}

# health check
resource "google_compute_region_health_check" "technical_blog" {
  name                = var.name
  provider            = google-beta
  region              = var.gcp_region
  timeout_sec         = 5
  check_interval_sec  = 5
  healthy_threshold   = 3
  unhealthy_threshold = 3
  https_health_check {
    port_specification = "USE_SERVING_PORT"
  }
}

# backend service
resource "google_compute_region_backend_service" "technical_blog" {

  name                  = var.name
  provider              = google-beta
  region                = var.gcp_region
  protocol              = "HTTPS"
  load_balancing_scheme = "INTERNAL_MANAGED"
  timeout_sec           = 10
  health_checks         = [google_compute_region_health_check.technical_blog.id]
  backend {
    group = google_compute_region_instance_group_manager.technical_blog.instance_group
    balancing_mode = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

# URL map
resource "google_compute_region_url_map" "technical_blog" {
  name            = var.name
  provider        = google-beta
  region          = var.gcp_region
  default_service = google_compute_region_backend_service.technical_blog.id
}

resource "google_compute_region_ssl_certificate" "technical_blog" {
  region      = var.gcp_region
  name_prefix = "my-certificate-"
  private_key = file("${path.module}/example.key")
  certificate = file("${path.module}/example.crt")

  lifecycle {
    create_before_destroy = true
  }
}

# HTTP target proxy
resource "google_compute_region_target_https_proxy" "technical_blog" {
  name             = var.name
  provider         = google-beta
  region           = var.gcp_region
  url_map          = google_compute_region_url_map.technical_blog.id
  ssl_certificates = [google_compute_region_ssl_certificate.technical_blog.id]
}

# forwarding rule
resource "google_compute_forwarding_rule" "google_compute_forwarding_rule" {
  name                  = var.name
  provider              = google-beta
  region                = var.gcp_region
  depends_on            = [google_compute_subnetwork.proxy_subnet]
  ip_protocol           = "TCP"
  load_balancing_scheme = "INTERNAL_MANAGED"
  port_range            = "443"
  target                = google_compute_region_target_https_proxy.technical_blog.id
  network               = google_compute_network.technical_blog.id
}

# Resource configuration for the firewall rule
resource "google_compute_firewall" "allow_rdp" {
  name    = "allow-rdp"
  network = google_compute_network.technical_blog.name

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
  source_ranges = ["80.193.23.74/32"]
}

resource "google_compute_firewall" "allow_https" {
  name    = "allow-https"
  network = google_compute_network.technical_blog.name
  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
  source_ranges = ["0.0.0.0/0"]
}