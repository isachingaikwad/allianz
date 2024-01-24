# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

##############
# Check if the resource group already exists
data "azurerm_resource_group" "existing_rg" {
  name = var.resource_group_name
}
##############
# Conditionally create the resource group if it doesn't exist
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "South India"
  count    = data.azurerm_resource_group.existing_rg.id == null ? 1 : 0
}
###############

resource "azurerm_kubernetes_cluster" "aks" {
  # count    = data.azurerm_kubernetes_cluster.existing_aks.id == null ? 1 : 0
  name                = "allianz-aks"
  location            = data.azurerm_resource_group.existing_rg.id == null ? azurerm_resource_group.rg[0].location : data.azurerm_resource_group.existing_rg.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "allianz-k8s"
  kubernetes_version  = "1.28.0"

  default_node_pool {
    name            = "default"
    node_count      = 1
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control_enabled = true

  tags = {
    environment = "allianz"
  }
}

# data "azurerm_kubernetes_cluster" "existing_aks"{
#   name = "allianz-aks"
#   resource_group_name = var.resource_group_name
# }
