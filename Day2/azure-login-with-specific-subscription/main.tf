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

    subscription_id = "your-azure-subscription-id"
    tenant_id = "your-azure-tenantid"
}
