#variable implementation VPC
resource "aws_vpc" "govin-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "govin-vpc"
  }
}
#variable 



#variables implementation
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
# Define an input variable for the EC2 instance AMI ID
variable "ami_id" {
  description = "EC2 AMI ID"
  type        = string
}

# Configure the AWS provider using the input variables
provider "aws" {
  region      = "us-east-1"
}



#configure aws listner
variable "listener" {
  type = object({
    load_balancer_arn = aws_lb.front_end.arn
    port              = "443"
    protocol          = "HTTPS"
    ssl_policy        = "ELBSecurityPolicy-2016-08"
    certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"
    default_action    = object({
      type             = "forward"
      target_group_arn = aws_lb_target_group.front_end.arn
    })
  })
}
