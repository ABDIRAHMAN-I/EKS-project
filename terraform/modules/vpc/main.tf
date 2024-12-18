# VPC
resource "aws_vpc" "eks-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = var.vpc_name
}

}

# private subnet
resource "aws_subnet" "eks-private-subnet" {
    vpc_id = aws_vpc.eks-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "eu-west-2a"

  tags = {
    Name = var.private_subnet_name
}

}

# public subnet
resource "aws_subnet" "eks-public-subnet" {
    vpc_id = aws_vpc.eks-vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "eu-west-2b"
    tags = {
    Name = var.public_subnet_name
}

}

# IGW to allow resources inside my subnets to connect to the internets
resource "aws_internet_gateway" "eks-igw" {
  vpc_id = aws_vpc.eks-vpc.id

}

# public route table to guide traffic to the internet through the NAT gateway
resource "aws_route_table" "eks-public-rt" {
  vpc_id = aws_vpc.eks-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks-igw.id
  }

}

# route table association to link my subnet to the route table 
resource "aws_route_table_association" "eks-public-rta" {
  subnet_id      = aws_subnet.eks-public-subnet.id
  route_table_id = aws_route_table.eks-public-rt.id
}



# EIP used with a NAT Gateway to provide a stable and consistent public IP address
resource "aws_eip" "eks-eip" {
  domain   = "vpc"
}


# NAT Gateway placed in the public subnet because it already has internet access, used to access the internet securely without exposing them.
resource "aws_nat_gateway" "eks-ng" {
  allocation_id = aws_eip.eks-eip.id
  subnet_id     = aws_subnet.eks-public-subnet.id

}


# private route table to guide traffic to the internet through the NAT gateway
resource "aws_route_table" "eks-private-rt" {
  vpc_id = aws_vpc.eks-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks-ng.id
  }

}


# route table association to link my private subnet to the private route table 
resource "aws_route_table_association" "eks-private-rta" {
  subnet_id      = aws_subnet.eks-private-subnet.id
  route_table_id = aws_route_table.eks-private-rt.id
}


resource "aws_security_group" "eks-sg" {
  vpc_id      = aws_vpc.eks-vpc.id

  
 ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  





}