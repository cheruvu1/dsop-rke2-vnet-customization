provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rke2" {
  count    = var.use_external_vnet ? 0 : 1
  name     = var.cluster_name
  location = var.location
}

resource "azurerm_virtual_network" "rke2" {
  count               = var.use_external_vnet ? 0 : 1
  name                = "${var.cluster_name}-vnet"
  address_space       = [var.address_space]
  resource_group_name = azurerm_resource_group.rke2.*.name[0]
  location            = azurerm_resource_group.rke2.*.location[0]
}

resource "azurerm_subnet" "rke2" {
  count                = var.use_external_vnet ? 0 : 1
  name                 = "${var.cluster_name}-snet"
  resource_group_name  = azurerm_resource_group.rke2.*.name[0]
  virtual_network_name = azurerm_virtual_network.rke2.*.name[0]
  address_prefixes     = [var.subnet_cidr]
}

# use existing virtnual network
data "azurerm_subnet" "external" {
  count                = var.use_external_vnet ? 1 : 0
  name                 = var.external_vnet_subnet_name
  virtual_network_name = var.external_vnet_name
  resource_group_name  = var.external_vnet_resource_group
}

module "rke2" {
  source                 = "../"
  cluster_name           = var.cluster_name
  subnet_id              = var.use_external_vnet ? data.azurerm_subnet.external.*.id[0] : azurerm_subnet.rke2.*.id[0]
  server_public_ip       = var.server_public_ip
  server_open_ssh_public = var.server_open_ssh_public
  vm_size                = var.vm_size
  server_instance_count  = var.server_instance_count
  agent_instance_count   = var.agent_instance_count
  cloud                  = var.cloud
}
