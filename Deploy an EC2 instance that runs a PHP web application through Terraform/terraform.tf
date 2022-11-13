terraform {
  cloud {
      organization = "gsvibhavcorp"
      workspaces {
        name = "learn-terraform-resource"
      }
  }
  
   required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.15.0"
    }
    random = {
      source = "hashicorp/random"
    }
  }

  required_version = ">= 1.2"
}
