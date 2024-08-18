resource "aws_vpc" "examplevpc" {
  cidr_block           = "192.168.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  tags = {
    Name = "examplevpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.examplevpc.id
  cidr_block              = "192.168.0.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = "true"
  tags = {
    "Name" = "Public_subnet"
  }
}

resource "aws_instance" "test_instance-1" {
  ami                         = "test-ami"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = "true"
  tags = {
    Name = "public_server-1"
  }
}