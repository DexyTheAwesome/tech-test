# tech-test
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.51.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.51.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | 4.60.2 |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_forwarding_rule.google_compute_forwarding_rule](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_forwarding_rule) | resource |
| [google-beta_google_compute_region_backend_service.technical_blog](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_region_backend_service) | resource |
| [google-beta_google_compute_region_health_check.technical_blog](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_region_health_check) | resource |
| [google-beta_google_compute_region_target_https_proxy.technical_blog](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_region_target_https_proxy) | resource |
| [google-beta_google_compute_region_url_map.technical_blog](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_region_url_map) | resource |
| [google-beta_google_compute_subnetwork.proxy_subnet](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_subnetwork) | resource |
| [google-beta_google_compute_subnetwork.technical_blog](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_subnetwork) | resource |
| [google_compute_disk.additional_disk](https://registry.terraform.io/providers/hashicorp/google/4.51.0/docs/resources/compute_disk) | resource |
| [google_compute_firewall.allow_https](https://registry.terraform.io/providers/hashicorp/google/4.51.0/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.allow_rdp](https://registry.terraform.io/providers/hashicorp/google/4.51.0/docs/resources/compute_firewall) | resource |
| [google_compute_instance_template.technical_blog](https://registry.terraform.io/providers/hashicorp/google/4.51.0/docs/resources/compute_instance_template) | resource |
| [google_compute_network.technical_blog](https://registry.terraform.io/providers/hashicorp/google/4.51.0/docs/resources/compute_network) | resource |
| [google_compute_region_instance_group_manager.technical_blog](https://registry.terraform.io/providers/hashicorp/google/4.51.0/docs/resources/compute_region_instance_group_manager) | resource |
| [google_compute_region_ssl_certificate.technical_blog](https://registry.terraform.io/providers/hashicorp/google/4.51.0/docs/resources/compute_region_ssl_certificate) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gcp_creds"></a> [gcp\_creds](#input\_gcp\_creds) | n/a | `string` | n/a | yes |
| <a name="input_gcp_project"></a> [gcp\_project](#input\_gcp\_project) | GCP project name | `string` | n/a | yes |
| <a name="input_gcp_region"></a> [gcp\_region](#input\_gcp\_region) | The default region to manage resources in | `string` | n/a | yes |
| <a name="input_gcp_zone"></a> [gcp\_zone](#input\_gcp\_zone) | The availability zone to manage resources in | `list(string)` | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | Google Cloud Provider image to be used | `string` | n/a | yes |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of GCP compute instances | `number` | `2` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of resources | `string` | `"technical-blog"` | no |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
