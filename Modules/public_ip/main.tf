resource "azurerm_public_ip" "example" {
    for_each = var.pub_ip
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = each.value.sku
  allocation_method   = each.value.allocation_method
  idle_timeout_in_minutes = each.value.idle_timeout_in_minutes
  ip_version = each.value.ip_version
  sku_tier = each.value.sku_tier
  tags = each.value.tags
  }