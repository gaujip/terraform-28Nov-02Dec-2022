
terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "=3.32.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource_group2" {
  name     = "resource-group2"
  location = "West Europe"
}

resource "azurerm_service_plan" "service_plan" {
  name                = "service-plan"
  resource_group_name = azurerm_resource_group.resource_group2.name
  location            = azurerm_resource_group.resource_group2.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "python_linux_app" {
  name                = "python-linux-app"
  resource_group_name = azurerm_resource_group.resource_group2.name
  location            = azurerm_resource_group.resource_group2.location
  service_plan_id     = azurerm_service_plan.service_plan.id

  site_config {}
}

resource "azurerm_app_service_source_control" "python_source_code" {
  app_id   = azurerm_linux_web_app.python_linux_app.id
  repo_url = "https://github.com/Azure-Samples/python-docs-hello-world"
  branch   = "master"
}
