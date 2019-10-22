### Terraform simple configuration to install WordPress on AWS EC2, RDS, VPC and Security groups with the integration of ansible
#### Requirements
- Terraform v0.12.12
- Ansible v2.8.5
#### Deployment
- Configure "terraform.tfvars" file with your environment configurations.
- Add your AWS Authentication public/private key inside ansible/keys directory

*It's also recommended to use IAM user/role for authentication*
