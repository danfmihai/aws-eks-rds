terraform {
  backend "s3" {
    bucket = "terraform-visual-september"
    key    = "eks/infrastructure/eks-rds.tfvars"
    region = "us-east-1"
  }
}