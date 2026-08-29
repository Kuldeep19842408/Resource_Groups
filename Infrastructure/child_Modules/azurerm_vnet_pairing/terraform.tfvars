Vnet={
    vnet1={
  name                = "rg_vneta"
  # location            = "eastus"
  resource_group_name = "rg_st"
  address_space       = ["10.0.0.0/16"]
  # dns_servers         = ["10.0.0.4", "10.0.0.5"]
  name1="peer1to2"
  remote_virtual_network_id="/subscriptions/521d583a-1bad-4b17-8fe8-404be62f6fd3/resourceGroups/rg_st/providers/Microsoft.Network/virtualNetworks/rg_vnetb"
  
    }
    vnet2={
  name                = "rg_vnetb"
  resource_group_name = "rg_st"
  address_space       = ["10.1.0.0/16"]
  name1="peer2to1"
  remote_virtual_network_id="/subscriptions/521d583a-1bad-4b17-8fe8-404be62f6fd3/resourceGroups/rg_st/providers/Microsoft.Network/virtualNetworks/rg_vneta"
  
    }
    
}