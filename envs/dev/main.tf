provider "aws" {
  region = var.region
}

locals {
  user_data = templatefile("${path.module}/templates/user_data.sh.tftpl", {
    logs_bucket_name = module.s3.logs_bucket_name
  })
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

  name                 = "dev-instance"
  vpc_id               = module.vpc.vpc_id
  public_subnet_id     = module.vpc.public_subnet_id
  my_ip                = var.my_ip
  ami                  = var.ami
  instance_type        = var.instance_type
  existing_key_name    = "maksim-dev-key"
  ssh_user             = "ubuntu"
  iam_instance_profile = module.iam.instance_profile_name
  user_data            = local.user_data
}

module "s3" {
  source = "../../modules/s3"

  app_bucket_name  = var.app_bucket_name
  logs_bucket_name = var.logs_bucket_name
  tags             = var.tags
}

module "iam" {
  source = "../../modules/iam"

  role_name             = "dev-ec2-role"
  instance_profile_name = "dev-ec2-profile"
  logs_bucket_arn       = module.s3.logs_bucket_arn
  tags                  = var.tags
}
