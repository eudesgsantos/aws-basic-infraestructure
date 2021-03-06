resource "aws_security_group" "EC2PubSecGP" {
  name        = "EC2PubSecGP"
  description = "Allow internet inbound traffic"
  vpc_id      = var.VPC

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "EC2PubSecGP"
  }
}

resource "aws_security_group" "EC2PrivSecGP" {
  name        = "EC2PrivSecGP"
  description = "Allow EC2PubSecGP inbound traffic"
  vpc_id      = var.VPC
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups = ["${aws_security_group.EC2PubSecGP.id}"]
  }

   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "EC2PrivSecGP"
  }
}

resource "aws_security_group" "DBSecGP" {
  name        = "DBSecGP"
  description = "Allow EC2PrivSecGP inbound traffic"
  vpc_id      = var.VPC
  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups = ["${aws_security_group.EC2PrivSecGP.id}"]
  }

   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "DBSecGP"
  }
}

