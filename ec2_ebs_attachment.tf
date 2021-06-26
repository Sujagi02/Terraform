provider "aws" {
	region = "ap-south-1"
	profile = "default"
}

# step 1 -> Create a Security Group

resource "aws_security_group" "task2-sg" {
  name = "task2-sg"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# step 2 -> Launch ec2 instance

resource "aws_instance" "task2" {
	ami = "ami-010aff33ed5991201"
    key_name = "task-2" 
	instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.task2-sg.id]

	tags = {
	    Name = "ec2_taks2"
          }
}

# step 3 -> Create ebs volume

resource "aws_ebs_volume" "volume" {
	availability_zone = aws_instance.task2.availability_zone
	size = 10
	tags = {
	    Name = "ec2_ebs_vol_task2"
         }
}

# step 4 -> Attaching volume to instance

resource "aws_volume_attachment" "ebs_att_task2" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.volume.id
  instance_id = aws_instance.task2.id
}

# step 5 -> Outputs

output "az" {
	value = aws_instance.task2.availability_zone	
}

output "public_ip" {
	value = aws_instance.task2.public_ip	
}