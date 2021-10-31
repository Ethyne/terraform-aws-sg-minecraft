terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.29"
    }
  }
}

provider "aws" {
  region = data.terraform_remote_state.vpc.outputs.region
}

resource "aws_security_group" "sg_minecraft" {
  name_prefix   = "${var.prefix}_sg_minecraft"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  # SSH access from the VPC
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    organization = "Howes"
    workspaces = {
      name = "AWS-Landing-Zone"
    }
  }
}