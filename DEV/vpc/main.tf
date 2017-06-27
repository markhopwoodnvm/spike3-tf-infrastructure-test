terraform {
  backend "s3" {
    region = "eu-west-2"
    bucket = "tabi-terraformpipeline"
    key    = "SPIKE3/DEV/vpc/terraform.tfstate"
    profile = "developmentaws"
  }
}

provider "aws" {
  region = "eu-west-2"
  profile = "developmentaws"
}

module "vpc" {
  source     = "../../../spike3-tf-module-vpc"
  vpc_name   = "DEV"
  cidr_block = "10.1.0.0/16"
}
