variable "vnet_name" {
  description = "De naam van het virtuele netwerk"
  type        = string
}

variable "address_space" {
  description = "De IP-range van het VNet"
  type        = string
}

variable "location" {
  description = "De Azure regio"
  type        = string
}

variable "resource_group_name" {
  description = "De naam van de resource group"
  type        = string
}

variable "subnet_name" {
  description = "De naam van het subnet"
  type        = string
}

variable "subnet_prefix" {
  description = "De IP-range van het subnet"
  type        = string
}

variable "custom_rules" {
  type    = list(any)
  default = [
    {
      name                       = "Allow-ICT-RDP"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "172.28.0.0/24"
      destination_address_prefix = "10.21.0.0/26"
    },
    {
      name                       = "Allow-HTTP-Out"
      priority                   = 150
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "Internet"
    },
    {
      name                       = "Allow-HTTPS-Out"
      priority                   = 151
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "Internet"
    },
    {
      name                       = "Block-Student"
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "172.22.0.0/22"
      destination_address_prefix = "10.21.0.0/26"
    },
    {
      name                       = "Isolate-PLC"
      priority                   = 250
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "192.168.200.0/28"
    },
    {
      name                       = "Allow-DNS"
      priority                   = 300
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Udp"
      source_port_range          = "*"
      destination_port_range     = "53"
      source_address_prefix      = "*"
      destination_address_prefix = "Sql" 
    },
    {
      name                       = "Deny-All-In"
      priority                   = 4096 
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}