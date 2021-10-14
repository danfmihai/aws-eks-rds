resource "aws_subnet" "public_1" {
  vpc_id            = aws_vpc.eks.id
  cidr_block        = "192.168.0.0/18"
  availability_zone = "us-east-1a"

  # Required for EKS. Instances launched into subnet should be assigned public ips
  map_public_ip_on_launch = true

  tags = {
    Name = "eks-public-us-east-1a"
    # Mandatory tags for kubernetes. Amazon EKS does not add the 
    # tag to subnets passed in when creating 1.19 clusters
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/elb"               = 1
  }
}

resource "aws_subnet" "public_2" {
  vpc_id            = aws_vpc.eks.id
  cidr_block        = "192.168.64.0/18"
  availability_zone = "us-east-1b"

  # Required for EKS. Instances launched into public subnet should be assigned public ips
  map_public_ip_on_launch = true

  tags = {
    Name = "eks-public-us-east-1b"
    # Mandatory tags for kubernetes. Amazon EKS does not add the 
    # tag to subnets passed in when creating 1.19 clusters
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/elb"               = 1
  }
}


resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.eks.id
  cidr_block        = "192.168.128.0/18"
  availability_zone = "us-east-1a"

  tags = {
    Name = "eks-private-us-east-1a"
    # Mandatory tags for kubernetes. Amazon EKS does not add the 
    # tag to subnets passed in when creating 1.19 clusters
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"      = 1
  }
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.eks.id
  cidr_block        = "192.168.192.0/18"
  availability_zone = "us-east-1b"

  tags = {
    Name = "eks-private-us-east-1b"
    # Mandatory tags for kubernetes. Amazon EKS does not add the 
    # tag to subnets passed in when creating 1.19 clusters
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"      = 1
  }
}
