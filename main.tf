

resource "azurerm_resource_group" "lab2akinRG" {
  name     = "lab2akinRG-resources"
  location = "East US"
}

resource "azurerm_storage_account" "lab2akinstorage" {
  name                     = "lab2akinstorage"
  resource_group_name      = azurerm_resource_group.lab2akinRG.name
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  public_network_access_enabled = true
}

resource "azurerm_app_service_plan" "lab2akinfunctionapp" {
  name                = "azure-functions-test-service-plan"
  location            = "East US"
  resource_group_name = azurerm_resource_group.lab2akinRG.name
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "lab2akinfunctionapp" {
  name                       = "test-azure-functions-terraform"
  location                   = "East US"
  resource_group_name        = azurerm_resource_group.lab2akinRG.name
  app_service_plan_id        = azurerm_app_service_plan.lab2akinfunctionapp.id
  storage_account_name       = azurerm_storage_account.lab2akinstorage.name
  storage_account_access_key = azurerm_storage_account.lab2akinstorage.primary_access_key
}