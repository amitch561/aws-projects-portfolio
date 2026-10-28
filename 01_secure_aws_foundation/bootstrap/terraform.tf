terraform {
    required_version = ">= 1.17.1"
    required_providers {
        aws = {
            version = "6.71.0"
            source = "hashicorp/aws"
        }
      
    }
}

provider "aws" {
    
    region = "us-east-1"
}