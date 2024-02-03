
# set locals
locals {
  type = "t2.micro"
  ami  = "ami-whatever"
  tags = {
    Project = "Example 4"
  }
  nic    = aws_network_interface.my_nic.id
  subnet = aws_subnet.mysubnet
}

#create a vpc
resource "aws_vpc" "myvpc" {
  cidr_block = "192.168.0.0/16"
  tags       = local.tags
}

#create a network
resource "aws_subnet" "mysubnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "192.168.0.0/24"
  tags       = local.tags
}

# create an instance
resource "aws_instance" "ec2_instance" {
  ami           = local.ami
  instance_type = local.type
  network_interface {
    network_interface_id = local.nic
    device_index         = 0
  }
  tags = local.tags
}

# create a network interface
resource "aws_network_interface" "my_nic" {
  subnet_id   = local.subnet.id
  description = "My nic"
  tags        = local.tags
}