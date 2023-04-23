variable "cluster_name" {
  type = string
  default = "sandbox01-k8s"
}

variable "rg_name" {
  type = string
  default = "devops"
}

variable "chart_path" {
  type = string
  default = "/home/shrtya/mediawiki/helm-chart"
}

variable "namespace" {
  type = string
  default = "devops-demo"
}
