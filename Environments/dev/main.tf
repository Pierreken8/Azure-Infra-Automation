
module "network_test" {
  source              = "../../Modules/Vnet"
  vnet_name           = "VNET-HOGENT-TEST"
  address_space       = "10.0.0.0/16"
  location            = "West Europe"
  resource_group_name = "SyncProjectSchoon"
  subnet_name         = "Subnet-Leerlingen"
  subnet_prefix       = "10.0.1.0/24"
}
