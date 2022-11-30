resource "azurerm_resource_group" "rg" {
    location = var.resource_group_location
    name = "tektutor-resource-group" 
}

resource "azurerm_virtual_network" "my_virtual_network" {
    location = var.resource_group_location
    resource_group_name = azurerm_resource_group.rg.name

    name = "my-virtual-net"
    address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "my_subnet" {
    resource_group_name = azurerm_resource_group.rg.name

    name = "my_subnet"
    virtual_network_name = azurerm_virtual_network.my_virtual_network.name
    address_prefixes = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "my_public_ip" {
    location = var.resource_group_location
    resource_group_name = azurerm_resource_group.rg.name

    count = var.vm_count
    name = "my_public_ip-${count.index}"

    allocation_method = "Dynamic"
}

resource "azurerm_network_security_group" "my_nsg" {
    location = var.resource_group_location
    resource_group_name = azurerm_resource_group.rg.name

    count = var.vm_count
    name = "my_nsg-${count.index}"

    security_rule {
        name ="AllowSSH"
        priority = "1001"
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "22"
        source_address_prefix = "*"
        destination_address_prefix = "*"
    }
    security_rule {
        name ="AllowICMP"
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
        name ="AllowHttp"
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

resource "azurerm_network_interface" "my_nic" {
    count = var.vm_count
    name = "my_nic-${count.index}"

    location = var.resource_group_location
    resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
        name = "my_nic_configuration"
        subnet_id = azurerm_subnet.my_subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = azurerm_public_ip.my_public_ip[count.index].id 
    }
}

resource "azurerm_network_interface_security_group_association" "nic_nsg_connector" {
    count = var.vm_count
    
    network_interface_id = azurerm_network_interface.my_nic[count.index].id
    network_security_group_id = azurerm_network_security_group.my_nsg[count.index].id
}

resource "tls_private_key" "my_ssh_key" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "azurerm_linux_virtual_machine" "my_ubuntu_vm" {
    count = var.vm_count

    name = "my_ubuntu_vm-${count.index}"

    location = var.resource_group_location
    resource_group_name = azurerm_resource_group.rg.name

    network_interface_ids = [ azurerm_network_interface.my_nic[count.index].id ]
    size = "Standard_DS1_V2"

    os_disk {
        name = "my_harddisk-${count.index}"
        caching = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer = "UbuntuServer"
        sku = "18.04-LTS"
        version = "latest"
    }

    computer_name = "myvm-${count.index}"
    admin_username = "azureuser"
    disable_password_authentication = true

    admin_ssh_key {
        username = "azureuser"
        public_key = tls_private_key.my_ssh_key.public_key_openssh 
    }
}
