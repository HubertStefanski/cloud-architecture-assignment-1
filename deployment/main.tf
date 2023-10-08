terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.20.0"
    }
  }
}


provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      purpose   = "assignment-1"
      managedby = "tofu"
      owner     = "hstefans"
    }
  }
}

module "app_stack" {
  source = "./modules/app_stack"
}