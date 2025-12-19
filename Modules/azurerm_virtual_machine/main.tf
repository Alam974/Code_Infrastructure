# NETWORK SECURITY GROUP using for_each

resource "azurerm_network_security_group" "nsg" {
  for_each = var.vms

  name                = "${each.key}-nsg"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}




# NETWORK INTERFACE using for_each

resource "azurerm_network_interface" "nic" {
  for_each            = var.vms
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name


  dynamic "ip_configuration" {

    for_each = each.value.ip_configuration
    content {
      name = ip_configuration.value.name
      #subnet_id                     = ip_configuration.value.subnet_id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      subnet_id                     = data.azurerm_subnet.subnetdata_block[each.key].id

      #public_ip_address_id          = ip_configuration.value.public_ip_address_id
      #public_ip_address_id = lookup(ip_configuration.value, "public_ip_address_id", null)
      public_ip_address_id = data.azurerm_public_ip.datablock_pip[each.key].id
    }

  }
}
# NIC + NSG ASSOCIATION
# ------------------------------------
resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  for_each = var.vms

  network_interface_id      = azurerm_network_interface.nic[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}
# ------------------------------------
# VM using for_each + Dynamic Block
# ------------------------------------
resource "azurerm_linux_virtual_machine" "vm" {
  for_each                        = var.vms
  name                            = each.value.vm_name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.vm_size
  admin_username                  = "AdminUser"
  admin_password                  = "Admin123456!"
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id
  ]

  dynamic "os_disk" {
    for_each = each.value.os_disk
    content {
      caching              = os_disk.value.caching
      storage_account_type = os_disk.value.storage_account_type
    }
  }

  dynamic "source_image_reference" {
    for_each = each.value.source_image_reference
    content {
      publisher = source_image_reference.value.publisher
      offer     = source_image_reference.value.offer
      sku       = source_image_reference.value.sku
      version   = source_image_reference.value.version
    }
  }
}
