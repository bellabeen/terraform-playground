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

resource "aws_instance" "app_server" {
  ami           = "ami-03caf91bb3d81b843"
  instance_type = "t2.micro"
  subnet_id = "subnet-030f2231dd5a1ff22"

  tags = {
    Name = var.instance_name
  }
}
