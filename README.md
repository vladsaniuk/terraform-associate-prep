# Makefile
Make modularize Terraform here in a way, that each ELEMENT (=folder) is it's own tf root module.  
Make expects following vars:
* ELEMENT - folder name
* ENV - env name: dev | stage | prod
* REGION - AWS region, defaults to us-east-1
* TARGETS - if you want to run tf commands with target, space separated  

Minimal requirments for make to work is that \${ENV}.tfvars and backend.hcl should exist in \${ELEMENT}/envs/${ENV}  
For remote_state to work count_index must be deployed first.  
For import_generate_config you need to manually create SG and put it's ID into import block.  
Example usage:
```
ELEMENT=count_index make init
ELEMENT=count_index make plan
ELEMENT=count_index make apply

# change region
ELEMENT=count_index REGION=us-west-2 make plan

# use multiple targets
ELEMENT=count_index TARGETS="aws_subnet.public_subnets aws_subnet.private_subnets" make plan

# destroy should be done via plan first
ENV=dev ELEMENT=count_index make destroy-plan
ENV=dev ELEMENT=count_index make destroy
```