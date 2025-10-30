resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-igw"
    }
  )
  depends_on = [
    aws_nat_gateway.eks_ngw_1a,
    aws_nat_gateway.eks_ngw_1b,
    aws_eip.eks_ngw_eip_1a,
    aws_eip.eks_ngw_eip_1b,
  ]
}

resource "aws_route_table" "eks_public_route_table" {
  vpc_id = aws_vpc.eks_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_igw.id
  }
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-public-rt"
    }
  )
}
