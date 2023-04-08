variable "gcp_region" {
  type        = string
  description = "The default region to manage resources in"
}

variable "gcp_zone" {
  type        = list(string)
  description = "The availability zone to manage resources in"
}
# define GCP project name
variable "gcp_project" {
  type        = string
  description = "GCP project name"
}

variable "gcp_creds" {
  type = string
}

variable "instance_count" {
  type        = number
  description = "Number of GCP compute instances"
  default     = 2
}

variable "name" {
  type        = string
  description = "Name of resources"
  default     = "technical-blog"
}