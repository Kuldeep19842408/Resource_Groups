resource "azurerm_resource_group" "k" {
    for_each = var.rgx
    name = each.value.name
    location = each.value.location
  
}