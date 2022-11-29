# Day 2

## Login to a specific azure subscription while automating infrastructure
<pre>
terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "3.33.0"
        }   
    }   
}

provider "azurerm" {
    features {}

    subscription_id = "your-azure-subscription-id"
    tenant_id = "your-azure-tenantid"
}
</pre>

You may then try 
```
terraform init
terraform apply --auto-approve
```


## In case az login isn't popping up your azure login page in a web browser, you may try this
```
az login --use-device-code
```
The above command will display the URL and a code. You may manually open the URL and submit the code displayed to login.  This might also be helpful in case you are using putty or similar terminal utility in text mode.
