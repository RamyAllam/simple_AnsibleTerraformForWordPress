variable "region" {
  default = "us-east-1"
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "ec2" {
  type = "map"
}

variable "rds" {
  type = "map"
}
variable "vpc" {
  type = "map"
}

variable "securitygroup" {
  type = "map"
}