variable "subnet" {
  type        = bool
  default     = true
  description = "Boolean to determine if subnets should be created"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}
variable "private_subnets_cidr" {
  type        = list(any)
  description = "List of CIDR blocks for private subnets"
  default     = ["172.31.0.0/19", "172.31.32.0/19", "172.31.64.0/19", "172.31.96.0/19"]
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "List of CIDR blocks for public subnets"
  default     = ["172.31.128.0/18", "172.31.192.0/18"]
}

variable "users" {
  type        = bool
  default     = true
  description = "Boolean to determine if users should be created"
}
