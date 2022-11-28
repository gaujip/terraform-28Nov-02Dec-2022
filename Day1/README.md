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
