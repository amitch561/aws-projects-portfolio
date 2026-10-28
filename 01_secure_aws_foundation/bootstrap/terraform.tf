terraform {
    required_version = ">= 1.16.1"
    required_providers {
        aws = {
            version = "6.71.0"
            source = "hashicorp/aws"
        }
      
    }
}

provider "aws" {
    
    profile = "mgmt-admin"
    region = "us-east-1"
}