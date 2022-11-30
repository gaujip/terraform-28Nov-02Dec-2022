output "public_ip_address" {
    value = azurerm_linux_virtual_machine.my_ubuntu_vm.*.public_ip_address
}

output "ssh_key" {
    value = tls_private_key.my_ssh_key.private_key_pem
    sensitive = true
}
