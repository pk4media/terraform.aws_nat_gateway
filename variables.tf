variable "name" {
  default     = "nat"
  description = "NAT name"
}

variable "environment" {
  default     = "development"
  description = "Environment (development, staging, production)"
}

variable "public_subnets" {
  description = "The CIDR blocks of the public Subnets"
}

variable "subnet_ids" {
  description = "The IDs of the public Subnets"
}
