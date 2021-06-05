variable "mtype" {}

variable "istest" {
	type = bool
}

variable "azaws" {
	default = [ "ap-south-1a" , "ap-south-1b" , "ap-south-1c"]
	type = list
}

variable "types" {
	type = map
	default = {
		ap-south-1 = "t2.micro",
		us-east-1 = "t2.nano" , 
		us-west-1 = "t2.medium"
             }
}

output "o1" {
	value = var.azaws
}

output "o2" {
	value = var.types["ap-south-1"]
}