# read other remote state
data "terraform_remote_state" "subnets" {
  backend = "s3"
  config = {
    bucket         = "vlad-sanyuk-tfstate-bucket-dev"
    key            = "terraform/count-index.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "state_lock"
  }
}

locals {
  subnets_ids = [for subnet in data.terraform_remote_state.subnets.outputs.private_subnets[0] : subnet.id]
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id     = local.subnets_ids[0]

  tags = {
    Name = "HelloWorld"
  }
}
