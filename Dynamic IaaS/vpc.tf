#Creating a VPC
resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr

    tags = {
       Name = "My VPC"
}
}

#Creating a Security Group 
resource "aws_default_security_group" "sg" {
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  tags = {
    Name = "MY SG"
  }
}


#Creating IN Gateway
resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.my_vpc.id

    tags = {
       Name = "My gw"
}
}

#Creating Subnets
resource "aws_subnet" "my_subnet" {
  count = length(var.subnet_cidr)
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = element(var.subnet_cidr,count.index)
  availability_zone= element(var.azs,count.index)
  map_public_ip_on_launch = true

  tags = {
      Name = "Subnet-${count.index+1}"
  }
}

#Creating Route tables
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
        Name = "RT"
    }
}

#Associating RT
resource "aws_route_table_association" "rt_ass" {
  count = length(var.subnet_cidr)
  subnet_id      = element(aws_subnet.my_subnet.*.id,count.index)
  route_table_id = aws_route_table.rt.id
}

#Creating an instance
resource "aws_instance" "ec2" {
	   ami = var.ami
	   instance_type = var.ec2_type
	   tags = {
	        Name = "Iaas_OS"	
                }
}
