terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.33.0"
    }

    tls = {
      source = "hashicorp/tls"
      version = "4.0.4"
    }
  }
}

provider "azurerm" {
   features {}
}

variable "private_key_path" {
    type = string
    default = "./key.pem"
}

data "azurerm_resource_group" "rg" {
    name = "tektutor-rg" 
}

data "azurerm_virtual_machine" "vm" {
    count = 3
    name = "my_ubuntu_vm-${count.index}"
    resource_group_name = "tektutor-rg" 
}

resource "null_resource" "install-nginx_on_vms" {
    count = 3
    connection {
      type = "ssh"
      user = "azureuser"
      private_key = file(var.private_key_path)
      host =  data.azurerm_virtual_machine.vm[count.index].public_ip_address
      agent = false
    }

    provisioner "remote-exec" {
        inline = [
            "sudo apt update",
            "sudo apt install -y nginx"
        ]
    }
}

data "azurerm_virtual_network" "existing_virtual_network" {
  name                = "my-virtual-net"
  resource_group_name = "tektutor-rg"
}

resource "azurerm_public_ip" "lb_public_ip" {
    name = "PublicIPForLB"
    
    location = data.azurerm_resource_group.rg.location
    resource_group_name = data.azurerm_resource_group.rg.name

    allocation_method = "Static"
    sku = "Standard"
}

resource "azurerm_lb" "my_lb" {
    name = "MyLoadBalancer"
    sku  = "Standard"
    sku_tier = "Regional"

    location = data.azurerm_resource_group.rg.location
    resource_group_name = data.azurerm_resource_group.rg.name

    frontend_ip_configuration {
        name = "PublicIPAddress"
        public_ip_address_id = azurerm_public_ip.lb_public_ip.id 
    }
}

resource "azurerm_lb_backend_address_pool" "lb_backend" {
    name = "LBBackendAddressPool"
    loadbalancer_id = azurerm_lb.my_lb.id
}

resource "azurerm_lb_backend_address_pool_address" "vms" {
  count = 3
  name                    = "add-vm-${count.index}-to-lb-pool"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend.id
  virtual_network_id      = data.azurerm_virtual_network.existing_virtual_network.id
  ip_address              = data.azurerm_virtual_machine.vm[count.index].private_ip_address
}

resource "azurerm_lb_rule" "rule_for_forwarding_lb_port_80_traffic_to_backend_vms" {
  loadbalancer_id = azurerm_lb.my_lb.id
  name = "LBRule"
  backend_address_pool_ids = [ azurerm_lb_backend_address_pool.lb_backend.id ]
  protocol = "Tcp"
  frontend_port = 80
  backend_port = 80
  frontend_ip_configuration_name = "PublicIPAddress"
}
