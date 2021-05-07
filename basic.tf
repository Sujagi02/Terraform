provider "aws" {
           region = "ap-south-1"
	   access_key = "your access key"
	   secret_key = "your secret key"
    }

resource "aws_instance" "sv" {
	   ami = "ami-010aff33ed5991201"
	   instance_type = "t2.micro"
	   tags = {
	        Name = "tf_os1"	
                }
     }
     
resource "aws_instance" "sv1" {
	   ami = "ami-0a9d27a9f4f5c0efc"
	   instance_type = "t2.micro"
	   tags = {
	        Name = "tf_os2"	
                }
     }
