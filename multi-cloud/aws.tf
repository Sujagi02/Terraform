resource "aws_instance" "mc" {
	   ami = "ami-010aff33ed5991201"
	   instance_type = var.types["ap-south-1"]
	   availability_zone = var.azaws[0]
           count = var.istest ? 1 : 0

	   tags = {
	        Name = "aws_multi_cloud"	
                }
}