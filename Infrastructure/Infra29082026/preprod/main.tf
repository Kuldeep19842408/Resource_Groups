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

module "bastion" {
  depends_on = [module.virtual_network]
  source     = "../Modules/azurerm_bastion"
  bastion    = var.bastion
}

module "keyvault" {
  depends_on = [module.resource_group]
  source     = "../Modules/azurerm_key_vault"
  keyvault   = var.keyvault
}

module "nsg" {
  depends_on = [module.resource_group]
  source     = "../Modules/azurerm_nsg"
  nsg        = var.nsg
}

module "lb" {
  depends_on = [module.publicip, module.resource_group]
  source     = "../Modules/azurerm_lb"
  lb         = var.lb
}
