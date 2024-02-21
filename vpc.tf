data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "meme_vpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  tags = {
      Name = "side-effect-vpc"
  }
}

resource "aws_route_table" "new_public_rtb" {
  vpc_id = aws_vpc.meme_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.meme_vpc_igw.id
  }
  tags = {
    Name = "NEW-PUBLIC-RTB"
  }
}

// public subnets
resource "aws_subnet" "meme_vpc_public_subnet1" {
  vpc_id = aws_vpc.meme_vpc.id
  cidr_block = "10.10.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "public-az-1"
  }
}

resource "aws_subnet" "meme_vpc_public_subnet2" {
  vpc_id = aws_vpc.meme_vpc.id
  cidr_block = "10.10.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[2]
  tags = {
    Name = "public-az-3"
  }
}

// private subnets
resource "aws_subnet" "meme_vpc_private_subnet1" {
  vpc_id = aws_vpc.meme_vpc.id
  cidr_block = "10.10.10.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "private-az-1"
  }
}

resource "aws_subnet" "meme_vpc_private_subnet2" {
  vpc_id = aws_vpc.meme_vpc.id
  cidr_block = "10.10.11.0/24"
  availability_zone = data.aws_availability_zones.available.names[2]
  tags = {
    Name = "private-az-3"
  }
}

resource "aws_subnet" "db_private_subnet1" {
  vpc_id = aws_vpc.meme_vpc.id
  cidr_block = "10.10.12.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "private-db-az-1"
  }
}

resource "aws_subnet" "db_private_subnet2" {
  vpc_id = aws_vpc.meme_vpc.id
  cidr_block = "10.10.13.0/24"
  availability_zone = data.aws_availability_zones.available.names[2]
  tags = {
    Name = "private-db-az-3"
  }
}

resource "aws_internet_gateway" "meme_vpc_igw" {
  vpc_id = aws_vpc.meme_vpc.id
  tags = {
    Name = "internet-gateway-terraform"
  }
}

// route to internet
resource "aws_route" "meme_vpc_internet_access" {
  route_table_id = aws_vpc.meme_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.meme_vpc_igw.id
}

// elastic ip address for NAT
resource "aws_eip" "meme_vpc_nat_eip" {
  domain = vpc
  depends_on = ["aws_internet_gateway.meme_vpc_igw"]
}

// NAT gateway
resource "aws_nat_gateway" "meme_vpc_nat" {
  allocation_id = aws_eip.meme_vpc_nat_eip.id
  subnet_id = aws_subnet.meme_vpc_public_subnet1.id
  depends_on = ["aws_internet_gateway.meme_vpc_igw"]
}

// private route table
resource "aws_route_table" "meme_vpc_private_route_table" {
    vpc_id = aws_vpc.meme_vpc.id
  tags = {
    Name = "private route table by terraform"
  }
}

resource "aws_route" "private_route" {
  route_table_id = aws_route_table.meme_vpc_private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.meme_vpc_nat.id
}

// associate subnets to route tables
resource "aws_route_table_association" "meme_vpc_public_subnet1_association" {
  subnet_id = aws_subnet.meme_vpc_public_subnet1.id
  route_table_id = aws_vpc.meme_vpc.main_route_table_id
}

resource "aws_route_table_association" "meme_vpc_public_subnet2_association" {
  subnet_id = aws_subnet.meme_vpc_public_subnet2.id
  route_table_id = aws_vpc.meme_vpc.main_route_table_id
}

resource "aws_route_table_association" "meme_vpc_private_subnet1_association" {
  subnet_id = aws_subnet.meme_vpc_private_subnet1.id
  route_table_id = aws_route_table.meme_vpc_private_route_table.id
}

resource "aws_route_table_association" "meme_vpc_private_subnet2_association" {
  subnet_id = aws_subnet.meme_vpc_private_subnet2.id
  route_table_id = aws_route_table.meme_vpc_private_route_table.id
}