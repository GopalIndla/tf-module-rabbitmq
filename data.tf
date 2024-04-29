# datasource that reads the info from vpc statefile 
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "b57-tf-state-bucket"
    key    = "dev/vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

# Datasource for AMI 
data "aws_ami" "ami" {
  most_recent      = true
  name_regex       = "centos8-with-ansible"     # Give the AMI ID of the AMI Created with Ansible Installed ( Use the base image as centos-8 lab image )
  owners           = ["355449129696"]           # give your aws account number 
}

