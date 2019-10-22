
resource "aws_security_group" "wp-ec2" {
  name        = "wp-ec2"
  description = "Allow EC2 inbound and outbound traffic"
  vpc_id      = "${aws_vpc.wp_vpc.id}"

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.securitygroup.ec2_ssh_ingress_cidr_blocks}"
  }

  # HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "${var.securitygroup.ec2_http_ingress_cidr_blocks}"
  }

  # HTTPs
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.securitygroup.ec2_https_ingress_cidr_blocks}"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wp-ec2"
  }
}

resource "aws_security_group" "wp-rds" {
  name        = "wp-rds"
  description = "Allow RDS inbound traffic"
  vpc_id      = "${aws_vpc.wp_vpc.id}"

  # MySQL
  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    cidr_blocks = [
      "${var.vpc.public_cidr}",
      "${var.vpc.private1_cidr}",
      "${var.vpc.private2_cidr}"
    ]
  }

  tags = {
    Name = "wp-rds"
  }
}