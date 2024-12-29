terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.82.1"
    }
  }

}

provider "aws" {
  region = "eu-west-2"

}




