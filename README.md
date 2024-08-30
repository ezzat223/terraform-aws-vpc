# terraform aws_vpc

## Overview

This Terraform module creates an AWS VPC with a given CIDR block. It also creates multiple subnets (public and private), and for public subnets, it sets up an IGW and appropriate route table.

## Features

- Creates a VPC with a specified CIDR block.
- Creates Public and Private subnets.
- Creates an IGW for Public subnets.
- Sets up route tables for public subnets.

## Usage
```
module "vpc" {
  source = "./modules/vpc"

  vpc_config = {
    cidr_block = "CIDR of your vpc"
    name       = "your-vpc-name"
  }
}

module "subnet" {
  source = "./modules/subnets"
  vpc_id = module.vpc.vpc_id

  subnet_config = {
    public_subnet_name = {
      cidr_block = "CIDR of your subnet"
      az         = "az-name"
      # to set the subnet as public (default is privaate)
      public = true
    },
    private_subnet_name = {
      cidr_block = "CIDR of your subnet"
      az         = "az-name"
    }
  }
}

module "igw" {
  source = "./modules/networking"
  vpc_id = module.vpc.vpc_id
  subnet_config = module.subnet.subnet_config
  subnets = module.subnet.subnets
}

```