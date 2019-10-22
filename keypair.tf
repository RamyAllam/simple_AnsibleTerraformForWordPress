resource "aws_key_pair" "wp_auth" {
  key_name   = "${var.ec2["ec2_key_pair"]}"
  public_key = "${file(var.ec2["public_key_path"])}"
}