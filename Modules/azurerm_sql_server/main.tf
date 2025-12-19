resource "azurerm_mssql_server" "ms_server" {

  for_each = var.sqlserver

  name                         = each.value.name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = each.value.version
  administrator_login          = "AdminUser"
  administrator_login_password = "StrongPassword@123"
}
