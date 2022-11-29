terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.33.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "jegan" {
  name     = "jegan-resource-group"
  location = "eastus"
}
