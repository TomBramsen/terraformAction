variable "location"   { 
    type = string
    default = "northeurope"
}

variable "tags" {
  type = map(any)
}


variable "rg_name" {
  type = string
  default = "dns-private-lh-neu"
}
