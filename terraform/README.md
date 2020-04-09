# Terraform code to implement the aws design

Terraform version used - v0.12.12

Things to note before executing terraform commands - 

Terraform workspaces are used to isolate resources(actual resources in AWS, state files) across different environments. This also allows us to use the same config files in all environments. It is expected to set terraform workspace before running the terraform commands.

Some basic terraform workspace commands are:

Use `terraform workspace list` to list the available workspaces

Use `terraform workspace new <workspace name>` to create a new workspace and switch to that 

Use `terraform workspace select <workspace name>` to switch to a specific workspace if its already created

Use `terraform workspace show` to the current terraform workspace selected


Terraform modules are used. Every module resource like VPC, Subnet, Route Table etc. are there inside the modules directory. 


State files are maintained remotely in S3. Please change the backend S3 bucket's location in providers.tf inside individual resource directories.


Terraform workspaces supported - dev, qa, prod

Go inside individual infra directories and run terraform commands. Make sure to add or select proper terraform workspace before running terraform commands. Sequence to run the configs to setup resources - 

1. terraform/infra
2. terraform/db
3. terraform/ecs-task-definition-services
