resource "azurerm_subnet" "bastion" {
  for_each             = var.bastion
  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_public_ip" "bastion" {
  for_each            = var.bastion
  name                = each.value.public_ip_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  allocation_method = "Static"
  sku               = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  for_each            = var.bastion
  name                = each.value.bastion_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = lookup(each.value, "sku", "Standard")

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion[each.key].id
    public_ip_address_id = azurerm_public_ip.bastion[each.key].id
  }
}
