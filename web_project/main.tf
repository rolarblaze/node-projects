provider "aws" {
   region = var.region
   profile = "default"

}

module "vpc" {
  source = "../modules/vpc"
  region = var.region
  project_name = var.project_name
  vpc_cidr = var.vpc_cidr
  pub_subnet_cidr_1 = var.pub_subnet_cidr_1
  pub_subnet_cidr_2 = var.pub_subnet_cidr_2
  private_subnet_cidr_1 = var.private_subnet_cidr_1
  private_subnet_cidr_2 = var.private_subnet_cidr_2
  private_data_subnet_cidr_1 = var.private_subnet_cidr_1
  private_data_subnet_cidr_2 = var.private_data_subnet_cidr_2
}