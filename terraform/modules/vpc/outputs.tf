output "security_group_id" {
  value = aws_security_group.eks-sg.id
}

output "vpc_id" {
  value = aws_vpc.eks-vpc.id
}

output "public_subnet_a_id" {
  value = aws_subnet.eks-public-subnet-a.id
}

output "public_subnet_b_id" {
  value = aws_subnet.eks-public-subnet-b.id
}

output "public_subnet_c_id" {
  value = aws_subnet.eks-public-subnet-c.id
}

output "private_subnet_a_id" {
  value = aws_subnet.eks-private-subnet-a.id
}

output "private_subnet_b_id" {
  value = aws_subnet.eks-private-subnet-b.id
}

output "private_subnet_c_id" {
  value = aws_subnet.eks-private-subnet-c.id
}