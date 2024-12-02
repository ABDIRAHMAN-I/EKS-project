module "aws_ecr_repository" {
  source              = "./modules/ecr"
  ecr_repository_name = "eks-tetras-project"
}


