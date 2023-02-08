
resource "azurerm_resource_group" "rgtest" {
  location = var.resource_group_location
  name     = "Connectivity2"
}

module "dns" {
  source = "./modules/dns"
  tags = var.tags
}



resource "azurerm_resource_group" "vmStoreRg" {
  name                   = lower("${var.azure_vm_store_config.rg_name}-${local.name_postfix}")
  location               = var.location
  tags                   = var.tags
 }


resource "azurerm_shared_image_gallery" "vmStoreGallery" {
  name                = "vmstore"
  resource_group_name = azurerm_resource_group.vmStoreRg.name
  location            = azurerm_resource_group.vmStoreRg.location
  description         = "description"
  tags                = var.tags
}

/*
resource "azurerm_virtual_network" "vnet1" {
  location            = var.resource_group_location
  name                = "VNet1"
  resource_group_name = azurerm_resource_group.rgtest.name
  address_space       = ["${var.Vnet1}.0.0/16"]
}


resource "azurerm_subnet" "vnet1_vmsubnet" {
  name                 = "VMSubnet"
  resource_group_name  = azurerm_resource_group.rgtest.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["${var.Vnet1}.1.0/24"]
}
resource "azurerm_subnet" "Bastionsubnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rgtest.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["${var.Vnet1}.2.0/24"]
}
resource "azurerm_subnet" "GWsubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.rgtest.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["${var.Vnet1}.3.0/24"]
}


// Vnet 2

resource "azurerm_virtual_network" "vnet2" {
  location            = var.resource_group_location
  name                = "VNet2"
  resource_group_name = azurerm_resource_group.rgtest.name
  address_space       = ["${var.Vnet2}.0.0/16"]
}

resource "azurerm_subnet" "vnet2_vmsubnet" {
  name                 = "VMSubnet"
  resource_group_name  = azurerm_resource_group.rgtest.name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  address_prefixes     = ["${var.Vnet2}.1.0/24"]
}

//VWan
/*
resource "azurerm_virtual_wan" "VWan" {
  name                = "VWan"
  resource_group_name = azurerm_resource_group.rgtest.name
  location            = azurerm_resource_group.rgtest.location
  type                = "Standard"
}

resource "azurerm_virtual_hub" "VWan_Hub" {
  name                = "VWanHub"
  resource_group_name = azurerm_resource_group.rgtest.name
  location            = azurerm_resource_group.rgtest.location
  virtual_wan_id      = azurerm_virtual_wan.VWan.id
  address_prefix      = "${var.HubVnet}.0.0/24"
  sku                 = "Standard"
}

//  VM


resource "azurerm_resource_group" "spoke1_rsg" {
  location = var.resource_group_location
  name     = "Spoke1"
}
resource "azurerm_network_interface" "myvm1nic" {
  name                = "myvm1-nic"
  location            = azurerm_resource_group.spoke1_rsg.location
  resource_group_name = azurerm_resource_group.spoke1_rsg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.vnet1_vmsubnet.id
    private_ip_address_allocation = "Dynamic"
    //   public_ip_address_id   =   azurerm_public_ip.myvm 1 publicip.id 
  }
}

resource "azurerm_windows_virtual_machine" "vm1" {
  name                  = "myvm1"
  location              = azurerm_resource_group.spoke1_rsg.location
  resource_group_name   = azurerm_resource_group.spoke1_rsg.name
  network_interface_ids = [azurerm_network_interface.myvm1nic.id]
  size                  = "Standard_B1s"
  admin_username        = "adminuser"
  admin_password        = "Password123!"

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  depends_on = [
    azurerm_virtual_wan.VWan,
    azurerm_subnet.vnet1_vmsubnet
  ]
}


resource "azurerm_resource_group" "spoke2_rsg" {
  location = var.resource_group_location
  name     = "Spoke2"
}
resource "azurerm_network_interface" "myvm2nic" {
  name                = "myvm2-nic"
  location            = azurerm_resource_group.spoke2_rsg.location
  resource_group_name = azurerm_resource_group.spoke2_rsg.name

  ip_configuration {
    name                          = "ipconfig2"
    subnet_id                     = azurerm_subnet.vnet2_vmsubnet.id
    private_ip_address_allocation = "Dynamic"
    //   public_ip_address_id   =   azurerm_public_ip.myvm 1 publicip.id 
  }
}

resource "azurerm_windows_virtual_machine" "vm2" {
  name                  = "myvm2"
  location              = azurerm_resource_group.spoke2_rsg.location
  resource_group_name   = azurerm_resource_group.spoke2_rsg.name
  network_interface_ids = [azurerm_network_interface.myvm2nic.id]
  size                  = "Standard_B1s"
  admin_username        = "adminuser"
  admin_password        = "Password123!"

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  depends_on = [
    azurerm_virtual_wan.VWan,
    azurerm_subnet.vnet2_vmsubnet
  ]
} 

*/