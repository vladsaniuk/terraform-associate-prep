# append index to resource name
resource "aws_iam_user" "engineers" {
  count = var.users ? 2 : 0
  name  = "engineer-${count.index}"
  path  = "/engineering/"
}

# append index as semantic names
locals {
  user_names = ["Bob", "Carl"]
}
resource "aws_iam_user" "managers" {
  count = var.users ? 2 : 0
  name  = "${local.user_names[count.index]}-user"
  path  = "/management/"
}

# resources for remote state
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "public_subnets" {
  for_each   = var.subnet ? toset(var.private_subnets_cidr) : []
  cidr_block = each.value
  vpc_id     = aws_vpc.vpc.id
  tags       = tomap({ Name = "subnet-public-${each.key}" })
}

resource "aws_subnet" "private_subnets" {
  for_each   = var.subnet ? toset(var.public_subnets_cidr) : []
  cidr_block = each.value
  vpc_id     = aws_vpc.vpc.id
  tags       = tomap({ Name = "subnet-private-${each.key}" })
}
