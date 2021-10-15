terraform {
  backend "s3" {
    bucket = "terraform-visual-september"
    key    = "eks/infrastructure/eks-rds.tfstate"
    region = "us-east-1"
  }
}