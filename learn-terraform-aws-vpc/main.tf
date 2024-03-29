terraform {
    cloud {
        organization = "kedaiit-org"

        workspaces {
        name = "learn-tfc-aws"
        }
    }
    
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_vpc" "main" {
  cidr_block = "20.0.0.0/16"

  tags = {
    Name = "Terraform VPC test"
  } 
}

resource "aws_subnet" "subnet_public" {
  count = length(var.subnet_public_cidr)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.subnet_public_cidr, count.index)
  availability_zone = element(var.availability_zone, count.index)
  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id
  tags   = {
    Name = "default igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "public_subnet_asso" {
  count          = length(var.subnet_public_cidr)
  subnet_id      = element(aws_subnet.subnet_public[*].id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_subnet" "subnet_private" {
  count            = length(var.subnet_private_cidr)
  vpc_id           = aws_vpc.main.id
  cidr_block       = element(var.subnet_private_cidr, count.index)
  availability_zone = element(var.availability_zone, count.index)
  tags = {
    Name = "Private Subnet ${count.index + 1}"
  }
}

resource "aws_route_table" "private_rt" {
  count = length(var.subnet_private_cidr)
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Private Route Table ${count.index + 1}"
  }
}

resource "aws_route_table_association" "private_subnet_asso" {
  count          = length(var.subnet_private_cidr)
  subnet_id      = aws_subnet.subnet_private[count.index].id
  route_table_id = aws_route_table.private_rt[count.index].id
}