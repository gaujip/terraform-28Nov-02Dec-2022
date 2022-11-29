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

## ⛹️‍♂️ Lab - Understanding count loop
```
cd ~/terraform-28Nov-02Dec-2022
git pull
cd Day2/loops

terraform init
terraform apply --auto-approve
```


## Lab - Installing nginx web server on the Azure VM created manually
```
sudo apt update && sudo apt install -y nginx
curl localhost
```

Expected output
```
azureuser@ubuntu-vm:~$ <b>curl localhost</b>
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```
