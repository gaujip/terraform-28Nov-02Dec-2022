provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tektutor" {
  name     = "${var.prefix}-resources"
  location = var.location
}

resource "azurerm_service_plan" "tektutor" {
  name                = "${var.prefix}-sp-zipdeploy"
  location            = azurerm_resource_group.tektutor.location
  resource_group_name = azurerm_resource_group.tektutor.name
  os_type             = "Linux"
  sku_name            = "S1"
}


resource "azurerm_linux_web_app" "tektutor" {
  name                = "${var.prefix}-tektutor"
  location            = azurerm_resource_group.tektutor.location
  resource_group_name = azurerm_resource_group.tektutor.name
  service_plan_id     = azurerm_service_plan.tektutor.id

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }

  site_config {
    application_stack {
      docker_image     = "jackofallops/azure-containerapps-python-acctest"
      docker_image_tag = "v0.0.1"
    }
  }
}
