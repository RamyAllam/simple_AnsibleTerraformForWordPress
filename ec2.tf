provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "web-wp" {
  ami                    = "${data.aws_ami.web_ami.id}"
  instance_type          = "${var.ec2["instance_type"]}"
  key_name               = "${var.ec2["ec2_key_pair"]}"
  vpc_security_group_ids = ["${aws_security_group.wp-ec2.id}"]
  subnet_id              = "${aws_subnet.wp_public_subnet.id}"

  tags = {
    Name = "${var.ec2["tag_name"]}"
  }

  provisioner "local-exec" {
    command = <<EOD
cat <<EOF > ansible/hosts.ini
[wp_prod_terraform] 
${aws_instance.web-wp.public_ip} ansible_ssh_private_key_file=${var.ec2["private_key_path"]} ansible_user=${var.ec2["ssh_user"]}
EOF
EOD
  }

  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.web-wp.id} && cd ansible  && ansible-playbook -i hosts.ini wp.yml"
  }

}

data "aws_ami" "web_ami" {
  most_recent = true


  filter {
    name   = "owner-alias"
    values = ["${var.ec2["web_ami_owner"]}"]
  }


  filter {
    name   = "name"
    values = ["${var.ec2["web_ami"]}*"]
  }

  owners = ["${var.ec2["web_ami_owner"]}"]
}