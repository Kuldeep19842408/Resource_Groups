rgx = {
  rg1 = {
    name     = "k-rg2-prod"
    location = "japaneast"
  }
}

vnet = {
  vnet1 = {
    name                = "k-vnet02-prod"
    location            = "japaneast"
    resource_group_name = "k-rg2-prod"
    address_space       = ["10.0.0.0/16"]
  }
}

subnet = {
  subnet1 = {
    name                 = "frontend_subnet01-prod"
    virtual_network_name = "k-vnet02-prod"
    resource_group_name  = "k-rg2-prod"
    address_prefixes     = ["10.0.1.0/24"]
  }

  subnet2 = {
    name                 = "backend_subnet02-prod"
    virtual_network_name = "k-vnet02-prod"
    resource_group_name  = "k-rg2-prod"
    address_prefixes     = ["10.0.2.0/24"]
  }

  subnet3 = {
    name                 = "database_subnet03-prod"
    virtual_network_name = "k-vnet02-prod"
    resource_group_name  = "k-rg2-prod"
    address_prefixes     = ["10.0.3.0/24"]
  }
}

pip = {
  pip1 = {
    name                = "k-pip03-prod"
    resource_group_name = "k-rg2-prod"
    location            = "japaneast"
    allocation_method   = "Static"
  }

  pip2 = {
    name                = "k-pip04-prod"
    resource_group_name = "k-rg2-prod"
    location            = "japaneast"
    allocation_method   = "Static"
  }

  pip3 = {
    name                = "k-pip05-prod"
    resource_group_name = "k-rg2-prod"
    location            = "japaneast"
    allocation_method   = "Static"
  }
}

vms = {
  vm1 = {
    nic_name            = "frontend-nic-vm-014-prod"
    location            = "japaneast"
    resource_group_name = "k-rg2-prod"
    nic_subnet_name     = "frontend_subnet01-prod"
    nic_virtual_name    = "k-vnet02-prod"
    nic_pip_name        = "k-pip03-prod"
    vm_name             = "frontend-vm01-prod"
    vm_size             = "Standard_D2s_v3"
    admin_username      = "adminuser"
    admin_password      = "DevOps@123"
  }

  vm2 = {
    nic_name            = "backendend-nic-vm-013-prod"
    location            = "japaneast"
    resource_group_name = "k-rg2-prod"
    nic_subnet_name     = "backend_subnet02-prod"
    nic_virtual_name    = "k-vnet02-prod"
    nic_pip_name        = "k-pip04-prod"
    vm_name             = "backend-vm-prod"
    vm_size             = "Standard_D2s_v3"
    admin_username      = "adminuser"
    admin_password      = "DevOps@123"
  }

  vm3 = {
    nic_name            = "database-nic-vm01-prod"
    location            = "japaneast"
    resource_group_name = "k-rg2-prod"
    nic_subnet_name     = "database_subnet03-prod"
    nic_virtual_name    = "k-vnet02-prod"
    nic_pip_name        = "k-pip05-prod"
    vm_name             = "database-vm01-prod"
    vm_size             = "Standard_D2s_v3"
    admin_username      = "adminuser"
    admin_password      = "DevOps@123"
  }
}