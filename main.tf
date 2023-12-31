terraform {
  backend "s3" {
    bucket = "agp-terraform-tfstate"
    key    = "vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "${var.region}"
}

data "aws_availability_zones" "az" {
  state = "available"
}

