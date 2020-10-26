provider "aws" {
  region = "us-east-2"
}

module "vpc" {
  source = "./modules/vpc"

  environment = var.environment
  CIDR_Block = var.CIDR_Block
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  public_availability_zones = var.public_availability_zones
  private_availability_zones = var.private_availability_zones 
}

variable "environment" {}
variable "CIDR_Block" {}
variable "public_subnets" {}
variable "private_subnets" {}
variable "public_availability_zones" {}
variable "private_availability_zones" {}
