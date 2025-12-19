data "azurerm_mssql_server" "data_server" {

  for_each            = var.sqldatabase
  name                = each.value.server_name
  resource_group_name = each.value.resource_group_name
}
