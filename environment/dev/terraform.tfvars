rg = {
  "rgkey" = {
    name       = "demo_RG9773"
    location   = "westeurope"
    managed_by = "terraform_az"
    tags = {
      environment = "dev"
    }
  }
}
# "rgkey1" = {  
# name     = "demo_RG97731"
# location = "CentralUS"
# managed_by = "terraform_az"
# tags = {
# environment = "dev"
# }
# }
# }


sgs = {
  "sgkey" = {

    name                     = "demostorageaccnt97739"
    resource_group_name      = "demo_RG9773"
    location                 = "westeurope"
    account_tier             = "Premium"
    account_replication_type = "LRS"

    #Optional Feilds

    # account_kind                      = "FileStorage"
    # access_tier                       = "Hot"
    # cross_tenant_replication_enabled  = true
    # provisioned_billing_model_version = "V2"
    # edge_zone                         = null
    # https_traffic_only_enabled        = true
    # min_tls_version                   = "TLS1_2"
    # allow_nested_items_to_be_public   = true
    # shared_access_key_enabled         = true
    # public_network_access_enabled     = true
    # default_to_oauth_authentication   = false
    # is_hns_enabled                    = false
    # nfsv3_enabled                     = false
    # large_file_share_enabled          = false
    # local_user_enabled                = true
    # queue_encryption_key_type         = "Service"
    # table_encryption_key_type         = "Service"
    # infrastructure_encryption_enabled = false
    # allowed_copy_scope                = null
    # sftp_enabled                      = false
    # dns_endpoint_type                 = "Standard"
    # tags = {
    #   environment = "dev"
    # }

    network_ruless = {
      rule1 = {
        default_action = "Deny"
        bypass         = ["AzureServices"]
        ip_rules       = ["110.235.237.223"]
      }

    }
  }

}
vnets = {
  "vnetkey" = {
    name                = "demo_vnet"
    location            = "westeurope"
    resource_group_name = "demo_RG9773"
    address_space       = ["10.0.0.0/16"]
    dns_servers         = ["10.0.0.4", "10.0.0.5"]
    tags = {
      environment = "dev"
    }
    subnet = [
      {
        name             = "subnet1"
        address_prefixes = ["10.0.1.0/24"]
      },
      {
        name             = "subnet2"
        address_prefixes = ["10.0.2.0/24"]
    }]
  }
}
pub_ip = {
  "pubipkey" = {
    name                    = "PIP_1"
    resource_group_name     = "demo_RG9773"
    location                = "westeurope"
    sku                     = "Standard"
    allocation_method       = "Static"
    idle_timeout_in_minutes = 15
    ip_version              = "IPv4"
    sku_tier                = "Regional"
    tags = {
      environment = "dev"
    }
  }
  "pubipkey1" = {
    name                    = "PIP_2"
    resource_group_name     = "demo_RG9773"
    location                = "westeurope"
    sku                     = "Standard"
    allocation_method       = "Static"
    idle_timeout_in_minutes = 15
    ip_version              = "IPv4"
    sku_tier                = "Regional"
    tags = {
      environment = "dev"

    }
  }
}

vms = {
  linuxvm1 = {
    subnet_name = "subnet1"
    vnet_name   = "demo_vnet"
    pip_name    = "PIP_1"
    nsg_name    = "linuxvm1-nsg"


    nic_name            = "nic-1"
    location            = "westeurope"
    resource_group_name = "demo_RG9773"

    ip_configuration = {
      ip1 = {
        name                          = "ipconfig1"
        private_ip_address_allocation = "Dynamic"
      }
    }

    vm_name        = "Frontend-vm-1"
    vm_size        = "Standard_D2s_v3"
    admin_username = "azureuser"
    admin_password = "Admin@12345"

    os_disk = {
      disk1 = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
    }

    source_image_reference = {
      image1 = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
      }
    }
  }

  linuxvm2 = {
    subnet_name = "subnet2"
    vnet_name   = "demo_vnet"
    pip_name    = "PIP_2"
    nsg_name    = "linuxvm2-nsg"

    nic_name            = "nic-2"
    location            = "westeurope"
    resource_group_name = "demo_RG9773"

    ip_configuration = {
      ip1 = {
        name                          = "ipconfig1"
        private_ip_address_allocation = "Dynamic"
      }
    }

    vm_name        = "Backend-vm-2"
    vm_size        = "Standard_D2s_v3"
    admin_username = "azureuser"
    admin_password = "Admin@12345"

    os_disk = {
      disk1 = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
    }

    source_image_reference = {
      image1 = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
      }
    }
  }
}

sqlserver = {
  "sqlserverkey" = {
    name                         = "demosqlserver9773"
    resource_group_name          = "demo_RG9773"
    location                     = "westeurope"
    version                      = "12.0"
    administrator_login          = "AdminUser"
    administrator_login_password = "StrongPassword@123"
  }
}

sqldatabase = {
  "sqldbkey" = {
    name                = "demosqldb9773"
    server_name         = "demosqlserver9773"
    resource_group_name = "demo_RG9773"
    collation           = "SQL_Latin1_General_CP1_CI_AS"
    license_type        = "LicenseIncluded"
    max_size_gb         = 10
    sku_name            = "S0"
    enclave_type        = "Default"
  }
}
