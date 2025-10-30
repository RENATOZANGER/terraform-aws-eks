resource "aws_eip" "eks_ngw_eip_1a" {
  domain = "vpc"
  tags = merge(
    var.tags,
    {
      Name = "eks_ngw_eip_1a"
    }
  )
}

resource "aws_eip" "eks_ngw_eip_1b" {
  domain = "vpc"
  tags = merge(
    var.tags,
    {
      Name = "eks_ngw_eip_1b"
    }
  )
}

resource "aws_nat_gateway" "eks_ngw_1a" {
  depends_on = [aws_internet_gateway.eks_igw]
  allocation_id = aws_eip.eks_ngw_eip_1a.id
  subnet_id     = aws_subnet.eks_subnet_public_1a.id
  tags = merge(
    var.tags,
    {
      Name = "eks_ngw_1a"
    }
  )
}

resource "aws_nat_gateway" "eks_ngw_1b" {
  depends_on = [aws_internet_gateway.eks_igw]
  allocation_id = aws_eip.eks_ngw_eip_1b.id
  subnet_id     = aws_subnet.eks_subnet_public_1b.id
  tags = merge(
    var.tags,
    {
      Name = "eks_ngw_1b"
    }
  )
}

resource "aws_route_table" "eks_private_route_table_1a" {
  vpc_id = aws_vpc.eks_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.eks_ngw_1a.id
  }
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-private-rt-1a"
    }
  )
}

resource "aws_route_table" "eks_private_route_table_1b" {
  vpc_id = aws_vpc.eks_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.eks_ngw_1b.id
  }
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-private-rt-1b"
    }
  )
}
