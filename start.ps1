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




$ARM_SUBSCRIPTION_ID="0d7ee0d7-f9e4-4089-bcc1-f0cfeacb104c" 
$ARM_TENANT_ID="f6b5d7f7-41d1-4677-9ca2-ed72c96ec748" 

## Create storage account for manual Terraform deployments
$TerraformStorageSub = "0d7ee0d7-f9e4-4089-bcc1-f0cfeacb104c"
$TerraformStorageRSG = "TerraformShared"
$TerraformStorageName="terraformlh0001"
$TerraformStorageContainer =  "tfstate"


az login --tenant  $ARM_TENANT_ID
az account set --subscription $TerraformStorageSub 
#az account set --subscription "45ded6c5-f6e0-4509-a7ab-ca497d860973"  ## connectivity
# Create resource group
az group create --name $TerraformStorageRSG --location "West Europe"

# Create storage account
az storage account create --resource-group $TerraformStorageRSG --name $TerraformStorageName --sku Standard_LRS --encryption-services blob
#az storage account create --resource-group $TerraformStorageRSG --name "terraformlh002" --sku Standard_LRS --encryption-services blob
# Get storage account key
$ACCOUNT_KEY=$(az storage account keys list --resource-group $TerraformStorageRSG --account-name $TerraformStorageName --query [0].value -o tsv)
#$ACCOUNT_KEY=$(az storage account keys list --resource-group $TerraformStorageRSG --account-name "terraformlh002" --query [0].value -o tsv)
# Create blob container
az storage container create --name $TerraformStorageContainer --account-name $TerraformStorageName --account-key $ACCOUNT_KEY



##  Create service principal and give it Contributor on subscription
$subscriptionName = "Terraformt"
$ServicePrincipalName = "sub-"+$subscriptionName+"-SP"
$sub = az account list --query "[?name=='${subscriptionName}'].{id:id}"  
$sub_id = ($sub | convertfrom-json).id


$sp = (az ad sp create-for-rbac --name $ServicePrincipalName --role Contributor --scopes /subscriptions/$sub_id)
$sp_id = ($sp | convertfrom-json).appId


az role assignment create --assignee-object-id "${sp_id}"  --assignee-principal-type "ServicePrincipal" `
  --role "Contributor"   --scope "/subscriptions/${sub_id}"

write-host "Service principal on $subscriptionName created: `n " 
$sp

