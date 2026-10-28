resource "aws_s3_bucket" "tfstate" {
    bucket = "secure-tfstate-x43x9"

    tags = {
        Name = "terraform-state"
        Environment = "dev"
        ManagedBy = "terraform"
        Project = " secure-aws-foundation"
    }
  
}