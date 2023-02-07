terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "TerraformShared"
    storage_account_name = "terraformlh0001"
    container_name       = "tfstate"
    key                  = "tfstate"
  }
}
provider "azurerm" {
  features {}

  
 // subscription_id = "4ecfeecd-734f-4f01-a617-5a3b60d48865"
 // tenant_id       = "8ee5f950-31d4-4f1f-852e-2f71f5495847"
 // client_id       = "4113fa9e-22c5-48f0-8385-977aa14e953c"
  //client_secret   = "aA28Q~7dLMzEaClRb2.n4Fm7YQ1cU99qqctBbcPj"

}