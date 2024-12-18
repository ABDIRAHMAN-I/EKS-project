module "vpc" {
  source = "./modules/vpc"
  vpc_name = "eks-vpc"
  private_subnet_name = "eks-private-subnet"
  public_subnet_name = "eks-public-subnet"
  igw_name = "eks-igw"
  route_table_name = "eks-rt"
  sg_name = "eks-sg"

}


module "ecr" {
  source              = "./modules/ecr"
  ecr_repository_name = "eks-tetras-project"
}
