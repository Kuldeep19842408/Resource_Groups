variable "Vnet" {}
# resource "azurerm_virtual_network" "test11" {
#     for_each = var.Vnet
#   name                = each.value.name
#   location            = each.value.location
#   resource_group_name = each.value.resource_group_name
#   address_space       = each.value.address_space
#   # dns_servers         = each.value.dns_servers

# }

resource "azurerm_virtual_network_peering" "peer" {
  for_each = var.Vnet
  name  = each.value.name1
  # location = each.value.location
  resource_group_name       = each.value.resource_group_name
  virtual_network_name      = each.value.name
  remote_virtual_network_id = each.value.remote_virtual_network_id
}

# resource "azurerm_virtual_network_peering" "example_2" {
  #  for_each = var.Vnet
  # name                      = each.value.name1
  # resource_group_name       = each.value.resource_group_name
  # virtual_network_name      = azurerm_virtual_network.test11["vnet2"].name
  # remote_virtual_network_id = each.value.remote_virtual_network_id
# }