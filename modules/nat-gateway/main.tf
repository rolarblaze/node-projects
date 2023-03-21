# allocate elastic IP for nat gateway in az1 
resource "aws_eip" "eip_nat_gateway_az1" {
  vpc                       = true

  tags ={
    "name" = "eip for nat-gateway az1"
  }
}

# allocate elastic IP for nat gateway in az2 
resource "aws_eip" "eip_nat_gateway_az2" {
  vpc                       = true

  tags ={
    Name = "eip for nat-gateway az2"
  }
}

# Nat gateway to connect the public 
resource "aws_nat_gateway" "eip_nat_gateway_az1" {
  allocation_id = aws_eip.eip_nat_gateway_az1.id
  subnet_id     = var.pub_subnet_1_id

  tags = {
    Name = "nat gateway for az1"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [var.gateway]
}

# Nat gateway to connect the public 
resource "aws_nat_gateway" "eip_nat_gateway_az2" {
  allocation_id = aws_eip.eip_nat_gateway_az2.id
  subnet_id     = var.pub_subnet_2_id

  tags = {
    Name = "nat gateway for az2"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [var.gateway]
}

# create a private route table in az1 and attach nat gateway  
resource "aws_route_table" "private_route_az1" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.eip_nat_gateway_az1.id
  }
  tags = {
    Name = "private route az1"
  }
}

#associate private subnet az1 to private routable az1
resource "aws_route_table_association" "private_app_subnet_az1" {
  subnet_id      = var.private_subnet_1_id
  route_table_id = aws_route_table.private_route_az1.id
}

#associate private data subnet az1 to private routable az1
resource "aws_route_table_association" "private_data_subnet_az1" {
  subnet_id      = var.private_data_subnet_cidr_1_id
  route_table_id = aws_route_table.private_route_az1.id
}

# create a private route table in az2 and attach nat gateway  
resource "aws_route_table" "private_route_az2" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.eip_nat_gateway_az2.id
  }
  tags = {
    Name = "private route az2"
  }
}

#associate private subnet az1 to private routable az1
resource "aws_route_table_association" "private_app_subnet_az2" {
  subnet_id      = var.private_subnet_2_id
  route_table_id = aws_route_table.private_route_az2.id
}

#associate private data subnet az2 to private routable az2
resource "aws_route_table_association" "private_data_subnet_az2" {
  subnet_id      = var.private_data_subnet_cidr_2_id
  route_table_id = aws_route_table.private_route_az2.id
}
