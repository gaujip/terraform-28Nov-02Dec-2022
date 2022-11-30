module "create-azure-vms" {
  source="./create-azure-vms/"
  vm_count = var.azure_vm_count
}
