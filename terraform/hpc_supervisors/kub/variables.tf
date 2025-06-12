variable "public_cloud_project_id" {
  type = string
}

variable "cluster_name" {
  type    = string
  default = "nextflow-k8s"
}

variable "region" {
  type    = string
  default = "GRA"
}

variable "version" {
  type    = string
  default = "1.27"
}

variable "flavor_name" {
  type    = string
  default = "b2-7"
}

variable "worker_nodes_count" {
  type    = number
  default = 3
}