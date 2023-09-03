terraform {
  required_version = ">= 1.5.6, < 2.0.0"
  backend "s3" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.15.0, < 6.0.0"
    }
  }
}

provider "aws" {
  region = var.region
}

variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}
