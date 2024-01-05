# environments/dev/main.tf

provider "aws" {
  region = "ap-southeast-1"
}

module "vpc" {
  source = "../../modules/vpc"
}

module "subnet" {
  source = "../../modules/subnet"
}

module "nat_gateway" {
  source = "../../modules/nat_gateway"
  # Add module-specific variables if needed
  # Example: subnet_ids = module.subnet.subnet_ids
}