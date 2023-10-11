#Terraform Code to create the below Infrastructure:

# 1.VPC in us-east-1 region. This should be flexible based on region. If no region is provided, this should be built in us -east-1.
provider "aws" {
  region = var.region
}

resource "aws_vpc" "govin-vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "govin-vpc"
  }
}

# In this , we use the aws provider to specify the region where we want to create the VPC. We also create a new aws_vpc resource with the specified CIDR block and tags.
If no region is provided, the aws provider will default to the us-east-1 region.
# 2.Subnet with high availablity supported in 2 zones 
resource "aws_subnet" "govin-subnet" {
  vpc_id     = aws_vpc.govin-vpc.id
  cidr_block = var.cidr_block

  availability_zone = "${var.region}a"
  tags = {
    Name = "main-a"
  }
}

resource "aws_subnet" "replica" {
  vpc_id     = aws_vpc.govin-vpc.id
  cidr_block = var.cidr_block

  availability_zone = "${var.region}b"
  tags = {
    Name = "main-b"
  }
}
#. Autoscaling group with a flexible cool down, deregistartion delay, instance warm up.
To create an autoscaling group with a flexible cool down, deregistration delay, and instance warm-up, we can use the following Terraform code 

resource "aws_autoscaling_group" "aws-asg" {
  name                 = "aws-asg"
  launch_configuration = aws_launch_configuration.aws-asg.id
  min_size             = 1
  max_size             = 3
  desired_capacity     = 2
  health_check_grace_period = var.health_check_grace_period
  default_cooldown     = var.default_cooldown
  termination_policies = ["OldestInstance"]
  vpc_zone_identifier  = [aws_subnet.govin-subnet.id]
}

resource "aws_launch_configuration" "govin" {
  name_prefix                 = "govin"
  image_id                    = var.image_id
  instance_type               = var.instance_type
  security_groups             = [aws_security_group.example.id]
  user_data                   = var.user_data
  associate_public_ip_address = false
}

resource "aws_security_group" "govin-asg" {
  name_prefix = "govin-asg"
}

resource "aws_subnet" "govin-subnet" {
  cidr_block = var.cidr_block
}
