variable "sqldatabase" {
  type = map(object({
    name                = string
    server_name         = string
    resource_group_name = string
    collation           = string
    license_type        = optional(string)
    max_size_gb         = optional(number)
    sku_name            = string
    enclave_type        = optional(string)
  }))

}
