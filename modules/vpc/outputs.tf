output "region" {
  value = var.region
}

output "project_name" {
  value = var.project_name
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "pub_subnet_1_id" {
  value = aws_subnet.pub_subnet_1.id
}

output "pub_subnet_2_id" {
  value = aws_subnet.pub_subnet_2.id
}

output "private_subnet_1_id" {
  value = aws_subnet.private_subnet_1.id
}

output "private_subnet_2_id" {
  value = aws_subnet.private_subnet_2.id
}

output "private_data_subnet_cidr_1_id" {
  value = aws_subnet.private_data_subnet_cidr_1.id
}

output "private_data_subnet_cidr_2_id" {
  value = aws_subnet.private_data_subnet_cidr_2.id
}

output "gateway" {
  value = aws_internet_gateway.gw
}