az login --tenant  '8ee5f950-31d4-4f1f-852e-2f71f5495847'
#Connect-AzAccount -Tenant '8ee5f950-31d4-4f1f-852e-2f71f5495847' -Subscription '4ecfeecd-734f-4f01-a617-5a3b60d48865'

# Create service principal
az ad sp create-for-rbac --name sp --role Contributor --scopes /subscriptions/4ecfeecd-734f-4f01-a617-5a3b60d48865

$env:ARM_CLIENT_ID="4113fa9e-22c5-48f0-8385-977aa14e953c" # "<service_principal_app_id>"
$env:ARM_SUBSCRIPTION_ID="4ecfeecd-734f-4f01-a617-5a3b60d48865" # "<azure_subscription_id>"
$env:ARM_TENANT_ID="8ee5f950-31d4-4f1f-852e-2f71f5495847" # "<azure_subscription_tenant_id>"
$env:ARM_CLIENT_SECRET="aA28Q~7dLMzEaClRb2.n4Fm7YQ1cU99qqctBbcPj" # "<service_principal_password>"

gci env:ARM_*

.\terraform.exe init #  This command downloads the Azure modules required to manage your Azure resources.
.\terraform plan -out main.tfplan  # Run terraform plan to create an execution plan.
.\terraform apply main.tfplan  # Run terraform apply to apply the execution plan to your cloud infrastructure.
