resource "aws_db_subnet_group" "wp_rds_subnetgroup" {
  name = "wp_rds_subnetgroup"

  subnet_ids = ["${aws_subnet.wp_private1_subnet.id}", "${aws_subnet.wp_private2_subnet.id}"]

  tags = {
    Name = "wp_rds_subnetgroup"
  }
}

resource "aws_db_instance" "wordpress" {
  allocated_storage      = "${var.rds["allocated_storage"]}"
  storage_type           = "${var.rds["storage_type"]}"
  engine                 = "${var.rds["engine"]}"
  engine_version         = "${var.rds["engine_version"]}"
  instance_class         = "${var.rds["instance_class"]}"
  name                   = "${var.rds["name"]}"
  username               = "${var.rds["username"]}"
  password               = "${var.rds["password"]}"
  parameter_group_name   = "${var.rds["parameter_group_name"]}"
  vpc_security_group_ids = ["${aws_security_group.wp-rds.id}"]
  skip_final_snapshot    = true
  db_subnet_group_name   = "${aws_db_subnet_group.wp_rds_subnetgroup.name}"
}