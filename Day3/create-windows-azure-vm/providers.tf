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