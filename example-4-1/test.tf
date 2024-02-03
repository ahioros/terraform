# set locals
locals {
  type = "t2.micro"
  ami  = "ami-whatever"
  tags = {
    Project = "Example 4"
  }
  #   subnet = aws_subnet.mysubnet
}

variable "my_subnets" {
  type = set(string)
  default = [
    "192.168.0.0/24",
    "192.168.1.0/24",
    "192.168.2.0/24",
  ]
}

#create a vpc
resource "aws_vpc" "myvpc" {
  cidr_block = "192.168.0.0/16"
  tags       = local.tags
}

#create a network
resource "aws_subnet" "mysubnet" {
  for_each   = var.my_subnets
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = each.key
  tags       = local.tags
}