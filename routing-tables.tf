resource "aws_route_table" "route_public" {

  vpc_id = aws_vpc.eks.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "eks-public"
  }
}

resource "aws_route_table" "route_private_1" {

  vpc_id = aws_vpc.eks.id

  tags = {
    Name = "eks-private_1"
  }
}

resource "aws_route_table" "route_private_2" {

  vpc_id = aws_vpc.eks.id

  tags = {
    Name = "eks-private_2"
  }
}