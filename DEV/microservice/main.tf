terraform {
  backend "s3" {
    region = "eu-west-2"
    bucket = "tabi-terraformpipeline"
    key = "SPIKE3/DEV/microservice/terraform.tfstate"
    profile = "developmentaws"    
  }
}
 
provider "aws" {
    region = "eu-west-2"
    profile = "developmentaws"
}

module "microservice" {
    source = "../../../spike3-tf-module-microservice"

    service_name = "service-one"
    service_port = 8081
    service_image_id = "ami-4d3a2e29"
    vpc_name = "${data.terraform_remote_state.vpc.aws_vpc.vpc.name}"
    vpc_id = "${data.terraform_remote_state.vpc.aws_vpc.vpc.id}"
    internal_subnet_id = "${data.terraform_remote_state.vpc.aws_subnet.internal_subnet.*.id[0]}"
    external_subnet_id = "${data.terraform_remote_state.vpc.aws_subnet.external_subnet.*.id[0]}"
}