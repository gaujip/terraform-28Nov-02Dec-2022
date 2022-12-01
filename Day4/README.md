# Day4

## Terragrunt 
- Terragrunt is a wrapper tool for Terraform, that adds many additional features on top of Terraform
- You can still use the below commands and terraform scripts as it is
  terragrunt init
  terragrunt validate
  terragrunt apply
  terragrunt destroy
- Terragrunt support retry from errors, etc.,
- You can explore more about this tool here https://terragrunt.gruntwork.io/

## Ansible
- Configuration management tool
- comes in two flavors
  1. Ansible Core - opensource and CLI
  2. Red Hat Ansible Tower - Webconsole, you will get support from Red Hat(an IBM company)
- it uses an inventory file that has connection details to the Ansible nodes to automate software installation and/or configurations
- Ansible Nodes are the server where you wish to install softwares via Ansible
- is developed in Python by Michael Deehan as an opensource project
- Michael Deehan is the founder of Ansible Inc
- there are two types of inventory file
  1. Static - is manually created/updated
  2. Dynamic ( can be a python script )
- The Domain Specific Language(DSL) used by Ansible is YAML (Yet Another Markup Language)
- YAML is a superset of JSON ( JavaScript Object Notation )
- Ansible Controller Machine (ACM)
  - this is the machine where Ansible is installed
  - Ansible can only be installed in Linux/Mac/Unix
  - ACM can be never be a Windows machine
  - however Ansible can manage Unix/Linux/Mac/Windows Nodes
  - is the machine where you run the Ansible Playbook 
- Software requirements on Unix/Linux/Mac Ansible Nodes
  1. SSH Server should be installed
  2. Python should be installed
- Software requirements on Windows Ansible Nodes
  1. WinRM should be enabled
  2. PowerShell (.Net Framework )
- Ansible Playbooks are YAML file
- which is declarative

## Forcing resource recreate in Terraform
```
terraform apply -replace=local_file.invoke_ansible_playbook --auto-approve
```

