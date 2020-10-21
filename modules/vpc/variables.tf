
variable "environment" {
  type = string
  description = "Name of the environment for tags"
}

variable "CIDR_Block" {
  type = string
  description = "CIDR Block definition for new VPC"
}

variable "public_subnets" {
  type = list
  description = "List of cidrs for each public subnet to be declared on the VPC"
}

variable "private_subnets" {
  type = list
  description = "List of cidrs for each private subnet to be declared on the VPC"
}

variable "public_availability_zones" {
  type = list
  description = "List of availability zones for public subnets."
}

variable "private_availability_zones" {
  type = list
  description = "List of availability zones for private subnets."
}
