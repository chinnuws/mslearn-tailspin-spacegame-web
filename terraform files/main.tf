variable "subscription_id" {
    type = string
    default = "3df0a617-8449-447a-b3b6-4da9b2d1e787"
    description = "Azure subscription id"
}

variable "client_id" {
    type = string
    default = "127cad09-40ae-46ed-a745-4e4282dbcf25"
    description = "Azure client id"
}

variable "client_secret" {
    type = string
    default = "esO8.QEhsBrWlrN5_DWD4.CJqpFcVSKFyp"
    description = "Azure client secret"
}

variable "tenant_id" {
    type = string
    default = "98a88ccb-a76c-41ea-ad44-1354bd5a4e43"
    description = "Azure tenant id"
}

provider "azurerm" {
    features {}
    version="~>2.0"
    subscription_id=var.subscription_id
    client_id=var.client_id
    client_secret=var.client_secret
    tenant_id=var.tenant_id
}

resource "azurerm_resource_group" "rsgpoc" {
    name = "rsgapp"
    location = "West Europe"
}

resource "azurerm_app_service_plan" "planpoc" {
  name                = "planapp"
  location            = "West Europe"
  resource_group_name = azurerm_resource_group.rsgpoc.name

  sku {
      tier = "standard"        # SKU sub block inside
      size = "F1"
  }  
}


resource "azurerm_app_service" "webapppoc71" {
    name = "webapppoc71"
    location = "West Europe"
    resource_group_name = azurerm_resource_group.rsgpoc.name
    app_service_plan_id = azurerm_app_service_plan.planpoc.id

    site_config {
        dotnet_framework_version = "v4.0"
    }
}






