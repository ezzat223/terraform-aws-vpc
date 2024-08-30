module "vpc" {
  source = "./modules/vpc"

  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "my-test-vpc"
  }
}

module "subnet" {
  source = "./modules/subnets"
  vpc_id = module.vpc.vpc_id

  subnet_config = {
    public_subnet_1 = {
      cidr_block = "10.0.0.0/24"
      az         = "us-east-2a"
      public = true
    },
    public_subnet_2 = {
      cidr_block = "10.0.2.0/24"
      az         = "us-east-2a"
      public = true
    },
    private_subnet = {
      cidr_block = "10.0.1.0/24"
      az         = "us-east-2b"
    }
  }
}

module "igw" {
  source = "./modules/networking"
  vpc_id = module.vpc.vpc_id
  subnet_config = module.subnet.subnet_config
  subnets = module.subnet.subnets
}