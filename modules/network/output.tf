output "subnet_public_1a_id" {
  value = aws_subnet.eks_subnet_public_1a.id
}

output "subnet_public_1b_id" {
  value = aws_subnet.eks_subnet_public_1b.id
}

output "subnet_private_1a_id" {
  value = aws_subnet.eks_subnet_private_1a.id
}

output "subnet_private_1b_id" {
  value = aws_subnet.eks_subnet_private_1b.id
}

output "vpc_id" {
  value = aws_vpc.eks_vpc.id
}
