provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tektutor" {
  name     = "tektutor"
  location = "eastus" 
}

resource "azurerm_storage_account" "tektutor" {
  name                     = "tektutorstorageacct"
  resource_group_name      = azurerm_resource_group.tektutor.name
  location                 = azurerm_resource_group.tektutor.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "tektutor" {
  name                = "sp"
  location            = azurerm_resource_group.tektutor.location
  resource_group_name = azurerm_resource_group.tektutor.name
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_function_app" "tektutor" {
  name                = "python-tektutor-app"
  location            = azurerm_resource_group.tektutor.location
  resource_group_name = azurerm_resource_group.tektutor.name
  service_plan_id     = azurerm_service_plan.tektutor.id

  storage_account_name       = azurerm_storage_account.tektutor.name
  storage_account_access_key = azurerm_storage_account.tektutor.primary_access_key

  site_config {
    application_stack {
      python_version = "3.9"
    }
  }
}

resource "azurerm_function_app_function" "tektutor" {
  name            = "tektutor-python-function"
  function_app_id = azurerm_linux_function_app.tektutor.id
  language        = "Python"
  file {
    name    = "__init__.py"
    content = file("./SampleApp/PythonSampleApp/__init__.py")
  }
  test_data = file("./SampleApp/PythonSampleApp/sample.dat")
  #  test_data = jsonencode({
  #    "name" = "Azure"
  #  })
  config_json = file("./SampleApp/PythonSampleApp/function.json")
  #  config_json = jsonencode({
  #    "scriptFile" = "__init__.py"
  #    "bindings" = [
  #      {
  #        "authLevel" = "anonymous"
  #        "direction" = "in"
  #        "methods" = [
  #          "get",
  #          "post",
  #        ]
  #        "name" = "req"
  #        "type" = "httpTrigger"
  #      },
  #      {
  #        "direction" = "out"
  #        "name"      = "$return"
  #        "type"      = "http"
  #      },
  #    ]
  #  })
}
