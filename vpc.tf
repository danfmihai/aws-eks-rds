resource "aws_vpc" "eks" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"
  # Required by EKS. VPC must have DNS hostname and DNS 
  # resolution support, or your nodes can't register with your cluster. 
  enable_dns_support               = true
  enable_dns_hostnames             = true
  enable_classiclink               = false
  enable_classiclink_dns_support   = false
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name = "eks"
  }
}

output "vpc_id" {
  value       = aws_vpc.eks.id
  description = "VPC id."

  # Setting an output value as sensitive prevents Terraform from showing its value in plan and apply
  sensitive = false
}