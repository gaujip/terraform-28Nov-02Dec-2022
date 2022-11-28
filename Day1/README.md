# Day 1

## What is Virtualization?
- aka Hypervisors - general terms that is used in industry to refer virtualization technology/software
- We would be able to run multiple Operating System on the same Desktop/Laptop/Workstation/Server
- Many OS can be active at the same time
- helps in consolidating many phsyical servers into a less number of physical server
- Hardware requirements
  - 
  - Processors with many CPU cores
  - x86_64 bit Generatl Purpose Processors
    - Intel Virtualization Feature
      - VT-X
      - HyperThreading
        - a single physical core is seen as 2 virtual cores by your virtualization software
        - a single physical core supports 4 virtual cores
        - a single physical core can even support 8 virtual cores
        
    - AMD Virtualization Feature
      - AMD-V
      - Simultaneous Multiple Threads
        - a single physical core can supports 2,4,6,8 virtual core
  - RAM
  - Storage 
- virtualization is heavy-weight technology
  - each Virtual Machine(Guest OS) requires dedicated hardware resources
  - CPU, RAM and storage
- Virtual Machines
  - OS installed is a fully function operating system
  - it can be Windows/Linux/Mac ,etc.,
  - each VM represents one fully functiona Operating System
  - each OS installed in a VM has its own hardware resources and a dedicated OS Kernel
  
## Container Technology
- it is an application virtualization technology
- it is a lightweight virtualization
- containers don't get their dedicated hardware resources
- containers are application process not an Operating System
- containers don't have their own OS kernel
- each container represents one application(process)

## What are the common characteristics of Virtual Machine and a Container?
- both get their own file system
- both get their own Network Stack
- both get their own IP address
- both get their own hostname
- both get their own Network Card(s)
- both get their own Ports ( 0 - 65535 )

## What is datacenter?
- group of servers co-located in single region
- in a single region, there could be multiple availability zone for High Availability

## What is Cloud Computing?
- on demand, we can create a Virtual machine with any kind of configuration
  - we can choose the number of CPU cores
  - amount of RAM
  - amount of storage and type of storage, etc.,
  - even we could choose the Internet bandwith, etc.,
- we just need to pay for the amount of time we used the cloud infrastructure
- storage service

## Types of Cloud Computing Services?
Infrastructure as a Service ( IaaS )
- We can rent Compute Resource ( HW, Storage and Internet ) 
- we just to pay as a you go
- we need to use our own licensed Operating Systems

Platform as a Service ( PaaS )
- Cloud vendor provides Hardware + OS(licensed/open source - depending on your need )
- On top of the Platform you could install your own software, so you need have license for the softwares your are installing on top of the platform ( Oracle DB Server ) 

Software as a Service ( SaaS )
- Cloud vendor provides Hardware + OS(licensed/opensource) + Software ( Oracle DB, Weblogic, etc., ) 

## Types of Cloud
1. Public cloud ( AWS, Azure, Gcp, Digital Ocean, etc., )
2. Private cloud ( Datacenters owned and maitained by your organization )
3. Hybrid cloud ( Private and Public Cloud )

## What is Infrastructure as a Code Tool?
- Example
  - Terraform , Cloudformation Ansible, Puppet, Chef
- they help in automating the infrastructure (Virtual Machine, software installation/configuration etc., )

## What is Configuration Management Tool?
- Helps in automating software installation and configuration on an existing Virtual Machine or an Operating System either locally or on cloud
- Examples
  - Ansible, Puppet, Chef and Salt(Saltstack)

## What is Container Orchestration Platform?
Examples
- Docker SWARM
- Google Kubernetes
- Red Hat OpenShift
- helping in managing your microservices or any containerized application
- provides an environment which helps in making your application Highly Available(HA)
- supports built-in loadbalancing, service discovery, scale up/down, rolling updates, monitoring 

## What is a Provisioner tool?
- Examples
  - Terraform, Cloudformation Docker, Vagrant, etc.,
- Helps in creating a Virtual Machine, Container onPrem or on cloud with specific OS with some hardware configuration

## What is Cloudformation?
- a Infrastructur as a Code from AWS
- it can manage only AWS cloud infrastructure
- doesn't support other cloud infrastruce like Azure, GCP, digital ocean

## What is Terraform ?
- Provisional tool
- Idempotency on the infrastructure provisioning is supported
   - desired state of virtual machine and actual state of virtual machine matches then Terraform will do nothing
   - desired state of virtual machine and actual state of virtual machine is different
- Terraform allow installation softwares on new infrastructure after provisioning is done
- idempotency is not supported on the configurationmanagement

## What is Ansible ?
- Configuration Management Tool

## What is Vagrant?
- Virtual Machine Management software
- it helps in declaratively creating and managing virtual machines using virtualbox, vmware hypervisors, etc.,

## Installing software required for our training
```
sudo su -
apt update
apt install -y git vim azure-cli docker.io
```
When prompts for password, type 'rps@12345' without quotes

Verify if azure commandline tool is installation
```
az --version
```

Expected output
<pre>
root@ubuntu:~# <b>az version</b>
This command is in preview. It may be changed/removed in a future release.
{
  "azure-cli": "2.0.81",
  "azure-cli-core": "2.0.81",
  "azure-cli-telemetry": "1.0.4",
  "extensions": {
    "azure-devops": "0.17.0"
  }
}
</pre>


Verify the git version
```
git --version
```

Expected output
<pre>
root@ubuntu:~# <b>git --version</b>
git version 2.25.1
</pre>

Verify the docker version installed
```
docker --version
sudo usermod -aG docker $USER
sudo su $USER
docker images
```

Expected output
<pre>
root@ubuntu:~# <b>docker --version</b>
Docker version 20.10.12, build 20.10.12-0ubuntu2~20.04.1

jegan@ubuntu:~/Desktop$ docker images
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/images/json": dial unix /var/run/docker.sock: connect: permission denied
jegan@ubuntu:~/Desktop$ <b>sudo usermod -aG docker $USER</b>
[sudo] password for jegan: 
jegan@ubuntu:~/Desktop$ <b>sudo su $USER</b>
jegan@ubuntu:~/Desktop$ <b>docker images</b>
REPOSITORY   TAG       IMAGE ID   CREATED   SIZE
</pre>

#### Troubleshooting azure cli installation
```
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```
For more details instructions, refer the below instructions
<pre>
https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt
</pre>


#### Troubleshooting Docker installation
```
sudo apt-get update

sudo apt-get install ca-certificates curl gnupg lsb-release

sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo usermod -aG docker $USER
sudo su $USER
docker images
```

## Installing Terraform CLI tool
```
sudo snap install terraform --classic
```

Expected output
<pre>
jegan@ubuntu:~/terraform-28nov-02dec-2022/Day1/lab1$ <b>sudo snap install terraform --classic</b>
terraform 1.3.5 from Jon Seager (jnsgruk) installed
</pre>

## Cloning TekTutor GitHub Repository ( Do this only the first time )
```
cd ~
git clone https://github.com/tektutor/terraform-28nov-02dec-2022.git
cd terraform-28nov-02dec-2022
```

## Each time I push new code, you need to pull it ( download only delta changes )
```
cd ~/terraform-28nov-02dec-2022
git pull
```

## Lab - Running your first terraform automation script
```
cd ~/terraform-28nov-02dec-2022
git pull

cd Day1/lab1
terraform init
```

Expected output
<pre>
jegan@ubuntu:~/terraform-28nov-02dec-2022/Day1/lab1$ terraform init

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of kreuzwerker/docker from the dependency lock file
- Installing kreuzwerker/docker v2.23.0...
- Installed kreuzwerker/docker v2.23.0 (self-signed, key ID BD080C4571C6104C)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/cli/plugins/signing.html

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
</pre>

Checking your .terraform folder, the folder where Terraform installs the provider plugins
```
cd ~/terraform-28nov-02dec-2022
tree .terraform
```

Expected output
<pre>
jegan@ubuntu:~/terraform-28nov-02dec-2022/Day1/lab1$ <b>tree .terraform</b>
.terraform
└── providers
    └── registry.terraform.io
        └── kreuzwerker
            └── docker
                └── 2.23.0
                    └── linux_amd64
                        ├── CHANGELOG.md
                        ├── LICENSE
                        ├── README.md
                        └── terraform-provider-docker_v2.23.0

6 directories, 4 files
</pre>

The below file, captures the actual version of providers installed on your system when you performed init
<pre>
jegan@ubuntu:~/terraform-28nov-02dec-2022/Day1/lab1$ <b>cat .terraform.lock.hcl</b>
# This file is maintained automatically by "terraform init".
# Manual edits may be lost in future updates.

provider "registry.terraform.io/kreuzwerker/docker" {
  version     = "2.23.0"
  constraints = "2.23.0"
  hashes = [
    "h1:3ZAbErged+Ar3C4UM910OuHmKaejjKfqM0LimMpBlus=",
    "zh:2fbaa690bcd78a4910ed1412188238e5e169661eff37b926995e14e1538f765e",
    "zh:3abcb671353d1c9f410130f7cce5e7e8035f25daa9930592bb256647608d5694",
    "zh:46002585456bb38411e0ecdd51008f5feedd3a43b8d9f00476b4789f1b5099cf",
    "zh:49c95dc07e6c4e97057bb0f141ec000a9a5f9f62c60f10e2605dba67dbe9bebe",
    "zh:675878d3412f94731e1d4aff41ada6375868b98f900a676fd3865d409d269600",
    "zh:6d686e307821e56421eb2e0dea7185e1cd1c2d1b1bf28b8b62f7f7c90b2f60ce",
    "zh:7111bf50a05d90d67dc80b086c0c86007bc4d1de9d6f5bce7cc7a0c3e6101469",
    "zh:712129dcce12f023752a94c7ec8781989a6082b79c4cb5e70e0062b916aab520",
    "zh:9ed24917159a6152c45f1dea178c72a2386e60ce0f94af9621ed8db608c227c5",
    "zh:c04af6c345d053ed86e612509eb217c1ef0c60af4d05abe1d1aa5a71da108b76",
    "zh:d272d8277a48e979c1bf5f45f19962325879627279b14fd1d1984940bfe3bd9c",
    "zh:d506cdd540a296c9bbbbc27a962e75906606facea7ab9d5c3ef302d3f7043d89",
    "zh:f82237626d473151f9787dc4a789235236a1929334c8aabe5b58d12b09b76155",
    "zh:f96379bdc00f757c0c8e7108ac54bc3b0385224b70699396cbd6cbff88a326a4",
  ]
}
</pre>

## Print the terraform plan
```
terraform plan
```

Expected output
<pre>
jegan@ubuntu:~/terraform-28nov-02dec-2022/Day1/lab1$ <b>terraform plan</b>

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # docker_container.nginx will be created
  + resource "docker_container" "nginx" {
      + attach                                      = false
      + bridge                                      = (known after apply)
      + command                                     = (known after apply)
      + container_logs                              = (known after apply)
      + container_read_refresh_timeout_milliseconds = 15000
      + entrypoint                                  = (known after apply)
      + env                                         = (known after apply)
      + exit_code                                   = (known after apply)
      + gateway                                     = (known after apply)
      + hostname                                    = (known after apply)
      + id                                          = (known after apply)
      + image                                       = (known after apply)
      + init                                        = (known after apply)
      + ip_address                                  = (known after apply)
      + ip_prefix_length                            = (known after apply)
      + ipc_mode                                    = (known after apply)
      + log_driver                                  = (known after apply)
      + logs                                        = false
      + must_run                                    = true
      + name                                        = "my-nginx-container"
      + network_data                                = (known after apply)
      + read_only                                   = false
      + remove_volumes                              = true
      + restart                                     = "no"
      + rm                                          = false
      + runtime                                     = (known after apply)
      + security_opts                               = (known after apply)
      + shm_size                                    = (known after apply)
      + start                                       = true
      + stdin_open                                  = false
      + stop_signal                                 = (known after apply)
      + stop_timeout                                = (known after apply)
      + tty                                         = false
      + wait                                        = false
      + wait_timeout                                = 60

      + healthcheck {
          + interval     = (known after apply)
          + retries      = (known after apply)
          + start_period = (known after apply)
          + test         = (known after apply)
          + timeout      = (known after apply)
        }

      + labels {
          + label = (known after apply)
          + value = (known after apply)
        }

      + ports {
          + external = 9090
          + internal = 8080
          + ip       = "0.0.0.0"
          + protocol = "tcp"
        }
    }

  # docker_image.nginx will be created
  + resource "docker_image" "nginx" {
      + id           = (known after apply)
      + image_id     = (known after apply)
      + keep_locally = false
      + latest       = (known after apply)
      + name         = "bitnami/nginx:latest"
      + output       = (known after apply)
      + repo_digest  = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions
if you run "terraform apply" now.
</pre>

## Storing the plan in a file
```
terraform plan -out main.tfplan
```

Expected output
<pre>
jegan@ubuntu:~/terraform-28nov-02dec-2022/Day1/lab1$ terraform plan -out main.tfplan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with
the following symbols:
  + create

Terraform will perform the following actions:

  # docker_container.nginx will be created
  + resource "docker_container" "nginx" {
      + attach                                      = false
      + bridge                                      = (known after apply)
      + command                                     = (known after apply)
      + container_logs                              = (known after apply)
      + container_read_refresh_timeout_milliseconds = 15000
      + entrypoint                                  = (known after apply)
      + env                                         = (known after apply)
      + exit_code                                   = (known after apply)
      + gateway                                     = (known after apply)
      + hostname                                    = (known after apply)
      + id                                          = (known after apply)
      + image                                       = (known after apply)
      + init                                        = (known after apply)
      + ip_address                                  = (known after apply)
      + ip_prefix_length                            = (known after apply)
      + ipc_mode                                    = (known after apply)
      + log_driver                                  = (known after apply)
      + logs                                        = false
      + must_run                                    = true
      + name                                        = "my-nginx-container"
      + network_data                                = (known after apply)
      + read_only                                   = false
      + remove_volumes                              = true
      + restart                                     = "no"
      + rm                                          = false
      + runtime                                     = (known after apply)
      + security_opts                               = (known after apply)
      + shm_size                                    = (known after apply)
      + start                                       = true
      + stdin_open                                  = false
      + stop_signal                                 = (known after apply)
      + stop_timeout                                = (known after apply)
      + tty                                         = false
      + wait                                        = false
      + wait_timeout                                = 60

      + healthcheck {
          + interval     = (known after apply)
          + retries      = (known after apply)
          + start_period = (known after apply)
          + test         = (known after apply)
          + timeout      = (known after apply)
        }

      + labels {
          + label = (known after apply)
          + value = (known after apply)
        }

      + ports {
          + external = 9090
          + internal = 8080
          + ip       = "0.0.0.0"
          + protocol = "tcp"
        }
    }

  # docker_image.nginx will be created
  + resource "docker_image" "nginx" {
      + id           = (known after apply)
      + image_id     = (known after apply)
      + keep_locally = false
      + latest       = (known after apply)
      + name         = "bitnami/nginx:latest"
      + output       = (known after apply)
      + repo_digest  = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Saved the plan to: main.tfplan

To perform exactly these actions, run the following command to apply:
    terraform apply "main.tfplan"
</pre>

## Runing the Terraform script using apply
```
terraform apply main.tfplan
```

Expected output
<pre>
jegan@ubuntu:~/terraform-28nov-02dec-2022/Day1/lab1$ <b>terraform apply main.tfplan</b>
docker_image.nginx: Creating...
docker_image.nginx: Still creating... [10s elapsed]
docker_image.nginx: Creation complete after 10s [id=sha256:cd1781e1833b8a4d89656f52ffd2c0e8960976b38a14dced17fee90f1ab1fd35bitnami/nginx:latest]
docker_container.nginx: Creating...
docker_container.nginx: Creation complete after 1s [id=d2bc19740e095f14c3e478e67696005198d6991118ff4a98a3b2bbda36652155]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
</pre>

## Using your Azure Pass
<pre>
https://www.microsoftazurepass.com/Home/HowTo?Length=5
</pre>
