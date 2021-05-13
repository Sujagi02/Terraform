provider "aws" {
           region = "ap-south-1"
	         profile = "default"
    }

resource "aws_instance" "web" {
	   ami = "ami-010aff33ed5991201"
	   instance_type = "t2.micro"
           security_groups = [ "webserver_tf" ]
	   key_name = "tf"

	   tags = {
	        Name = "tf_web1"	
                }

connection {
	type = "ssh"
	user = "ec2-user"
	private_key = file("C:/Users/sujag/Downloads/tf.pem")
	host = aws_instance.web.public_ip   
    }

provisioner "remote-exec" {
	inline = [
	      "sudo yum install httpd -y",
 	      "sudo systemctl start httpd",
	      "sudo systemctl enable httpd"
           ]
       }
}

resource "aws_ebs_volume" "web_vol" {
	availability_zone = aws_instance.web.availability_zone
	size = 10
	tags = {
	    Name = "ec2_ebs_web_vol"
         }
}

resource "aws_volume_attachment" "ebs_att_web_vol" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.web_vol.id
  instance_id = aws_instance.web.id
}

resource "null_resource" "nullremote1" {
	
connection {
	type = "ssh"
	user = "ec2-user"
	private_key = file("C:/Users/sujag/Downloads/tf.pem")
	host = aws_instance.web.public_ip   
    }

provisioner "remote-exec" {
	inline = [
	      "sudo mkfs.ext4 /dev/xvdh",
 	      "sudo mount /dev/xvdh /var/www/html"   
           ]
       }
}

resource "null_resource" "nullremote2" {
	
connection {
	type = "ssh"
	user = "ec2-user"
	private_key = file("C:/Users/sujag/Downloads/tf.pem")
	host = aws_instance.web.public_ip   
    }

provisioner "remote-exec" {
	inline = [
	      "sudo yum install git -y",
 	      "sudo git clone https://github.com/Sujagi02/Html.git  /var/www/html/web", 
	      "sudo systemctl restart httpd"  
           ]
       }
}

resource "null_resource" "nullremote3" {
	
provisioner "local-exec" {
	 command = "chrome http://13.232.10.87/web/web.html"
       }
}
