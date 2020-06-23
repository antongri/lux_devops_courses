variable "project_name" {
  default = "training"
}

variable "region" {
  default = "europe-west3"
}

variable "k8s_name" {
  default = "demo"
}

variable "zones" {
  type    = list(string)
  default = ["europe-west3-c"]
}

variable "zone" {
  type    = string
  default = "europe-west3-c"
}

variable "project_id" {
  description = "The project ID to host the cluster in"
  default     = "training-276723"
}

variable "cluster_name_suffix" {
  description = "A suffix to append to the default cluster name"
  default     = ""
}

variable "network" {
  description = "The VPC network to host the cluster in"
  default     = "default"
}

variable "subnetwork" {
  description = "The subnetwork to host the cluster in"
  default     = "default"
}

variable "ip_range_pods" {
  description = "The secondary ip range to use for pods"
  default     = ""
}

variable "ip_range_services" {
  description = "The secondary ip range to use for pods"
  default     = ""
}

variable "compute_engine_service_account" {
  description = "Service account to associate to the nodes in the cluster"
  default     = ""
}

variable "skip_provisioners" {
  type        = bool
  description = "Flag to skip local-exec provisioners"
  default     = false
}