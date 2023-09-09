variable "resource_group_name" {
  default     = "rgstatefile"
  type        = string
  description = "Resource Group Name"
}

variable "resource_group_location" {
  default     = "East US"
  type        = string
  description = "Resource Group Location"
}

variable "storage_account_name" {
  default     = "sastatefile"
  type        = string
  description = "Storage Account Name"
}

variable "storage_container" {
  default     = "scstatefile"
  type        = string
  description = "Storage Account Container"
}