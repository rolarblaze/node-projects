provider "aws" {
  region  = var.region
  profile = "default"


}


module "vpc" {
  source                     = "../modules/vpc"
  region                     = var.region
  project_name               = var.project_name
  vpc_cidr                   = var.vpc_cidr
  pub_subnet_cidr_1          = var.pub_subnet_cidr_1
  pub_subnet_cidr_2          = var.pub_subnet_cidr_2
  private_subnet_cidr_1      = var.private_subnet_cidr_1
  private_subnet_cidr_2      = var.private_subnet_cidr_2
  private_data_subnet_cidr_1 = var.private_subnet_cidr_1
  private_data_subnet_cidr_2 = var.private_data_subnet_cidr_2
}


#exporting the Nat Gateway Module
module "nat_gateway" {
  source                        = "../modules/nat-gateway"
  pub_subnet_1_id               = module.vpc.pub_subnet_1_id
  gateway                       = module.vpc.gateway
  pub_subnet_2_id               = module.vpc.pub_subnet_2_id
  vpc_id                        = module.vpc.vpc_id
  private_subnet_1_id           = module.vpc.private_subnet_1_id
  private_data_subnet_cidr_1_id = module.vpc.private_data_subnet_cidr_1_id
  private_subnet_2_id           = module.vpc.private_subnet_2_id
  private_data_subnet_cidr_2_id = module.vpc.private_data_subnet_cidr_2_id
}

# security group module
module "security_group" {
  source = "../modules/security-group"

  vpc_id = module.vpc.vpc_id
  
}

# ecs execution role module
module "acm" {
  source = "../modules/ecs-task-exec-rule"
  project_name = module.vpc.project_name
}

# Applicattion load balancer 

module "application_load_balancer" {
  source = "../modules/alb"

  project_name = module.vpc.project_name
  app_load_balancer_id = module.security_group.app_load_balancer_id
  pub_subnet_1_id = module.vpc.pub_subnet_1_id
  pub_subnet_2_id = module.vpc.pub_subnet_2_id
  vpc_id = module.vpc.vpc_id
  #certificate_arn = module.acm.certificate_arn

  
}