terraform {
  backend "s3" {}
  required_providers  {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.65.0"
    }
  }
}

provider "aws" {
  region  = var.region
}

variable "region" {
  type = string
  description = "AWS region"
  default = "us-east-1"
}