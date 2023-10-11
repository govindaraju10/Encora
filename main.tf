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
