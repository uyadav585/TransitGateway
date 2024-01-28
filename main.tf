terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./vpc"

}

module "subnet" {
  source          = "./subnets"
  vpc_cidr_blocks = module.vpc.cidr_blocks
  vpc-id          = module.vpc.vpc-id

}

module "gateway" {
  source = "./internet-gateway"
  vpc_id = module.vpc.vpc-id
}

module "route" {
  source             = "./route-table"
  vpc_id             = module.vpc.vpc-id
  gateway_id         = module.gateway.gateway-id
  subnet_ids         = module.subnet.subnet-id
  transit_gateway-id = module.transit.transit-id
  current_subnet-id = module.subnet.current-subnet-id
}

module "security_group" {
  source = "./security-group"
  vpc_id = module.vpc.vpc-id
}

module "instance" {
  source             = "./ec2-instance"
  subnet_id          = module.subnet.subnet-id
  security_group_ids = module.security_group.security_group_ids
}

module "transit" {
  source     = "./transit-gateway"
  vpc_id     = module.vpc.vpc-id
  subnet_ids = module.subnet.subnet-id
}