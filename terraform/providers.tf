terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.82.1"
    }

    helm = {

      source  = "hashicorp/helm"
      version = ">= 2.6"
    }
  }

}

provider "aws" {
  region = "eu-west-2"

}