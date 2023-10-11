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
#. ALB to load-balance the app servers. Ensure the port is flexible based on the application
. IAM roles should be only be used by account owner.

resource "aws_launch_configuration" "govin-alc" {
  name_prefix                 = "govin-alc"
  image_id                    = var.image_id
  instance_type               = var.instance_type
  security_groups             = [aws_security_group.govin-sg.id]
  user_data                   = var.user_data
  associate_public_ip_address = false
}

resource "aws_security_group" "govin-sg" {
  name_prefix = "govin-aws-sg"
}

resource "aws_autoscaling_group" " aws-asg " {
  name                 = "aws-asg"
  launch_configuration = aws_launch_configuration.govin-alc.id
  min_size             = 2
  max_size             = 2
  desired_capacity     = 2
  health_check_grace_period = var.health_check_grace_period
  default_cooldown     = var.default_cooldown
  termination_policies = ["OldestInstance"]
  vpc_zone_identifier  = [aws_subnet.example.id]
}

resource "aws_lb" "govin-lb" {
  name               = "govin-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.govin-subnet.id]
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = var.port
  protocol          = var.protocol

  default_action {
    target_group_arn = aws_lb_target_group.front_end.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "govin-lb-target" {
  name_prefix      = "govin-lb-target"
  port             = var.port
  protocol         = var.protocol
  vpc_id           = aws_vpc.govin-vpc.id

  health_check {
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    interval            = var.interval
    path                = var.path
    port                = var.port
    protocol            = var.protocol
    timeout             = var.timeout
    matcher             = var.matcher
  }
}
