module "rg_name" {
  source = "../../Modules/azurerm_resource_group"
  rg     = var.rg
}

module "storage_account" {
  source     = "../../Modules/storage_account"
  sgs        = var.sgs
  depends_on = [module.rg_name]

}

module "vnets" {

  source     = "../../Modules/vnet"
  vnets      = var.vnets
  depends_on = [module.rg_name]

}

module "public_ip" {
  source     = "../../Modules/public_ip"
  pub_ip     = var.pub_ip
  depends_on = [module.rg_name]


}
module "virtual_machine" {
  source     = "../../Modules/azurerm_virtual_machine"
  vms        = var.vms
  depends_on = [module.rg_name, module.vnets, module.public_ip]

}

module "sql_server" {
  source     = "../../Modules/azurerm_sql_server"
  sqlserver  = var.sqlserver
  depends_on = [module.rg_name]

}

module "sql_database" {
  source      = "../../Modules/azurerm_sql_database"
  sqldatabase = var.sqldatabase
  depends_on  = [module.sql_server]

}
