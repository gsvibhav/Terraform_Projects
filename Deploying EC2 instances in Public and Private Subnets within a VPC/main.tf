terraform {
  cloud {
    organization = "Enter your Organization name"
    workspaces {
      name = "learn-terraform-instance"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.3.0"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region = "us-west-2"
}

variable "project_tags" {
  type        = map(string)
  description = "Tags used for aws test"
  default = {
    project = "aws-terraform-test"
  }
}

### Create an EC2 Instance ###

resource "aws_instance" "app" {
  ami                         = "ami-0d593311db5abb72b"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.trial-sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "Application Server"
  }
  key_name = aws_key_pair.gsv_auth.id
}

### Create an EC2 Instance ###

resource "aws_instance" "db" {
  ami                    = "ami-0d593311db5abb72b"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.trial-sg.id]

  tags = {
    Name = "DB Server"
  }
  key_name = aws_key_pair.gsv_auth.id
}

### Creates a Key Pair for EC2 instance ###

resource "aws_key_pair" "gsv_auth" {
  key_name   = "gsv-key"
  public_key = "Enter your Public key value"
}

### Availability Zones ###

data "aws_availability_zones" "available" {}
