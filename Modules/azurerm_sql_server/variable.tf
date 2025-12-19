variable "sqlserver" {
  type = map(object({
    name                         = string
    resource_group_name          = string
    location                     = string
    version                      = string
    administrator_login          = string
    administrator_login_password = string
    #server_id                    = string # Added server_id to match usage in sql_database module (ye alag se variable liya h data block k liye jisse sql ka server id)
  }))

}
