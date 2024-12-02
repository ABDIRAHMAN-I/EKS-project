module "aws_ecr_repository" {
  source              = "./modules/ecr"
  ecr_repository_name = "eks-tetras-project"
}


module "aws_vpc" {
  source = "./modules/vpc"
}


module "aws_subnet" {
  source = "./modules/vpc"  
}


module "aws_internet_gateway" {
  source = "./modules/vpc"
  
}


module "aws_route_table" {
  source = "./modules/vpc"
}

module "aws_route_table_association" {
  source = "./modules/vpc"
}

module "aws_eip" {
  source = "./modules/vpc"
}

module "aws_nat_gateway" {
  source = "./modules/vpc"
}

module "aws_security_group" {
  source = "./modules/vpc"
}

