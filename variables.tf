variable "resource_group_location" {
  default     = "westeurope"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "Vnet1" {
  default = "10.44"
}

variable "Vnet2" {
  default = "10.45"
}

variable "HubVnet" {
  default = "10.43"
}