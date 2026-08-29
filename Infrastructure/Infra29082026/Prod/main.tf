module "resource_group" {
  source = "../Modules/azurerm_resource_group"
  rgx    = var.rgx
}

module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../Modules/azurerm_virtual_network"
  vnet       = var.vnet
}

module "subnet" {
  depends_on = [module.virtual_network]
  source     = "../Modules/azurerm_subnet"
  subnet     = var.subnet
}

module "publicip" {
  depends_on = [module.resource_group]
  source     = "../Modules/azurerm_publicip"
  pip        = var.pip
}

module "virtual_machine" {
  depends_on = [module.subnet, module.publicip]
  source     = "../Modules/azurerm_vm"
  vms        = var.vms
}

