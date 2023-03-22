# create a vpc
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
    }
}

# create an internet gateway and attach it to the vpc
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project_name}-gtw"
  }
}

# I use data sourc to retrieve all the availability zone in our region
data "aws_availability_zones" "available" {}

# create a public subnet in AZ1
resource "aws_subnet" "pub_subnet_1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pub_subnet_cidr_1
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public subnet az1"
  }
}

# create a public subnet in AZ2
resource "aws_subnet" "pub_subnet_2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pub_subnet_cidr_2
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public subnet az2"
  }
}

#create a public route to connect to the internet gateway
resource "aws_route_table" "internet_route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public route"
  }
}

# associating public subnet 1 to public routetable 1
resource "aws_route_table_association" "pub_route_a" {
  subnet_id      = aws_subnet.pub_subnet_1.id
  route_table_id = aws_route_table.internet_route.id
}

# associating public subnet 2 to public routetable 1
resource "aws_route_table_association" "pub_route_b" {
  subnet_id      = aws_subnet.pub_subnet_2.id
  route_table_id = aws_route_table.internet_route.id
}

# create a private subnet in AZ1
resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnet_cidr_1
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false


  tags = {
    Name = "Private subnet az1"
  }
}

# create a public subnet in AZ2
resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnet_cidr_2
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false


  tags = {
    Name = "Private subnet az2"
  }
}

#create a private data subnet 1
resource "aws_subnet" "private_data_subnet_cidr_1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_data_subnet_cidr_1
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false


  tags = {
    "Name" = "private data subnet 1"
  }
}

#create a private data subnet 1
resource "aws_subnet" "private_data_subnet_cidr_2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.private_data_subnet_cidr_2
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false

  tags = {
    "Name" = "private data subnet 2"
  }
}
