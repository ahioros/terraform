#VPC
resource "aws_vpc" "customervpc" {
  cidr_block           = "192.168.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "customervpc"
  }
}

# subnet public
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.customervpc.id
  cidr_block              = "192.168.0.0/24"
  availability_zone       = "us-west-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet"
  }
}

# subnet private
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.customervpc.id
  cidr_block        = "192.168.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "private_subnet"
  }
}

# internet gateway
resource "aws_internet_gateway" "internet_gw" {
  vpc_id = aws_vpc.customervpc.id
  tags = {
    Name = "Internet_Gateway"
  }
}

# route table
resource "aws_route_table" "route_table" {

  vpc_id = aws_vpc.customervpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gw.id
  }
  tags = {
    Name = "route_table everywhere"
  }
}

# associate rt to public_subnet
resource "aws_route_table_association" "nat_public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.route_table.id
}

# create eip for nat gw
resource "aws_eip" "nat_eip" {
  vpc = true
}

# nat gw
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "gw NAT"
  }
  depends_on = [aws_internet_gateway.internet_gw]
}

# create rt subnet_private-nat_gw
resource "aws_route_table" "route_table_nat" {
  vpc_id = aws_vpc.customervpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = {
    Name = "route table private_nat"
  }
}

# associate rt subnet_private
resource "aws_route_table_association" "nat_private" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.route_table_nat.id
}

# security groups
resource "aws_security_group" "bastion_ssh" {
  name        = "bastion_ssh"
  description = "Allow ssh"
  vpc_id      = aws_vpc.customervpc.id

  ingress {
    description = "ingress ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "egress ssh"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_ssh"
  }
}

# security group http
resource "aws_security_group" "webserver_http" {
  name        = "webserver_http"
  description = "Allow http in traffic"
  vpc_id      = aws_vpc.customervpc.id

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "ssh"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_ssh.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = "allow_http"
  }
}

# security group mysql
resource "aws_security_group" "security_group_mysql" {
  name        = "security_group_mysql"
  description = "Allow mysql in traffic"
  vpc_id      = aws_vpc.customervpc.id

  ingress {
    description     = "mysql"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.webserver_http.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "security_group_mysql"
  }
  depends_on = [aws_security_group.webserver_http, aws_security_group.bastion_ssh]
}