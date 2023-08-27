variable "subnet" {
  type = bool
  default = true
}

data "aws_vpc" "vpc" {
  default = true
}

# append index to resource name
resource "aws_subnet" "public_subnets" {
  count = var.subnet ? 3 : 0
  cidr_block        = "172.32.0.0/28"
  vpc_id            = data.aws_vpc.vpc.id
  tags              = tomap(merge({ Name = "subnet-${count.index}" }))
}

# append index as semantic names
locals {
  subnet_names = ["dev", "prod"]
}

resource "aws_subnet" "private_subnets" {
  count = var.subnet ? 2 : 0
  cidr_block        = "172.32.0.0/28"
  vpc_id            = data.aws_vpc.vpc.id
  tags              = tomap(merge({ Name = "subnet-${local.subnet_names[count.index]}" }))
}