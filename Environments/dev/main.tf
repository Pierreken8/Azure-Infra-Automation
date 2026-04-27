terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {} # 
}
# 1. Het centrale VNet (De 'Hub' van Campus Ledebaan)
resource "azurerm_virtual_network" "main_vnet" {
  name                = "VNET-Campus-Ledebaan"
  location            = "Switzerland North"
  resource_group_name = "SyncProjectSchoon"

  

  address_space       = [
    "10.20.0.0/16",   # Management
    "10.21.0.0/16",   # Servers
    "172.16.0.0/12",  # Campus breed (Personeel, Leerlingen, etc.)
    "192.168.0.0/16"  # PLC en Examens
  ]
}




# 2. De 4 Subnets koppelen aan Campus-Ledebaan
module "spoke_Intern" {
  source              = "../../Modules/Vnet"
  vnet_name           = azurerm_virtual_network.main_vnet.name
  location            = "Switzerland North"
  resource_group_name = "SyncProjectSchoon"
  subnet_name         = "Subnet-Intern"
  address_space       = "10.20.0.0/16"
  subnet_prefix       = "10.20.0.0/16"

}

module "spoke_Personeel" {
  source              = "../../Modules/Vnet"
  vnet_name           = azurerm_virtual_network.main_vnet.name
  location            = "Switzerland North"
  resource_group_name = "SyncProjectSchoon"
  subnet_name         = "Subnet-Personeel"
  address_space       = "172.16.0.0/12"
  subnet_prefix       = "172.21.0.0/16"
}

module "spoke_Leerling" {
  source              = "../../Modules/Vnet"
  vnet_name           = azurerm_virtual_network.main_vnet.name
  location            = "Switzerland North"
  resource_group_name = "SyncProjectSchoon"
  subnet_name         = "Subnet-Leerling"
  address_space       = "172.16.0.0/12"
  subnet_prefix       = "172.22.0.0/22"
}

module "spoke_Printer" {
  source              = "../../Modules/Vnet"
  vnet_name           = azurerm_virtual_network.main_vnet.name
  location            = "Switzerland North"
  resource_group_name = "SyncProjectSchoon"
  subnet_name         = "Subnet-Printer"
  address_space       = "172.16.0.0/12"
  subnet_prefix       = "172.23.0.0/16"
}                                                                               

# 5. Subnet Voip
module "spoke_voip" {
  source              = "../../Modules/Vnet"
  vnet_name           = azurerm_virtual_network.main_vnet.name
  location            = "Switzerland North"
  resource_group_name = "SyncProjectSchoon"
  subnet_name         = "Subnet-Voip"
  address_space       = "172.16.0.0/12"
  subnet_prefix       = "172.24.0.0/26"

  
}

# 6. Subnet Camera's
module "spoke_Camera" {
  source              = "../../Modules/Vnet"
  vnet_name           = azurerm_virtual_network.main_vnet.name
  location            = "Switzerland North"
  resource_group_name = "SyncProjectSchoon"
  subnet_name         = "Subnet-Cameras"
  address_space       = "172.16.0.0/12"
  subnet_prefix       = "172.25.0.0/26"
}

# 6. Subnet Gast
module "spoke_Gast" {
  source              = "../../Modules/Vnet"
  vnet_name           = azurerm_virtual_network.main_vnet.name
  location            = "Switzerland North"
  resource_group_name = "SyncProjectSchoon"
  subnet_name         = "Subnet-Gast"
  address_space       = "172.16.0.0/12"
  subnet_prefix       = "172.26.0.0/24"
}

# 7. Subnet ICT
module "spoke_ICT" {
  source              = "../../Modules/Vnet"
  vnet_name           = azurerm_virtual_network.main_vnet.name
  location            = "Switzerland North"
  resource_group_name = "SyncProjectSchoon"
  subnet_name         = "Subnet-ICT"
  address_space       = "172.16.0.0/12"
  subnet_prefix       = "172.28.0.0/24"

  
custom_rules = [

{
   name                        = "Allow-Admin-RDP"  #Bij RDP wil we met onze ICT-laptop verbinding maken met een server. De server is dus de "ontvanger" van onze verzoek
   priority                    = 100
   direction                   = "Inbound"
   access                      = "Allow"
   protocol                    = "Tcp"
   source_port_range           = "*"
   destination_port_range      = "3389"
   source_address_prefix       = "172.28.0.0/24"
   destination_address_prefix  = "10.21.0.0/26"

  }

]

}

# 8. Subnet Beamers
module "spoke_Beamers" {
  source              = "../../Modules/Vnet"
  vnet_name           = azurerm_virtual_network.main_vnet.name
  location            = "Switzerland North"
  resource_group_name = "SyncProjectSchoon"
  subnet_name         = "Subnet-Beamers"
  address_space       = "172.16.0.0/12"
  subnet_prefix       = "172.29.0.0/24"
}

# 9. Subnet Servers
module "spoke_Servers" {
  source              = "../../Modules/Vnet"
  vnet_name           = azurerm_virtual_network.main_vnet.name
  location            = "Switzerland North"
  resource_group_name = "SyncProjectSchoon"
  subnet_name         = "Subnet-Servers"
  address_space       = "10.20.0.0/16"
  subnet_prefix       = "10.21.0.0/26"
}

# 10. Subnet PLC
module "spoke_PLC" {
  source              = "../../Modules/Vnet"
  vnet_name           = azurerm_virtual_network.main_vnet.name
  location            = "Switzerland North"
  resource_group_name = "SyncProjectSchoon"
  subnet_name         = "Subnet-PLC"
  address_space       = "192.168.0.0/16"
  subnet_prefix       = "192.168.200.0/28"
}

# 11. Subnet Examens
module "spoke_Examens" {
  source              = "../../Modules/Vnet"
  vnet_name           = azurerm_virtual_network.main_vnet.name
  location            = "Switzerland North"
  resource_group_name = "SyncProjectSchoon"
  subnet_name         = "Subnet-Examens"
  address_space       = "192.168.0.0/16"
  subnet_prefix       = "192.168.201.0/24"

}


