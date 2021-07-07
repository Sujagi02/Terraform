resource "aws_instance" "ec2_task5" {
  depends_on = [aws_vpc.vpc_task5]
  ami                    = "ami-0ab4d1e9cf9a1215a"
  instance_type          = var.ec2_type
  key_name               = "task-5"
  subnet_id              = aws_subnet.subnet_task5.id
  vpc_security_group_ids = ["${aws_security_group.sg_task5.id}"]
  associate_public_ip_address = true

  tags = {
      Name = "EC2 task5"
  }
}

resource "aws_ebs_volume" "vol_task5" {
	availability_zone = aws_instance.ec2_task5.availability_zone
	size = 10
	tags = {
	    Name = "vol task5"
         }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.vol_task5.id
  instance_id = aws_instance.ec2_task5.id
}

resource "null_resource" "skills" {
	depends_on = [aws_instance.ec2_task5]
connection {
	type = "ssh"
	user = "ec2-user"
	private_key = file("C:/Users/sujag/Downloads/task-5.pem")
	host = aws_instance.ec2_task5.public_ip   
    }

provisioner "remote-exec" {
	inline = [
        "sudo yum install httpd -y",
 	      "sudo systemctl start httpd",
	      "sudo systemctl enable httpd",
	      "sudo yum install git -y",
 	      "sudo git clone https://github.com/Sujagi02/Html.git  /var/www/html/web", 
	      "sudo systemctl restart httpd"  
           ]
       }
}

output "public_ip" {
  value = aws_instance.ec2_task5.public_ip
}
