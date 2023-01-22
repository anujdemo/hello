provider "azurerm" {
  version = "=2.40.0"
  features {}
  
}

resource "azurerm_resource_group" "example" {
  name     = "my-rg"
  location = "East US"
}

resource "azurerm_virtual_network" "example" {
  name                = "my-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "my-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefix       = "10.0.1.0/24"
}

resource "azurerm_network_interface" "example" {
  name                = "my-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                 = "my"
    subnet_id            = azurerm_subnet.example.id
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_virtual_machine" "example" {
  name                  = "my-vm"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  vm_size               = "Standard_DS1_v2"
  network_interface_ids = [azurerm_network_interface.example.id]

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "my-os-disk"
    create_option     = "FromImage"
  }
  
  os_profile {
    computer_name  = "my-vm"
    admin_username = "adminuser"
    admin_password = "admin1234567"
  }
  
  os_profile_linux_config {
    disable_password_authentication = false
  }
}
