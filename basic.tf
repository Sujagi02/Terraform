provider "aws" {
           region = "ap-south-1"
	   access_key = "AKIA6BXGW6ACDV3R6E3I"
	   secret_key = "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"
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
