data "azurerm_subnet" "k-subnet01" {
    for_each = var.vms
    name = each.value.nic_subnet_name
    virtual_network_name = each.value. nic_virtual_name
    resource_group_name = each.value.resource_group_name
    # address_prefixes = each.value.nicsaddress_prefixes
  
}


data "azurerm_public_ip" "k-pip01" {
    for_each = var.vms
    name = each.value.nic_pip_name
    resource_group_name = each.value.resource_group_name
    # location = each.value.nics.location
    # allocation_method = each.value.nics.allocation_method
  
}