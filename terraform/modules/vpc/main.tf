# VPC
resource "aws_vpc" "eks-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = var.vpc_name
  }

}

# IGW to allow resources inside my subnets to connect to the internet
resource "aws_internet_gateway" "eks-igw" {
  vpc_id = aws_vpc.eks-vpc.id

}

# private subnet A
resource "aws_subnet" "eks-private-subnet-a" {
  vpc_id            = aws_vpc.eks-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2a"

  # This prevents accidental deletion
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = var.private_subnet_name
  }

}

# private subnet B
resource "aws_subnet" "eks-private-subnet-b" {
  vpc_id            = aws_vpc.eks-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-2b"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = var.private_subnet_name
  }

}

# private subnet C
resource "aws_subnet" "eks-private-subnet-c" {
  vpc_id            = aws_vpc.eks-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-2c"

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = var.private_subnet_name
  }

}




# public subnet A
resource "aws_subnet" "eks-public-subnet-a" {
  vpc_id            = aws_vpc.eks-vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "eu-west-2a"


  lifecycle {
    prevent_destroy = true
  }


  tags = {
    Name = var.public_subnet_name
  }

}


# public subnet B
resource "aws_subnet" "eks-public-subnet-b" {
  vpc_id            = aws_vpc.eks-vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "eu-west-2b"


  lifecycle {
    prevent_destroy = true
  }


  tags = {
    Name = var.public_subnet_name
  }

}


# public subnet C
resource "aws_subnet" "eks-public-subnet-c" {
  vpc_id            = aws_vpc.eks-vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "eu-west-2c"


  lifecycle {
    prevent_destroy = true
  }


  tags = {
    Name = var.public_subnet_name
  }

}


# private route table to guide traffic to the internet through the NAT gateway
resource "aws_route_table" "eks-private-rt" {
  vpc_id = aws_vpc.eks-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks-ng.id
  }

}

# private route table association to link my private subnet to the private route table 
resource "aws_route_table_association" "eks-private-rta-a" {
  subnet_id      = aws_subnet.eks-private-subnet-a.id
  route_table_id = aws_route_table.eks-private-rt.id
}

# private route table association to link my private subnet to the private route table 
resource "aws_route_table_association" "eks-private-rta-b" {
  subnet_id      = aws_subnet.eks-private-subnet-b.id
  route_table_id = aws_route_table.eks-private-rt.id
}

# private route table association to link my private subnet to the private route table 
resource "aws_route_table_association" "eks-private-rta-c" {
  subnet_id      = aws_subnet.eks-private-subnet-c.id
  route_table_id = aws_route_table.eks-private-rt.id
}




# public route table to guide traffic to the internet through the NAT gateway
resource "aws_route_table" "eks-public-rt" {
  vpc_id = aws_vpc.eks-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks-igw.id
  }

}

# public route table association to link my subnet to the route table 
resource "aws_route_table_association" "eks-public-rta-a" {
  subnet_id      = aws_subnet.eks-public-subnet-a.id
  route_table_id = aws_route_table.eks-public-rt.id
}

# public route table association to link my subnet to the route table 
resource "aws_route_table_association" "eks-public-rta-b" {
  subnet_id      = aws_subnet.eks-public-subnet-b.id
  route_table_id = aws_route_table.eks-public-rt.id
}

# public route table association to link my subnet to the route table 
resource "aws_route_table_association" "eks-public-rta-c" {
  subnet_id      = aws_subnet.eks-public-subnet-c.id
  route_table_id = aws_route_table.eks-public-rt.id
}




# EIP used with a NAT Gateway to provide a stable and consistent public IP address
resource "aws_eip" "eks-eip" {
  domain = "vpc"
}

# NAT Gateway placed in the public subnet because it already has internet access, used to access the internet securely without exposing them.
resource "aws_nat_gateway" "eks-ng" {
  allocation_id = aws_eip.eks-eip.id
  subnet_id     = aws_subnet.eks-public-subnet-a.id

}



# Security groups controls inbound and outbound traffic to and from your resources (like a firewall)
resource "aws_security_group" "eks-sg" {
  vpc_id = aws_vpc.eks-vpc.id


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