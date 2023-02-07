/*
Deploys products and product policies.
Variables are declared in APIM-Product.variables.tf
Products deployed are defined in main.auto.tfvars
*/

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.20.0"
    }
  }

  required_version = ">= 1.1.0"
}

resource "azurerm_api_management_product" "product" {
  product_id            = var.product.productId
  api_management_name   = var.api_management_name
  resource_group_name   = var.resource_group_name
  display_name          = var.product.productName
  subscription_required = var.product.subscriptionRequired
  subscriptions_limit   = var.product.subscriptionsLimit
  approval_required     = var.product.approvalRequired
  published             = var.product.published
}
# Set product policy
/*
resource "azurerm_api_management_product_policy" "productPolicy" {
  count = (var.eventhub_logger == "" ? 1 : 0)

  product_id          = var.product.productId
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name

  xml_content = <<XML
    <policies>
      <inbound>
        <base />
      </inbound>
      <backend>
        <base />
      </backend>
      <outbound>
        <set-header name="Server" exists-action="delete" />
        <set-header name="X-Powered-By" exists-action="delete" />
        <set-header name="X-AspNet-Version" exists-action="delete" />
        <base />
      </outbound>
      <on-error>
        <base />
      </on-error>
    </policies>
  XML
  depends_on = [azurerm_api_management_product.product]
}
*/

# Set product policy
resource "azurerm_api_management_product_policy" "productPolicyEventHub" {
  count = (var.eventhub_logger == "" ? 0 : 1)

  product_id          = var.product.productId
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name

  xml_content = var.product.xml_content != "" ? templatefile(var.product.xml_content, merge(var.product.policy_variables, {eventhub_logger = var.eventhub_logger})) : "<policies><inbound><base /></inbound><backend><base /></backend><outbound><base /></outbound><on-error><base /></on-error></policies>"

  depends_on = [azurerm_api_management_product.product]
}
##TODO acccess control