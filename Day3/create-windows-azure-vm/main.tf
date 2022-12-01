resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name = "${var.resource_group_name_prefix}_resource_group"
}

resource "azurerm_virtual_network" "my_virtual_network" {
  name = "my-virtual-network"
  address_space = [ "10.0.0.0/16" ]
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "my_subnet" {
  name = "my-subnet"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.my_virtual_network.name
  address_prefixes = [ "10.0.1.0/24" ]
}

resource "azurerm_public_ip" "vm_public_ip" {
    name = "vm-public-ip"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    allocation_method = "Dynamic"
}

resource "azurerm_network_security_group" "vm-firewall" {
  name = "vm-firewall"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name = "AllowRDP"
    priority = "1001"
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "3389"    
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name = "AllowICMP"
    priority = "1002"
    direction = "Inbound"
    access = "Allow"
    protocol = "Icmp"
    source_port_range = "*"
    destination_port_range = "*"    
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name = "AllowHttp"
    priority = "1003"
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "80"    
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_network_interface" "network_card" {
  name = "network-card"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name = "network-card-configuration"
    subnet_id = azurerm_subnet.my_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.vm_public_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "apply_firewall_rules_on_network_card" {
    network_interface_id = azurerm_network_interface.network_card.id
    network_security_group_id = azurerm_network_security_group.vm-firewall.id
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  name = "windows-vm"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  network_interface_ids = [ azurerm_network_interface.network_card.id ]
  size = "Standard_DS1_v2"
 
  os_disk {
    name = "my-hard-disk"
    caching = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer = "WindowsServer"
    sku = "2016-DataCenter"
    version = "latest"
  }

  computer_name = "myvm"
  admin_username = "azureuser"
  admin_password = "password@12345"
}
