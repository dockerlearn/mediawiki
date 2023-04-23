
data "azurerm_kubernetes_cluster" "credentials" {
  name                = var.cluster_name
  resource_group_name = var.rg_name
}

provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.credentials.kube_admin_config.0.host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_admin_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_admin_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_admin_config.0.cluster_ca_certificate)

  }
}

resource "helm_release" "mediawiki" {
  name = "mediawiki"
  namespace = var.namespace
  chart      = var.chart_path
  values = [
    "${file("values.yaml")}"
  ]
}
