variable "resource_group_location" {
    description = "Location of resource group"
    default = "eastus"
}

variable "vm_count" {
   type = number
/*
   description = "The number of Virtual machines you wish to create in your Azure portal"

   validation {
        condition  = var.vm_count > 1 && var.vm_count <= 5
        error_message = "The vm_count should be greater 0 must be less than or equal to 5."
   }
*/
}
