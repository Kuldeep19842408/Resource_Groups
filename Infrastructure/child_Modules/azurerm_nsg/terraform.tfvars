nsg={
    nsg1={
        name="test-nsg"
        location="centralindia"
        resource_group_name="prod-rg"
#         security_rule {
#         name                       = "test123"
#         priority                   = 100
#         direction                  = "Inbound"
#         access                     = "Allow"
#         protocol                   = "Tcp"
#         source_port_range          = "*"
#         destination_port_range     = "*"
#         source_address_prefix      = "*"
#         destination_address_prefix = "*"
#   }
    }

    nsg2={
        name="test-nsg1"
        location="centralindia"
        resource_group_name="prod-rg"
    }
}
