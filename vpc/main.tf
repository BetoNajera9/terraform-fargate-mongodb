resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    "Name" = "main_vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "igw_main_vpc"
  }
}

# Public subnets
resource "aws_subnet" "public_subnets" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true # Asign automatic public IP

  tags = {
    Name = "public_subnet_${each.key}_main_vpc"
  }
}

# Private subnets
resource "aws_subnet" "private_subnets" {
  for_each = var.private_subnet

  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = {
    Name = "private_subnet_${each.key}_main_vpc"
  }
}

# Route table for public subnets
resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_rt_main_vpc"
  }
}

resource "aws_route_table_association" "crta_public_subnets" {
  for_each = aws_subnet.public_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_crt.id
}

# Elastic IP para el NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "private_nat_eip"
  }
}

# NAT Gateway en la primer subnet pública
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = values(aws_subnet.public_subnets)[0].id

  tags = {
    Name = "nat_gateway_public_subnet"
  }

  depends_on = [aws_internet_gateway.igw]
}

# 3. Route Table privada (apunta al NAT)
resource "aws_route_table" "private_crt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private_rt_main_vpc"
  }
}

resource "aws_route_table_association" "private_assoc" {
  for_each = aws_subnet.private_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_crt.id
}
