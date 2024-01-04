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

# resource "aws_instance" "app_server" {
#   ami           = "ami-03caf91bb3d81b843"
#   instance_type = "t2.micro"
#   subnet_id = "subnet-030f2231dd5a1ff22"

#   tags = {
#     Name = var.instance_name
#   }
# }

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

resource "aws_subnet" "subnet_private" {
  count = length(var.subnet_private_cidr)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.subnet_private_cidr, count.index)
  availability_zone = element(var.availability_zone, count.index)
  tags = {
    Name = "Private Subnet ${count.index + 1}"
  }
}