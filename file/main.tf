resource "aws_security_group" "test_sg" {
	
	description ="allowing ssh and http traffic"
        vpc_id = "vpc-a85eb9c3"

	ingress {
	from_port = 22
	to_port = 22
	protocol = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
	}

	ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }
	
	egress {
	from_port = 0
	to_port = 0
	protocol = "-1"
	cidr_blocks = ["0.0.0.0/0"]
        }
	tags={
		Name = "heloo"
}

}


#********creating ec2-instance***********

resource "aws_instance" "shubham" {
        ami = "ami-0e306788ff2473ccb"
        instance_type = "t2.micro"  
        vpc_security_group_ids = ["${aws_security_group.test_sg.id}"]
        key_name = "mykey"

        user_data = <<-EOF
                #! /bin/bash
                sudo yum install httpd -y
                sudo systemctl start httpd.service
                sudo systemctl enable httpd.service
                echo "hello brother" >> /var/www/html/index.html
                EOF



        tags = {
            Name = "shubham"
        }

}
resource "aws_ami_copy" "test" {
       name              = "terraform-ami"
       description       = "A copy of ami-alredy created instance"
       source_ami_id     = "ami-0e306788ff2473ccb"
       source_ami_region = "ap-south-1"

       tags = {
       Name = "shubh_Ami"
  }
}


