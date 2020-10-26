provider "aws" {
  region = "us-east-2"
}

## VPC Definition
resource "aws_vpc" "vpc" {
  cidr_block       = var.CIDR_Block
  instance_tenancy = "default"
  enable_dns_support = true

  tags = {
    Name = "${var.environment}-vpc"
  }
}

## Subnets
resource "aws_subnet" "public_subnets" {
  count      = length(var.public_subnets)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnets[count.index]
  
  tags = {
    Name = "${var.environment}-public-subnet${count.index}"
  }
}

resource "aws_subnet" "private_subnets" {
  count      = length(var.private_subnets)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnets[count.index]
  
  tags = {
    Name = "${var.environment}-private-subnet${count.index}"
  }
}

## Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-igw"
  }
}

## Create Nat Gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id = aws_subnet.public_subnets[0].id

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "${var.environment}-ngw"
  }
}

resource "aws_eip" "eip" {
  vpc = true
  
  tags = {
    Name = "${var.environment}-eip"
  }
}


# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-public-rt"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)

  subnet_id = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public.id
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-private-rt"
  }
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)

  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private.id
}