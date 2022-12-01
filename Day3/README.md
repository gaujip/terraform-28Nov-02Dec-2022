# Day 3

## Lab - Importing existing azure resources into Terraform
```
terraform import azurerm_linux_virtual_machine.vm1 /subscriptions/6ee542a8-0314-472f-a628-625cfbfcc778/resourceGroups/tektutor-rg/providers/Microsoft.Compute/virtualMachines/my_ubuntu_vm-0
```

Expected output
<pre>
(jegan@tektutor.org)$ <b>terraform import azurerm_linux_virtual_machine.vm1 /subscriptions/6ee542a8-0314-472f-a628-625cfbfcc778/resourceGroups/tektutor-rg/providers/Microsoft.Compute/virtualMachines/my_ubuntu_vm-0</b>
azurerm_linux_virtual_machine.vm1: Importing from ID "/subscriptions/6ee542a8-0314-472f-a628-625cfbfcc778/resourceGroups/tektutor-rg/providers/Microsoft.Compute/virtualMachines/my_ubuntu_vm-0"...
azurerm_linux_virtual_machine.vm1: Import prepared!
  Prepared azurerm_linux_virtual_machine for import
azurerm_linux_virtual_machine.vm1: Refreshing state... [id=/subscriptions/6ee542a8-0314-472f-a628-625cfbfcc778/resourceGroups/tektutor-rg/providers/Microsoft.Compute/virtualMachines/my_ubuntu_vm-0]
ls
Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
</pre>
