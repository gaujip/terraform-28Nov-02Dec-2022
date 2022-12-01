terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "3.33.0"
    }

    tls = {
        source = "hashicorp/tls"
        version = "4.0.4"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
    location = "eastus"
    name = "tektutor-resource-group-latest"
}

resource "azurerm_kubernetes_cluster" "my-aks" {
    name = "tektutor-aks"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    dns_prefix = "tektutor"

    default_node_pool {
        name = "default"
        node_count = 3
        vm_size = "Standard_D2_v2" 
    }

    identity {
        type = "SystemAssigned"
    }

    tags = {
        Environment = "Production"
    }
}
    
output "client_certificate" {
    value = azurerm_kubernetes_cluster.my-aks.kube_config.0.client_certificate
    sensitive = true
}

output "kube_config" {
    value = azurerm_kubernetes_cluster.my-aks.kube_config_raw
    sensitive = true
}
