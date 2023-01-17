terraform {
  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.99"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.4"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "4ecfeecd-734f-4f01-a617-5a3b60d48865"
  tenant_id       = "8ee5f950-31d4-4f1f-852e-2f71f5495847"
  //client_id       = "4113fa9e-22c5-48f0-8385-977aa14e953c"
  //client_secret   = "aA28Q~7dLMzEaClRb2.n4Fm7YQ1cU99qqctBbcPj"
  client_id       = "4407adbe-944b-45cd-97d7-4a850d78db7e"
  client_secret   = "aFL38Q~L1IC1iYbJu8ll5tqK0udke3wvmffbbLaNy"
}}