variable "aws_region" {
    default = "us-east-1"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "subnet_cidr" {
    default =  "10.0.1.0/24" 
}

variable "ec2_type" {
    default = "t2.micro"
}

variable "account_id" {
    default =  "965777747972" 
}