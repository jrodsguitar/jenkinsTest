provider "azurerm" {
  subscription_id            = "${var.subscription_id}"
  client_id                  = "${var.client_id}"
  client_secret              = "${var.client_secret}"
  tenant_id                  = "${var.tenant_id}"
}

#Create a resource group if it doesn’t exist
resource "azurerm_resource_group" "myterraformgroup" {
    name     = "myResourceGroup"
    location = "westus"

    tags {
        environment = "Terraform Demo"
    }
}
# 
# Create virtual network
resource "azurerm_virtual_network" "myterraformnetwork" {
    name                = "myVnet"
    address_space       = ["10.250.250.0/23"]
    location            = "westus"
    resource_group_name = "${azurerm_resource_group.myterraformgroup.name}"

    tags {
        environment = "Terraform Demo"
    }
}

# Create subnet
resource "azurerm_subnet" "myterraformsubnet" {
    name                 = "mySubnet"
    resource_group_name  = "${azurerm_resource_group.myterraformgroup.name}"
    virtual_network_name = "${azurerm_virtual_network.myterraformnetwork.name}"
    address_prefix       = "10.250.250.0/24"
}
