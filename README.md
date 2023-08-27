# Makefile
Make modularize Terraform here in a way, that each element (=folder) is it's own tf root module.  
Make expects following vars:
* ELEMENT - folder name
* REGION - AWS region, defaults to us-east-1
* TARGETS - if you want to run tf commands with target, space separated  

Example usage:
```
ELEMENT=count_index make init
ELEMENT=count_index make plan
ELEMENT=count_index make apply

#change region
ELEMENT=count_index REGION=us-west-2 make plan

#use multiple targets
ELEMENT=count_index TARGETS="aws_subnet.public_subnets aws_subnet.private_subnets" make plan
```