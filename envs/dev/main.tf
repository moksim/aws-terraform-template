provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../../modules/vpc"

  name                = "dev"
  vpc_cidr            = "10.10.0.0/16"
  public_subnet_cidr  = "10.10.1.0/24"
  private_subnet_cidr = "10.10.2.0/24"
}

module "ec2" {
  source = "../../modules/ec2"

  name             = "dev-instance"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_id
  my_ip            = var.my_ip
  key_name         = "maksim-dev-key"
  public_key_path  = "~/.ssh/maksim-key.pub"
  ami              = var.ami
  instance_type    = var.instance_type
  private_key_path = "~/.ssh/maksim-key"
  ssh_user         = "ubuntu"
}
