VM={
    vm1={
        name                  = "test-vm1"
        location              = "centralindia"
        resource_group_name   = "prod-rg"
        network_interface_ids = ["vm1-nic"]
        vm_size               = "Standard_DS1_v2"
        os_profile ={
        computer_name  = "hostname"
        admin_username = "testadmin"
        admin_password = "Password1234!"

  }
        
    }
    vm2={
        name                  = "test-vm2"
        location              = "centralindia"
        resource_group_name   = "prod-rg"
        network_interface_ids = ["vm2-nic"]
        vm_size               = "Standard_DS1_v2"
         os_profile ={
        computer_name  = "hostname1"
        admin_username = "testadmin1"
        admin_password = "Password12345!"
    }
}
}
