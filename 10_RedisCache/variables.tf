variable "resource_group_name" {
  type        = string
  description = "Name for Resource Group"
}

variable "resource_group_location" {
  type        = string
  description = "Location for Resource Group"
}

variable "redis_cache_name" {
  type        = string
  description = "Name for Redis Cache"
}

variable "redis_cache_capcity" {
  type        = number
  description = "The size of the Redis cache to deploy. Valid values for a SKU family of C (Basic/Standard) are 0, 1, 2, 3, 4, 5, 6, and for P (Premium) family are 1, 2, 3, 4, 5."
}

variable "redis_cache_family" {
  type        = string
  description = "The SKU family/pricing group to use. Valid values are C (for Basic/Standard SKU family) and P (for Premium)."
}

variable "redis_cache_sku" {
  type        = string
  description = "The SKU of Redis to use. Possible values are Basic, Standard and Premium."
}