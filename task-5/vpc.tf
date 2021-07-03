#Creating a VPC
resource "aws_vpc" "vpc_task5" {
    cidr_block = var.vpc_cidr

    tags = {
       Name = "lwterra"
}
}

#Creating IN Gateway
resource "aws_internet_gateway" "gw_task5" {
    vpc_id = aws_vpc.vpc_task5.id

    tags = {
       Name = "GW task5"
}
}

#Creating Subnets
resource "aws_subnet" "subnet_task5" {
  vpc_id     = aws_vpc.vpc_task5.id
  cidr_block = var.subnet_cidr
  availability_zone= "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
      Name = "Subnet-task5"
  }
}

#Creating Route tables
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc_task5.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_task5.id
  }

  tags = {
        Name = "RT task5"
    }
}

#Associating RT
resource "aws_route_table_association" "rt_ass" {
  subnet_id      = aws_subnet.subnet_task5.id
  route_table_id = aws_route_table.rt.id
}

