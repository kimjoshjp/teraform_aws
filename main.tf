#variable "aws_access_key" {}
#variable "aws_secret_key" {}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = "ap-southeast-2"
  }

resource "aws_vpc" "test-vpc" {
   cidr_block = "10.0.0.0/16"
   tags = {
     Name = "test-vpc"
     }
  }
