terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "istest" {}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = "ap-northeast-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0bba69335379e17f8" #ap-northeast-1
  instance_type = "t2.micro"
  count = 3
  }

resource "aws_instance" "dev" {
  ami           = "ami-0bba69335379e17f8" #ap-northeast-1
  instance_type = "t2.micro"
  count = var.istest == true ? 2 : 0
}

resource "aws_instance" "prod" {
  ami           = "ami-0bba69335379e17f8" #ap-northeast-1
  instance_type = "t2.micro"
  count = var.istest == false ? 2 : 0
}

variable "elb_names" {
type = list
default = ["dev-tester","stage-tester","prod-tester"]
}

resource "aws_iam_user" "lb" {
  name = var.elb_names[count.index]
  count = 3
  path = "/system/"

}
resource "aws_vpc" "test-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "test-vpc"
  }
}
