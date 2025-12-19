variable "pub_ip" {
    type = map(object({
      name = string
      resource_group_name = string
        location = string
        sku = optional(string)
        allocation_method = string
        idle_timeout_in_minutes = optional(number)
        ip_version = optional(string)
        sku_tier = optional(string)        
        tags = optional(map(string))
    }))
  
}