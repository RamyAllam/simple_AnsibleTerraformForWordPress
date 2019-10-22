region         = "us-east-1"
aws_access_key = ""
aws_secret_key = ""

ec2 = {
  web_ami          = "amzn2-ami-hvm"
  web_ami_owner    = "amazon"
  ec2_key_pair     = "terraform"
  ssh_user         = "ec2-user"
  public_key_path  = "./ansible/keys/terraform.pub"
  private_key_path = "../ansible/keys/terraform.pem"
  instance_type    = "t2.micro"
  tag_name         = "wp-web"
}

rds = {
  allocated_storage    = 5
  engine               = "mysql"
  engine_version       = "5.7.26"
  instance_class       = "db.t2.micro"
  name                 = ""
  username             = ""
  password             = ""
  storage_type         = "gp2"
  parameter_group_name = "default.mysql5.7"
}

vpc = {
  cidr          = "172.20.0.0/16"
  public_cidr   = "172.20.0.0/20"
  private1_cidr = "172.20.16.0/20"
  private2_cidr = "172.20.32.0/20"
}

# Make sure to change the cidr accordingly, especially SSH
securitygroup = {
  ec2_ssh_ingress_cidr_blocks   = ["0.0.0.0/0"]
  ec2_http_ingress_cidr_blocks  = ["0.0.0.0/0"]
  ec2_https_ingress_cidr_blocks = ["0.0.0.0/0"]
}